import 'package:oplin/db/models.dart';

abstract class BookRepository {
  const BookRepository();

  List<Book> getBooks();

  Book? findBook(String uuid);

  void saveBook(Book book);

  void batchSaveBook(List<Book> books);

  void deleteBook(String uuid, {bool physics = false});

  void batchDeleteBook(List<String> uuid, {bool physics = false});
}

class NotebookNotFoundException implements Exception {}
