import 'package:floor/floor.dart';
import 'package:oplin/db/models.dart';

class TodoLevelConverter extends TypeConverter<TodoLevel, String> {
  @override
  TodoLevel decode(String value) {
    return TodoLevel.values.firstWhere((e) => e.name == value);
  }

  @override
  String encode(TodoLevel value) {
    return value.name;
  }
}
