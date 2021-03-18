import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flip_gesture/utils/constant_string.dart';
import 'package:flutter/material.dart';

import 'screen/home_page.dart';

DataSnapshot data;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (Firebase.apps.length == 0) {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: titleName,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage());
  }
}
