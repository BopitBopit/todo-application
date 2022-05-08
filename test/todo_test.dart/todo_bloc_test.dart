import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/blocs/todo_event.dart';
import 'package:todo_app/blocs/todo_state.dart';
import 'package:todo_app/models/todo_list_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('TodosBloc', () {
    late TodoListModel todoList;
    late TodoModel todo;

    final uuidMock = const Uuid().v1();

    final TodoModel todoAddMock = TodoModel(
      id: uuidMock,
      title: 'title_01',
      description: 'description_01',
      date: 'asd',
      status: 'IN_PROGRESS',
    );

    final TodoModel todoUpdateMock = TodoModel(
      id: uuidMock,
      title: 'title_01',
      description: 'description_01',
      date: 'asd',
      status: 'COMPLETE',
    );


    test('Todo start is loading state', () {
      TodosBloc _todosBloc = TodosBloc();
      expect(_todosBloc.state, TodosLoading());
    });

    blocTest<TodosBloc, TodosState>(
      'Load todo first time is not loaded state',
      build: () => TodosBloc(),
      act: (bloc) => bloc.add(LoadTodos()),
      expect: () => [TodosNotLoaded()],
    );

    blocTest<TodosBloc, TodosState>(
      'Add todo',
      build: () => TodosBloc(),
      act: (bloc) => bloc.add(AddTodos(todoAddMock)),
      expect: () => [
        TodosLoaded([todoAddMock])
      ],
    );


    blocTest<TodosBloc, TodosState>(
      'Update todo status',
      build: () => TodosBloc(),
      setUp: () {
      },
      act: (bloc) {
        bloc.add(AddTodos(todoUpdateMock));
        bloc.add(UpdateTodos(todoUpdateMock,true));
      },
      expect: () => [
        TodosLoaded([todoUpdateMock])
      ],
    );


    blocTest<TodosBloc, TodosState>(
      'Find todo',
      build: () => TodosBloc(),
      setUp: () {
      },
      act: (bloc) {
        bloc.add(AddTodos(todoUpdateMock));
        bloc.add(FindTodos('des'));
      },
      expect: () => [
        TodosLoaded([todoUpdateMock])
      ],
    );

    blocTest<TodosBloc, TodosState>(
      'Find todo, Not found case',
      build: () => TodosBloc(),
      setUp: () {
      },
      act: (bloc) {
        bloc.add(FindTodos('50'));
      },
      expect: () => [
      ],
    );

     blocTest<TodosBloc, TodosState>(
      'Sort todo',
      build: () => TodosBloc(),
      setUp: () {
      },
      act: (bloc) {
        bloc.add(AddTodos(todoUpdateMock));
        bloc.add(SortTodos('title',sortMoreToLess: true));
      },
      expect: () => [
        TodosLoaded([todoUpdateMock])
      ],
    );

     blocTest<TodosBloc, TodosState>(
      'Sort todo, Not found data case',
      build: () => TodosBloc(),
      setUp: () {
      },
      act: (bloc) {
        bloc.add(SortTodos('title',sortMoreToLess: true));
      },
      expect: () => [
      ],
    );


  });
}
