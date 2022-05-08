
import 'package:equatable/equatable.dart';

import '../models/todo_list_model.dart';

abstract class TodosState extends Equatable {
  const TodosState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class TodosLoading extends TodosState {
   @override
  String toString() => 'TodosLoading';
}


class TodosLoaded extends TodosState {
  final List<TodoModel> todos;
  final List<TodoModel> todosOncoming;

  const TodosLoaded([ this.todos = const [],this.todosOncoming = const []]) : super(todos);

  @override
  String toString() {    
    return 'TodosLoaded { todos : $todos, todosOncoming : $todosOncoming  }';
  }

  @override
  List<Object> get props => [todos];
}
class TodosNotLoaded extends TodosState {
  @override
  String toString() => 'TodosNotLoaded';
}