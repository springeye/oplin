import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../db/objectbox.g.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  final Store store;

  BaseCubit(super.state, this.store);

  Future<R> reader<M, R>(R Function(Box<M> box) runner) async {
    return runner(store.box<M>());
  }

  Future<R> writer<M, R>(R Function(Box<M> box) runner) async {
    return runner(store.box<M>());
  }

  Future<List<T>> query<T>(Condition<T>? conditions) {
    return reader<T, List<T>>((box) {
      return box.query(conditions).build().find();
    });
  }
}
