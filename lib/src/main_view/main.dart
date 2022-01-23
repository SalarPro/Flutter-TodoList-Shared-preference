import 'package:alert/alert.dart';
import 'package:assignments/src/bottom_bar_screens/bottomNavigation_home.dart';
import 'package:assignments/src/models/todo_model.dart';
import 'package:assignments/src/providers/list_view_state_hundler.dart';
import 'package:assignments/src/service/hundle_todo_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Future setStreamer() async {
    var todos = await HundleTodo.readAll();

    Provider.of<TheListViewProvider>(context, listen: false)
        .changeTheTodos(todos);
  }

  List<Widget> _widgets = [
    BottomNavigationHome(),
    BottomNavigationHome(),
    BottomNavigationHome(),
    BottomNavigationHome(),
    BottomNavigationHome(),
  ];

  List<String> _widgetsTitle = [
    "Todo",
    "Assignment",
    "Shop",
    "Extra",
  ];

  final TextEditingController _totoTitleTDC = TextEditingController();
  final TextEditingController _totoBodyTDC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_widgetsTitle[
              Provider.of<TheListViewProvider>(context, listen: true)
                  .selectedIndex])),
      body: BottomNavigationHome(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'ToDo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in_outlined),
              label: 'Assignment'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded), label: 'Shop'),
          BottomNavigationBarItem(
              icon: Icon(Icons.extension_rounded), label: 'Extra'),
        ],
        onTap: (index) {
          setState(() {
            Provider.of<TheListViewProvider>(context, listen: false)
                .setIdex(index);
          });
        },
        currentIndex: Provider.of<TheListViewProvider>(context, listen: true)
            .selectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Future.delayed(Duration.zero, () => showAlert(context));
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }

  void showAlert(BuildContext context) {
    DateTime fromDate = DateTime.now();
    DateTime? dueDate;

    _totoBodyTDC.text = "";
    _totoTitleTDC.text = "";

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _totoTitleTDC,
                      decoration: InputDecoration(hintText: "Title"),
                    ),
                    TextField(
                      controller: _totoBodyTDC,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(200),
                      ],
                      decoration: InputDecoration(hintText: "Body"),
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime:
                                      DateTime.now().add(Duration(days: 1)),
                                  maxTime:
                                      DateTime.now().add(Duration(days: 31)),
                                  onConfirm: (date) {
                                dueDate = date;
                              }, currentTime: DateTime.now());
                            },
                            child: Text(
                              'Select Deu date',
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (dueDate != null) {
                            String type = "todo";
                            switch (Provider.of<TheListViewProvider>(context,
                                    listen: false)
                                .selectedIndex) {
                              case 0:
                                {
                                  type = "todo";
                                }
                                break;
                              case 1:
                                {
                                  type = "assignment";
                                }
                                break;
                              case 2:
                                {
                                  type = "shop";
                                }
                                break;
                              case 3:
                                {
                                  type = "extra";
                                }
                                break;
                            }
                            Todo todo = Todo(
                              id: "1",
                              title: _totoTitleTDC.text,
                              body: _totoBodyTDC.text,
                              dueDate: dueDate!,
                              addDate: fromDate,
                              type: type,
                            );

                            HundleTodo.saveData(todo);

                            Navigator.pop(context);

                            setStreamer();
                          } else {
                            Alert(message: 'Please Select Due Date').show();
                          }
                        },
                        child: Text("Save"))
                  ],
                ),
              ),
            ));
  }
}
