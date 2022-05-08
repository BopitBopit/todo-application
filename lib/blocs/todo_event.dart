import 'package:equatable/equatable.dart';
import '../models/todo_list_model.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodosEvent {
  @override
  String toString() {
    return 'LoadTodos';
  }

}

class LoadOncomingTodos extends TodosEvent {
  @override
  String toString() {
    return 'LoadOncomingTodos';
  }
}

class SortTodos extends TodosEvent {
  final String type;
  final bool sortMoreToLess;

  SortTodos(this.type,{this.sortMoreToLess = false}) : super([type,sortMoreToLess]);

  @override
  String toString() => 'SortTodos { type: $type, sort: $sortMoreToLess }';
}

class FindTodos extends TodosEvent {
  final String keyword;

  FindTodos(this.keyword) : super([keyword]);

  @override
  String toString() => 'FindTodos { keyword: $keyword }';
}

class AddTodos extends TodosEvent {
  final TodoModel todo;

  AddTodos(this.todo) : super([todo]);

  @override
  String toString() => 'AddTodos { todo: $todo }';
}

class UpdateTodos extends TodosEvent {
  final TodoModel updateTodo;
  final bool isUpdateState;

  UpdateTodos(this.updateTodo, this.isUpdateState) : super([updateTodo]);

  @override
  String toString() => 'UpdateTodos { updateTodo: $updateTodo , isUpdateState: $isUpdateState }';
}