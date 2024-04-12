import 'package:flutter/material.dart';
import 'package:resume/screen/home_screen.dart';

void main() {
  runApp(MaterialApp(
    title: '자기소개글 작성',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomeScreen(),
  ));
}


