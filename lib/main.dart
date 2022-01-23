import 'package:assignments/src/app_view/app_view.dart';
import 'package:assignments/src/providers/list_view_state_hundler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      child: const AppView(),
      providers: [
        ChangeNotifierProvider(create: (context) => TheListViewProvider()),
      ],
    ),
  );
}
