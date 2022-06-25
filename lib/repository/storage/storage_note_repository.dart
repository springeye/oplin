import 'package:oplin/db/models.dart';
import 'package:oplin/repository/note_repository.dart';
import 'package:uuid/uuid.dart';

import '../../db/objectbox.g.dart';
import '../objectbox.dart';

/// {@template local_storage_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class StorageNoteRepository extends ObjectBoxX implements NoteRepository {
  /// {@macro local_storage_notes_api}
  StorageNoteRepository(Store store) : super(store);

  @override
  List<Note> getNotes() => getBox<Note>().getAll();

  @override
  void saveNote(Note note) {
    var box = getBox<Note>();
    note.synced = false;
    note.updateTime = DateTime.now();
    note.version++;
    if (note.uuid.isEmpty) {
      note.uuid = const Uuid().v4();
      note.id = 0;
    }
    box.put(note, mode: PutMode.put);
  }

  @override
  void batchSaveNote(List<Note> notes) {
    store.runInTransaction(TxMode.write, () {
      var box = store.box<Note>();
      for (var note in notes) {
        note.synced = false;
        note.updateTime = DateTime.now();
        note.version++;
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
  }

  @override
  void deleteNote(String uuid, {bool physics = false}) {
    var box = getBox<Note>();
    Note? newNotes = box.query(Note_.uuid.equals(uuid)).build().findFirst();
    if (newNotes == null) return;
    if (physics) {
      box.remove(newNotes.id);
    }
    newNotes.deleted = true;
    newNotes.updateTime = DateTime.now();
    newNotes.synced = false;
    box.put(newNotes, mode: PutMode.update);
  }

  @override
  void batchDeleteNote(List<String> uuids, {bool physics = false}) {
    var box = getBox<Note>();
    List<Note> newNotes = box.query(Note_.uuid.oneOf(uuids)).build().find();
    if (physics) {
      box.removeMany(newNotes.map((e) => e.id).toList());
      return;
    }
    for (var note in newNotes) {
      note.deleted = true;
      note.updateTime = DateTime.now();
      note.synced = false;
    }
    box.putMany(newNotes, mode: PutMode.update);
  }

  @override
  Note? findNote(String uuid) {
    var box = getBox<Note>();
    return box.query(Note_.uuid.equals(uuid)).build().findFirst();
  }

  @override
  List<Note> findNotes(List<String> uuid) {
    var box = getBox<Note>();
    return box.query(Note_.uuid.oneOf(uuid)).build().find();
  }
}
