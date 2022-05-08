import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import '../models/todo_list_model.dart';
import '../providers/storage.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosLoading());

  TodosState get initialState {
    return TodosLoading();
  }

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodos) {
      yield* _mapAddTodosToState(event);
    } else if (event is UpdateTodos) {
      yield* _mapUpdateTodosToState(event);
    } else if (event is FindTodos) {
      yield* _mapFindTodosToState(event);
    } else if (event is SortTodos) {
      yield* _mapSortTodosToState(event);
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      final todos = await FileStorage().loadTodos();
      yield TodosLoaded(todos!, _loadOncoming(todos));
    } catch (_) {
      yield TodosNotLoaded();
    }
  }

  List<TodoModel> _loadOncoming(List<TodoModel> todos) {
    DateTime datenow = DateTime.now();
    DateTime todate = DateTime(datenow.year, datenow.month, datenow.day-1);
    final List<TodoModel> todosOncoming = todos
        .where((todo) =>
            DateFormat('yyyy-MM-dd').parse(todo.date).isAfter(todate)
                ? true
                : false)
        .toList();
    todosOncoming.sort((a, b) => a.date.compareTo(b.date));
    return todosOncoming;
  }

  Stream<TodosState> _mapFindTodosToState(FindTodos event) async* {
    final todos = await FileStorage().loadTodos();
    final List<TodoModel> finedTodos = todos!
        .where((todo) => todo.title.toLowerCase().contains(event.keyword) ||
                todo.description!.toLowerCase().contains(event.keyword)
            ? true
            : false)
        .toList();
    yield TodosLoaded(finedTodos, (state as TodosLoaded).todosOncoming);
  }

  Stream<TodosState> _mapSortTodosToState(SortTodos event) async* {
    if (state is TodosLoaded) {
      List<TodoModel> sortTodos = (state as TodosLoaded).todos;
      if (event.type == 'title') {
        sortTodos.sort((a, b) => a.title.compareTo(b.title));
      } else if (event.type == 'status') {
        sortTodos.sort((a, b) => a.status.compareTo(b.status));
      } else {
        sortTodos.sort((a, b) => a.date.compareTo(b.date));
      }
      if (event.sortMoreToLess == true) {
        sortTodos = sortTodos.reversed.toList();
      }
      yield TodosLoaded(sortTodos, (state as TodosLoaded).todosOncoming);
    }
  }

  Stream<TodosState> _mapAddTodosToState(AddTodos event) async* {
   
    if (state is TodosLoaded) {
    
      final List<TodoModel> updatedTodos =
          (state as TodosLoaded).todos.toList();
      updatedTodos.add(event.todo);      
      yield TodosLoaded(updatedTodos, _loadOncoming(updatedTodos));
      _saveTodos(updatedTodos);
    } else {
      final List<TodoModel> updatedTodos = [];
      updatedTodos.add(event.todo);
      yield TodosLoaded(updatedTodos, updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapUpdateTodosToState(UpdateTodos event) async* {
    final todos = await FileStorage().loadTodos();
    TodoModel updateTodoData = event.updateTodo;
    if (event.isUpdateState == true) {
      updateTodoData = TodoModel(
        id: event.updateTodo.id,
        title: event.updateTodo.title,
        date: event.updateTodo.date,
        status:
            event.updateTodo.status == 'COMPLETE' ? 'IN_PROGRESS' : 'COMPLETE',
        image: event.updateTodo.image,
        description: event.updateTodo.description,
      );
    }
    if(todos!=null){
    final List<TodoModel> updatedTodos = todos.map((todo) {
      return todo.id == event.updateTodo.id ? updateTodoData : todo;
    }).toList();
    
      List<TodoModel> sortTodos = (state as TodosLoaded).todos.map((todo) {
        return todo.id == event.updateTodo.id ? updateTodoData : todo;
      }).toList();

      yield TodosLoaded(sortTodos, _loadOncoming(updatedTodos));
      _saveTodos(updatedTodos);
    }
    
  }

  Future _saveTodos(List<TodoModel> todos) {
    return FileStorage().saveTodos(todos);
  }
}
