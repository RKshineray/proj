import 'package:flutter/material.dart';
import 'pages/login.dart';

void main() {
  runApp(TaskEasy());
}

class TaskEasy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'TaskEasy',

      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      home: LoginPage(),
    );
  }
}