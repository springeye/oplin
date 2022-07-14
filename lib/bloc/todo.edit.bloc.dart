import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:oplin/bloc/todo_bloc.dart';
import 'package:oplin/db/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide freezed;
import 'package:oplin/repository/todo_repository.dart';

part 'todo.edit.bloc.freezed.dart';

part 'todo.edit.bloc.g.dart';

const freezed =
    Freezed(fromJson: true, toJson: true, toStringOverride: true, equal: true);

@singleton
class TodoEditBloc extends Bloc<TodoEditEvent, TodoEditState> {
  TodoEditBloc({
    required TodoRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(
          TodoEditState.initial(initialTodo: null),
        ) {
    on<TodoEditEvent>((event, emit) async {
      event.map(
        titleChanged: (event) => _onTitleChanged(event, emit),
        descriptionChanged: (event) => _onDescriptionChanged(event, emit),
        submitted: (event) async {
          await _onSubmitted(event, emit);
        },
        created: (event) async {
          var todo = await _onCreated(event, emit);
          // emit(TodoEditState.initial(initialTodo: null));
        },
      );
    });
  }

  final TodoRepository _todosRepository;

  void _onTitleChanged(
    TitleChanged event,
    Emitter<TodoEditState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<TodoEditState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
    Submitted event,
    Emitter<TodoEditState> emit,
  ) async {
    emit(state.copyWith(status: EditTodoStatus.loading));
    final todo = (state.initialTodo ?? Todo(title: '')).copyWith(
      title: state.title,
      description: state.description,
    );

    try {
      await _todosRepository.saveTodo(todo);
      emit(state.copyWith(status: EditTodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditTodoStatus.failure));
    }
  }

  Future<Todo> _onCreated(Created event, Emitter<TodoEditState> emit) async {
    var todo = Todo();
    await _todosRepository.saveTodo(todo);
    return todo;
  }
}

enum EditTodoStatus { initial, loading, success, failure }

extension EditTodoStatusX on EditTodoStatus {
  bool get isLoadingOrSuccess => [
        EditTodoStatus.loading,
        EditTodoStatus.success,
      ].contains(this);
}

@freezed
class TodoEditState with _$TodoEditState {
  const TodoEditState._();

  const factory TodoEditState({
    required EditTodoStatus status,
    Todo? initialTodo,
    String? title,
    String? description,
  }) = _TodoEditState;

  factory TodoEditState.initial({Todo? initialTodo}) => TodoEditState(
        status: EditTodoStatus.initial,
        initialTodo: initialTodo,
      );
}

@freezed
class TodoEditEvent with _$TodoEditEvent {
  const factory TodoEditEvent.titleChanged(String title) = TitleChanged;

  const factory TodoEditEvent.descriptionChanged(String description) =
      DescriptionChanged;

  const factory TodoEditEvent.submitted() = Submitted;

  const factory TodoEditEvent.created() = Created;
}
