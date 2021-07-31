import 'package:flutter/material.dart';
import 'package:guvenfuturetask/viewmodel/task_state_model.dart';
import 'package:provider/provider.dart';
import 'view/homapage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Homepage(),
    );
  }
}
