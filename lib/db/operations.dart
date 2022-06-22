import 'package:oplin/db/objectbox.g.dart';

import 'models.dart';

Future<void> runWriteNote(Function callback) async {
  final store = await openStore();
  var box = store.box<Note>();
  callback(box);
  store.close();
}
