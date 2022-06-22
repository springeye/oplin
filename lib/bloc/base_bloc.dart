import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../db/objectbox.g.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(super.initialState);

  Future<Store> getStore() async {
    return await openStore(directory: (await getTemporaryDirectory()).path);
  }

  Future<R> reader<M, R>(R Function(Box<M> box) runner) async {
    var store = await getStore();
    try {
      return runner(store.box<M>());
    } catch (e) {
      rethrow;
    } finally {
      store.close();
    }
  }

  Future<R> writer<M, R>(R Function(Box<M> box) runner) async {
    var store = await getStore();
    try {
      return runner(store.box<M>());
    } catch (e) {
      rethrow;
    } finally {
      store.close();
    }
  }

  Future<List<T>> query<T>(Condition<T>? conditions) {
    return reader<T, List<T>>((box) {
      return box.query(conditions).build().find();
    });
  }
}
