import 'package:assignments/src/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HundleTodo {
  static saveData(Todo todo) async {
    var shared = await SharedPreferences.getInstance();

    List<String> mData = shared.getStringList("TodoList") ?? [];

    mData.insert(0, todo.toJson());

    shared.setStringList("TodoList", mData);
  }

  static Future<List<Todo>> readAll() async {
    var shared = await SharedPreferences.getInstance();
    List<String> mData = shared.getStringList("TodoList") ?? [];

    List<Todo> todos = [];

    mData.forEach((element) {
      todos.add(Todo.fromJson(element));
    });
    return todos;
  }
}
