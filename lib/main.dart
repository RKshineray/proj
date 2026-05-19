import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'pages/login.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  if (
    Platform.isWindows ||
    Platform.isLinux ||
    Platform.isMacOS
  ) {

    sqfliteFfiInit();

    databaseFactory =
        databaseFactoryFfi;
  }

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