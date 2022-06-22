import 'package:oplin/bloc/base_cubit.dart';
import 'package:oplin/db/models.dart';
import 'package:uuid/uuid.dart';

import '../../../db/objectbox.g.dart';

class NotebookCubit extends BaseCubit<List<Notebook>> {
  NotebookCubit(Store store) : super([], store);

  Future<Notebook> add(String name) async {
    var notebook = await writer<Notebook, Notebook>((box) {
      Notebook notebook = Notebook()
        ..name = name
        ..uuid = const Uuid().v4();
      box.put(notebook);
      return notebook;
    });
    refresh();
    return notebook;
  }

  delete(List<String> uuids) async {
    var notes = store.runInTransaction(TxMode.write, () {
      var noteBox = store.box<Note>();
      var notebookBox = store.box<Notebook>();
      List<Notebook> notebooks =
          notebookBox.query(Notebook_.uuid.oneOf(uuids)).build().find();
      List<Note> results = [];
      for (var notebook in notebooks) {
        notebook.deleted = true;
        notebook.synced = false;
        notebookBox.put(notebook, mode: PutMode.update);

        //更新note
        noteBox
            .query(Note_.notebookId.equals(notebook.uuid))
            .build()
            .find()
            .forEach((note) {
          note.notebookId = null;
          note.synced = false;
          noteBox.put(note, mode: PutMode.update);
          results.add(note);
        });
      }
      return results;
    });

    store.close();
    refresh();
  }

  move(String uuid, String? parentUuid) async {
    await writer<Notebook, void>((box) {
      Notebook? notebook =
          box.query(Notebook_.uuid.equals(uuid)).build().findFirst();
      if (notebook != null) {
        notebook.parentId = parentUuid;
        notebook.synced = false;
        box.put(notebook, mode: PutMode.update);
      }
    });
    refresh();
  }

  sticky(List<String> noteIds) async {
    var notebooks = await writer<Notebook, List<Notebook>>((box) {
      List<Notebook> notebooks =
          box.query(Notebook_.uuid.oneOf(noteIds)).build().find();
      for (var notebook in notebooks) {
        notebook.sticky = !notebook.sticky;
        notebook.synced = false;
        box.put(notebook, mode: PutMode.update);
      }
      box.putMany(notebooks, mode: PutMode.update);
      return notebooks;
    });
    refresh();
  }

  refresh() async {
    await list("");
  }

  list(String query, {bool deleted = false}) async {
    List<Notebook> notebooks = await reader<Notebook, List<Notebook>>((box) {
      var queryBuilder = box.query(Notebook_.name
          .contains(query)
          .and(Notebook_.deleted.equals(deleted)));
      List<Notebook> notebooks = queryBuilder.build().find();
      return notebooks;
    });
    await reader<Note, List<Note>>((box) {
      for (var element in notebooks) {
        element.count = box
            .query(Note_.notebookId
                .equals(element.uuid)
                .and(Note_.deleted.equals(false)))
            .build()
            .count();
      }
      return [];
    });
    emit(notebooks);
  }
}
