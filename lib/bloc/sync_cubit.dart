import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/bloc/app_cubit.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/server/webdav/webdav.dart';
import 'package:uuid/uuid.dart';

import '../repository/note_repository.dart';

enum SyncState { none, syncing, synced, error, disabled }

class SyncCubit extends Cubit<SyncState> {
  late FutureOr<void> computation;
  final int duration = 60 * 5;
  final NoteRepository noteLogic;
  final BookBloc notebookLogic;

  SyncCubit(this.noteLogic, this.notebookLogic) : super(SyncState.none) {
    // Future.delayed(Duration(seconds: duration), _task);
    appLog.debug(
        "SyncLogicSyncLogicSyncLogicSyncLogicSyncLogicSyncLogicSyncLogicSyncLogic");
  }

  Future<void> sync(AppConfig config) async {
    if (state == SyncState.disabled) {
      return;
    }
    dynamic server = config.server;
    if (server is WebDAVConfig) {
      var client = WebDAVClient(server.url,
          user: server.username, password: server.password);
      try {
        emit(SyncState.syncing);
        _pullRemote(client);
        _uploadLocal(client);
      } catch (e) {
        print(e);
      } finally {
        emit(SyncState.synced);
      }
    }
  }

  void _uploadLocal(WebDAVClient client) async {
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

  void _pullRemote(WebDAVClient client) async {
    await client.ping();
    var files = await client.listNote();
    appLog.debug("remote files count ${files.length}");
    for (var element in files) {
      var remoteNote = await client.getNoteByName(element.name!);
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
