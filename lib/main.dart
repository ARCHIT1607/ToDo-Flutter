import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'registration_screen.dart';
import 'login_screen.dart';
import 'todo_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: 'HomeScreen.id',
      routes: {
        'HomeScreen.id':(context)=>HomeScreen(),
      },
      home: Scaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}
