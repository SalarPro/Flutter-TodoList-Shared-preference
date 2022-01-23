import 'dart:developer';

import 'package:assignments/src/models/todo_model.dart';
import 'package:assignments/src/providers/list_view_state_hundler.dart';
import 'package:assignments/src/service/hundle_todo_shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class BottomNavigationHome extends StatefulWidget {
  BottomNavigationHome({Key? key}) : super(key: key);

  @override
  _BottomNavigationHomeState createState() => _BottomNavigationHomeState();
}

class _BottomNavigationHomeState extends State<BottomNavigationHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setStreamer();
  }

  Future setStreamer() async {
    var todos = await HundleTodo.readAll();
    Provider.of<TheListViewProvider>(context, listen: false)
        .changeTheTodos(todos);
  }

  StreamingSharedPreferences? preferences;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          Provider.of<TheListViewProvider>(context, listen: true).todos.length,
      itemBuilder: (context, index) {
        Todo cTodo = Provider.of<TheListViewProvider>(context, listen: true)
            .todos[index];
        return Container(
          height: 100,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: [
              (Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cTodo.title ?? "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(cTodo.body ?? ""),
                ],
              )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("start At: "),
                        Text("${cTodo.addDate}".substring(0, 10)),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Duo to: "),
                        Text("${cTodo.dueDate}".substring(0, 10)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );

    return FutureBuilder<List<Todo>>(
      future: HundleTodo.readAll(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return CircularProgressIndicator();
        }
        ;

        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            Todo cTodo = snapshot.data![index];
            return Container(
              height: 100,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              color: Colors.grey[300],
              child: Stack(
                children: [
                  (Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cTodo.title ?? "",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(cTodo.body ?? "sasaasassa"),
                    ],
                  )),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${cTodo.addDate}".substring(0, 10)),
                        Text("${cTodo.dueDate}".substring(0, 10)),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
