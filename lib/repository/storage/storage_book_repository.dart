import 'package:oplin/common/logging.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:uuid/uuid.dart';

import '../../db/objectbox.g.dart';
import '../objectbox.dart';

class StorageBookRepository extends ObjectBoxX implements BookRepository {
  StorageBookRepository(super.store);

  @override
  List<Book> getBooks() {
    var books = getBox<Book>().getAll();
    var box = getBox<Note>();
    for (var book in books) {
      book.count =
          box.query(Note_.notebookId.equals(book.uuid)).build().count();
    }
    return books;
  }

  @override
  Book? findBook(String uuid) =>
      getBox<Book>().query(Book_.uuid.equals(uuid)).build().findFirst();

  /// Saves a [book].
  ///
  /// If a [book] with the same id already exists, it will be replaced.
  @override
  void saveBook(Book book) {
    batchSaveBook([book]);
  }

  /// Deletes the book with the given id.
  ///
  /// If no book with the given id exists, a [BookNotFoundException] error is
  /// thrown.
  @override
  void deleteBook(String uuid, {bool physics = false}) {
    batchDeleteBook([uuid], physics: physics);
  }

  void move(List<String> bookIds, String? bookId) {
    for (var uuid in bookIds) {
      var book = findBook(uuid);
      if (book != null) {
        book.parentId = bookId;
        saveBook(book);
      }
    }
  }

  void sticky(List<String> bookIds) {
    for (var uuid in bookIds) {
      var book = findBook(uuid);
      if (book != null) {
        book.sticky = !book.sticky;
        saveBook(book);
      }
    }
  }

  @override
  void batchDeleteBook(List<String> uuids, {bool physics = false}) {
    store.runInTransaction(TxMode.write, () {
      var bookBox = store.box<Book>();
      List<Book> books =
      bookBox.query(Book_.uuid.oneOf(uuids)).build().find();
      if (physics) {
        bookBox.removeMany(books.map((e) => e.id).toList());
      } else {
        for (var book in books) {
          book.deleted = true;
          book.synced = false;
        }
        bookBox.putMany(books, mode: PutMode.update);
      }
      //clear notebookId on notes
      var noteBox = store.box<Note>();
      for (var book in books) {
        List<Note> notes =
        noteBox.query(Note_.notebookId.equals(book.uuid)).build().find();
        for (var element in notes) {
          element.notebookId = null;
        }
        assert(noteBox
            .putMany(notes, mode: PutMode.update)
            .length ==
            notes.length);
      }
      return books;
    });
  }

  @override
  void batchSaveBook(List<Book> books) {
    store.runInTransaction(TxMode.write, () {
      var box = store.box<Book>();
      for (var book in books) {
        appLog.debug("batchSaveBook==>${book}\n");
        book.synced = false;
        if (book.uuid
            .trim()
            .isEmpty) {
          book.uuid = const Uuid().v4();
          book.id = 0;
        }
      }
      box.putMany(books);
      return books;
    });
  }
}
