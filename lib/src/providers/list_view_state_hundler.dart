import 'package:assignments/src/models/todo_model.dart';
import 'package:flutter/material.dart';

class TheListViewProvider extends ChangeNotifier {
  List<String> titlesID = [
    "todo",
    "assignment",
    "shop",
    "extra",
  ];

  List<Todo> get todos {
    List<Todo> temp = [];
    todo.forEach((element) {
      debugPrint(element.title);
      if (element.type == titlesID[selectedIndex]) {
        temp.add(element);
      }
    });

    return temp;
  }

  int selectedIndex = 0;

  List<Todo> todo = [];

  void setIdex(int index) {
    selectedIndex = index;
    notifyListeners();
  } 

  void changeTheTodos(List<Todo> todo) {
    this.todo = todo;
    notifyListeners(); 
  }

}
