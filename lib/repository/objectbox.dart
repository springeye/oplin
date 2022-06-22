import '../db/objectbox.g.dart';

abstract class ObjectBoxX {
  final Store store;

  ObjectBoxX(this.store);

  List<T> query<T>(Condition<T>? conditions) {
    return store.box<T>().query(conditions).build().find();
  }

  Box<T> getBox<T>() {
    return store.box<T>();
  }
}
