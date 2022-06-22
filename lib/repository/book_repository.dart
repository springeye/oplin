import 'package:oplin/db/models.dart';

abstract class BookRepository {
  const BookRepository();

  List<Notebook> getBooks();

  Notebook? findBook(String uuid);

  void saveBook(Notebook book);

  void deleteBook(String uuid, {bool physics = false});

  void batchDeleteBook(List<String> uuid, {bool physics = false});
}

class NotebookNotFoundException implements Exception {}
