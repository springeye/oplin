import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:oplin/bloc/app_cubit.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/server/webdav/webdav.dart';
import 'package:uuid/uuid.dart';

import '../repository/note_repository.dart';
import 'sync_state.dart';
import 'sync_event.dart';

@singleton
class SyncCubit extends Bloc<SyncEvent, SyncState> {
  late FutureOr<void> computation;
  final int duration = 60 * 5;
  final NoteRepository noteLogic;
  final BookBloc notebookLogic;

  SyncCubit(this.noteLogic, this.notebookLogic)
      : super(SyncState(type: SyncStateType.none)) {
    on<SyncSubscriptionRequested>(_sync);
  }

  Future<void> _sync(SyncSubscriptionRequested event,
      Emitter<SyncState> emit) async {
    if (state.type == SyncStateType.disabled) {
      return;
    }
    dynamic server = event.server;
    if (server is WebDAVConfig) {
      var client = WebDAVClient(server.url,
          user: server.username, password: server.password);
      try {
        emit(state.copyWith(type: () => SyncStateType.syncing));
        await _pullRemote(client);
        await _uploadLocal(client);
        emit(state.copyWith(type: () => SyncStateType.synced));
      } catch (e) {
        emit(state.copyWith(
            type: () => SyncStateType.error, error: () => e.toString()));
      }
    }
  }

  Future<void> _uploadLocal(WebDAVClient client) async {
    await client.ping();

    var notes = noteLogic.getNotes();

    notes = notes.where((e) => !e.synced).toList();
    appLog.debug("local files count ${notes.length}");
    for (var localNote in notes) {
      try {
        var remoteNote = await client.getNote(localNote.uuid);
        if (localNote.deleted) {
          appLog.debug("delete  note ${localNote.uuid}");
          client.delete(localNote);
          noteLogic.deleteNote(localNote.uuid, physics: true);
        } else if (localNote.version > remoteNote.version) {
          if (localNote.updateTime.isAfter(remoteNote.updateTime)) {
            appLog.debug("upload local to remote note ${localNote.uuid}");
            await client.uploadNote(localNote);
            localNote.synced = true;
            localNote.updateTime = DateTime.now();
            noteLogic.saveNote(localNote);
          } else {
            appLog.debug("冲突了,服务器的版比本地更新");
            remoteNote.conflict = remoteNote.uuid;
            remoteNote.uuid = const Uuid().v4();
            localNote.updateTime = DateTime.now();
            noteLogic.saveNote(remoteNote);
          }
        }
      } catch (e) {
        if (e is DioError) {
          if (e.response?.statusCode == 404) {
            await client.uploadNote(localNote);
          } else {
            rethrow;
          }
        }
      }
    }
  }

  Future<void> _pullRemote(WebDAVClient client) async {
    await client.ping();
    var files = await client.listNote();
    appLog.debug("remote files count ${files.length}");
    for (var element in files) {
      late Note remoteNote;
      try {
        remoteNote = await client.getNoteByName(element.name!);
      } catch (e, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: e,
          stack: stack,
        ));
        throw "远程笔记${element.name}无法读取";
      }
      var results = noteLogic.findNote(remoteNote.uuid);
      if (results == null) {
        appLog.debug("add remote to local note ${element.name}");
        //服务器有，但是本地没有
        remoteNote.synced = true;
        remoteNote.id = 0;
        noteLogic.saveNote(remoteNote);
      } else {
        //本地有，服务器也有
        var localNote = results;
        if (remoteNote.version > localNote.version) {
          if (remoteNote.updateTime.isAfter(localNote.updateTime)) {
            appLog.debug("update remote to local note ${element.name}");
            noteLogic.saveNote(remoteNote);
          } else {
            appLog.debug("远程和本地冲突拉");
            remoteNote.conflict = remoteNote.uuid;
            remoteNote.uuid = const Uuid().v4();
            remoteNote.id = 0;
            noteLogic.saveNote(remoteNote);
            //冲突了
          }
        }
      }
    }
    var recycledFiles = await client.listNote(recycled: true);
    for (var file in recycledFiles) {
      var name = file.name!;
      var uuid = name.substring(0, name.lastIndexOf("."));
      var note = noteLogic.findNote(uuid);
      if (note != null) {
        note.deleted = true;
        noteLogic.saveNote(note);
      }
    }
  }
}
