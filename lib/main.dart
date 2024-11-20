import 'package:database/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyNoteApp());
}

class MyNoteApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notes App",
      home: HomePage(),
    );
  }
}