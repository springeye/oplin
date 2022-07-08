import 'package:isar/isar.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/isar_repository.dart';
import 'package:uuid/uuid.dart';

class IsarBookRepository extends IsarRepository implements BookRepository {
  IsarBookRepository(super.store);

  @override
  void batchDeleteBook(List<String> uuids, {bool physics = false}) {
    store.writeTxnSync((store) {
      List<Book> books = store.books
          .filter()
          .repeat(uuids, (q, String element) => q.uuidEqualTo(element).or())
          .buildInternal()
          .findAllSync();
      if (physics) {
        store.books.deleteAllSync(books.map((e) => e.id).toList());
      } else {
        for (var value in books) {
          value.deleted = true;
          value.synced = false;
        }
        store.books.putAllSync(books);
      }
      List<Note> needToDeleteNotes = [];
      for (var book in books) {
        needToDeleteNotes
            .addAll(store.notes.filter().uuidEqualTo(book.uuid).findAllSync());
      }
      store.notes.putAllSync(needToDeleteNotes);
    });
  }

  @override
  void batchSaveBook(List<Book> books) {
    store.writeTxnSync((store) {
      for (var book in books) {
        book.uuid = const Uuid().v4();
      }
      store.books.putAllSync(books);
    });
  }

  @override
  void deleteBook(String uuids, {bool physics = false}) {
    batchDeleteBook([uuids], physics: physics);
  }

  @override
  Book? findBook(String uuid) {
    return store.books.filter().uuidEqualTo(uuid).findFirstSync();
  }

  List<Book> findBooks(List<String> uuids) {
    QueryBuilder<Book, Book, QFilterCondition> builder = store.books.filter();
    var books = builder
        .repeat(uuids, (q, String element) => q.uuidEqualTo(element).or())
        .buildInternal()
        .findAllSync();
    for (var value in books) {
      value.count =
          store.notes.filter().notebookIdEqualTo(value.uuid).countSync();
    }
    return books;
  }

  @override
  List<Book> getBooks() {
    var books = store.books.where().findAllSync();
    for (var value in books) {
      value.count =
          store.notes.filter().notebookIdEqualTo(value.uuid).countSync();
    }
    return books;
  }

  @override
  void saveBook(Book book) {
    store.writeTxnSync((store) {
      book.uuid = const Uuid().v4();
      store.books.putSync(book);
    });
  }
}
