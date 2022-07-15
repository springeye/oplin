import 'package:injectable/injectable.dart';
import 'package:oplin/db/dao/todo_dao.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/book_repository.dart';

@Named("sqlite")
@Singleton(as: BookRepository)
class SQLiteBookRepository implements BookRepository {
  final TodoDao todoDao;

  SQLiteBookRepository(this.todoDao);

  @override
  void batchDeleteBook(List<String> uuid, {bool physics = false}) {
    // TODO: implement batchDeleteBook
  }

  @override
  void batchSaveBook(List<Book> books) {
    // TODO: implement batchSaveBook
  }

  @override
  void deleteBook(String uuid, {bool physics = false}) {
    // TODO: implement deleteBook
  }

  @override
  Book? findBook(String uuid) {
    // TODO: implement findBook
    throw UnimplementedError();
  }

  @override
  List<Book> getBooks() {
    // TODO: implement getBooks
    throw UnimplementedError();
  }

  @override
  void saveBook(Book book) {
    // TODO: implement saveBook
  }
}
