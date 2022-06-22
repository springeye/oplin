import 'package:oplin/db/models.dart';

abstract class BookRepository {
  const BookRepository();

  Future<List<Notebook>> getBooks();

  Future<Notebook?> findBook(String uuid);

  Future<void> saveBook(Notebook book);

  Future<void> deleteBook(String uuid, {bool physics = false});
}

class NotebookNotFoundException implements Exception {}
