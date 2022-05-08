import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/todo_list_model.dart';

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/todoq_data.json');
  }

  Future<List<TodoModel>?> loadTodos() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      final data = await json.decode(contents);
      return TodoListModel.fromJson(data).todo;
    } catch (e) {
      return null;
    }
  }

  Future<File> saveTodos(List<TodoModel> todo) async {
    final file = await _localFile;
    TodoListModel temp = TodoListModel(todo: todo);
    return file.writeAsString(jsonEncode(temp));
  }
}
