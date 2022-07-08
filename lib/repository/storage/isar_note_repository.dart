import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/isar_repository.dart';
import 'package:oplin/repository/note_repository.dart';

@Singleton(as: NoteRepository)
class IsarNoteRepository extends IsarRepository implements NoteRepository {
  IsarNoteRepository(super.store);

  @override
  void batchDeleteNote(List<String> uuids, {bool physics = false}) {
    store.writeTxnSync((store) {
      QueryBuilder<Note, Note, QFilterCondition> builder = store.notes.filter();
      var notes = builder
          .repeat(uuids, (q, String element) => q.uuidEqualTo(element).or())
          .buildInternal()
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
    store.writeTxnSync((store) {
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
        .repeat(uuids, (q, String element) => q.uuidEqualTo(element).or())
        .buildInternal()
        .findAllSync();
    return notes;
  }

  @override
  List<Note> getNotes() {
    return store.notes.where().findAllSync();
  }

  @override
  void saveNote(Note note) {
    store.writeTxnSync((store) {
      store.notes.putSync(note);
    });
  }
}
