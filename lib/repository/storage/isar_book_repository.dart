import 'package:isar/isar.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/isar_repository.dart';
import 'package:uuid/uuid.dart';

class IsarBookRepository extends IsarRepository implements BookRepository {
  IsarBookRepository(super.store);

  @override
  void batchDeleteBook(List<String> uuids, {bool physics = false}) {
    store.writeTxnSync(() async {
      QueryBuilder<Book, Book, QFilterCondition> builder = store.books.filter();
      var books = builder
          .anyOf(
            uuids,
            (QueryBuilder<Book, Book, QFilterCondition> q, String uuid) =>
                q.uuidEqualTo(uuid),
          )
          .findAllSync();
      store.books.deleteAllSync(books.map((e) => e.id).toList());
    });
  }

  @override
  void batchSaveBook(List<Book> books) {
    store.writeTxnSync(() async {
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

  @override
  List<Book> findBooks(List<String> uuids) {
    QueryBuilder<Book, Book, QFilterCondition> builder = store.books.filter();
    var books = builder
        .anyOf(
          uuids,
          (QueryBuilder<Book, Book, QFilterCondition> q, String uuid) =>
              q.uuidEqualTo(uuid),
        )
        .findAllSync();
    return books;
  }

  @override
  List<Book> getBooks() {
    return store.books.where().findAllSync();
  }

  @override
  void saveBook(Book book) {
    store.writeTxnSync(() {
      book.uuid = const Uuid().v4();
      store.books.putSync(book);
    });
  }
}
