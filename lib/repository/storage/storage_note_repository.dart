import 'dart:async';

import 'package:oplin/db/models.dart';
import 'package:oplin/repository/note_repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:uuid/uuid.dart';

import '../../db/objectbox.g.dart';
import '../objectbox.dart';

/// {@template local_storage_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class StorageNoteRepository extends ObjectBoxX implements NoteRepository {
  /// {@macro local_storage_notes_api}
  StorageNoteRepository(Store store) : super(store) {
    _init();
  }

  final _noteStreamController = BehaviorSubject<List<Note>>.seeded(const []);

  void _init() {
    reader<Note, List<Note>>((box) => box.getAll()).then((notes) {
      _noteStreamController.add(notes);
    });
  }

  @override
  Stream<List<Note>> getNotes() => _noteStreamController.asBroadcastStream();

  @override
  Future<void> saveNote(Note note) async {
    var newNote = await writer<Note, Note>((box) {
      if (note.uuid.isEmpty) {
        note.uuid = const Uuid().v4();
        note.id = 0;
        box.put(note, mode: PutMode.insert);
      } else {
        box.put(note, mode: PutMode.put);
      }
      return note;
    });
    final notes = [..._noteStreamController.value];
    if (note.uuid.isEmpty) {
      notes.add(newNote);
    } else {
      final noteIndex = notes.indexWhere((t) => t.uuid == note.uuid);
      if (noteIndex >= 0) {
        notes[noteIndex] = note;
      } else {
        notes.add(note);
      }
    }
    _noteStreamController.add(notes);
  }

  @override
  Future<void> batchSaveNote(List<Note> notes) async {
    store.runInTransaction(TxMode.write, () {
      var box = store.box<Note>();
      for (var note in notes) {
        if (note.uuid.isEmpty) {
          note.uuid = const Uuid().v4();
          note.id = 0;
          box.put(note, mode: PutMode.insert);
        } else {
          box.put(note, mode: PutMode.update);
        }
      }
      return notes;
    });
    _init();
  }

  @override
  Future<void> deleteNote(String uuid, {bool physics = false}) async {
    await writer<Note, Note?>((box) {
      Note? newNotes = box.query(Note_.uuid.equals(uuid)).build().findFirst();
      if (newNotes == null) return null;
      if (physics) {
        box.remove(newNotes.id);
        return newNotes;
      }
      newNotes.deleted = true;
      newNotes.updateTime = DateTime.now();
      newNotes.synced = false;
      box.put(newNotes, mode: PutMode.update);
      return newNotes;
    });
    _init();
  }

  @override
  Future<void> batchDeleteNote(List<String> uuids,
      {bool physics = false}) async {
    await writer<Note, List<Note>>((box) {
      List<Note> newNotes = box.query(Note_.uuid.oneOf(uuids)).build().find();
      if (physics) {
        box.removeMany(newNotes.map((e) => e.id).toList());
        return newNotes;
      }
      for (var note in newNotes) {
        note.deleted = true;
        note.updateTime = DateTime.now();
        note.synced = false;
      }
      box.putMany(newNotes, mode: PutMode.update);
      return newNotes;
    });
    _init();
  }

  @override
  Future<Note?> findNote(String uuid) async {
    return await reader<Note, Note?>((box) {
      return box.query(Note_.uuid.equals(uuid)).build().findFirst();
    });
  }

  @override
  Future<List<Note>> findNotes(List<String> uuid) async {
    return await reader<Note, List<Note>>(
        (box) => box.query(Note_.uuid.oneOf(uuid)).build().find());
  }
}
