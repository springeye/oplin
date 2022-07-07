import 'package:isar/isar.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/isar_repository.dart';
import 'package:oplin/repository/note_repository.dart';

class IsarNoteRepository extends IsarRepository implements NoteRepository {
  IsarNoteRepository(super.store);

  @override
  void batchDeleteNote(List<String> uuids, {bool physics = false}) {
    store.writeTxnSync(() async {
      QueryBuilder<Note, Note, QFilterCondition> builder = store.notes.filter();
      var notes = builder
          .anyOf<String, Note>(
            uuids,
            (QueryBuilder<Note, Note, QFilterCondition> q, String uuid) =>
                q.uuidEqualTo(uuid),
          )
          .findAllSync();
      if (physics) {
        store.notes.deleteAllSync(notes.map((e) => e.id).toList());
      } else {
        for (var value in notes) {
          value.deleted = true;
          value.synced = false;
        }
        store.notes.putAllSync(notes);
      }
    });
  }

  @override
  void batchSaveNote(List<Note> notes) {
    store.writeTxnSync(() async {
      store.notes.putAllSync(notes);
    });
  }

  @override
  void deleteNote(String uuids, {bool physics = false}) {
    batchDeleteNote([uuids], physics: physics);
  }

  @override
  Note? findNote(String uuid) {
    return store.notes.filter().uuidEqualTo(uuid).findFirstSync();
  }

  @override
  List<Note> findNotes(List<String> uuids) {
    QueryBuilder<Note, Note, QFilterCondition> builder = store.notes.filter();
    var notes = builder
        .anyOf<String, Note>(
          uuids,
          (QueryBuilder<Note, Note, QFilterCondition> q, String uuid) =>
              q.uuidEqualTo(uuid),
        )
        .findAllSync();
    return notes;
  }

  @override
  List<Note> getNotes() {
    return store.notes.where().findAllSync();
  }

  @override
  void saveNote(Note note) {
    store.writeTxnSync(() {
      store.notes.putSync(note);
    });
  }
}
