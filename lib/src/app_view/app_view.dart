import 'package:assignments/src/main_view/main.dart';
import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainView(),
      },
    );
  }
}
