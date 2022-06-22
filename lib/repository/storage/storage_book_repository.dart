import 'package:oplin/db/models.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:uuid/uuid.dart';

import '../../db/objectbox.g.dart';
import '../objectbox.dart';

class StorageBookRepository extends ObjectBoxX implements BookRepository {
  StorageBookRepository(super.store);

  /// Provides a [Stream] of all books.
  @override
  Future<List<Notebook>> getBooks() async =>
      await reader<Notebook, List<Notebook>>((box) => box.getAll());

  @override
  Future<Notebook?> findBook(String uuid) async =>
      await reader<Notebook, Notebook?>((box) {
        return box.query(Notebook_.uuid.equals(uuid)).build().findFirst();
      });

  /// Saves a [book].
  ///
  /// If a [book] with the same id already exists, it will be replaced.
  @override
  Future<void> saveBook(Notebook book) async {
    var newNote = await writer<Notebook, Notebook>((box) {
      if (book.uuid.isEmpty) {
        book.uuid = const Uuid().v4();
        book.id = 0;
        box.put(book, mode: PutMode.insert);
      } else {
        box.put(book, mode: PutMode.put);
      }
      return book;
    });
  }

  /// Deletes the book with the given id.
  ///
  /// If no book with the given id exists, a [BookNotFoundException] error is
  /// thrown.
  @override
  Future<void> deleteBook(String uuid, {bool physics = false}) async {
    await writer<Notebook, Notebook?>((box) {
      Notebook? newNotes =
          box.query(Notebook_.uuid.equals(uuid)).build().findFirst();
      if (newNotes == null) return null;
      if (physics) {
        box.remove(newNotes.id);
        return newNotes;
      }
      newNotes.deleted = true;
      newNotes.synced = false;
      box.put(newNotes, mode: PutMode.update);
      return newNotes;
    });
  }

  move(List<String> bookIds, String? bookId) async {
    for (var uuid in bookIds) {
      var book = await findBook(uuid);
      if (book != null) {
        book.parentId = bookId;
        await saveBook(book);
      }
    }
  }

  sticky(List<String> bookIds) async {
    for (var uuid in bookIds) {
      var book = await findBook(uuid);
      if (book != null) {
        book.sticky = !book.sticky;
        await saveBook(book);
      }
    }
  }
}
