import 'package:flutter/material.dart';
import 'package:new_project/screens/ScreenThree.dart';
import 'package:new_project/screens/home_screen.dart';
import 'package:new_project/screens/screen_five.dart';
import 'package:new_project/screens/screen_four.dart';
import 'package:new_project/screens/screen_two.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'new project',
      home: ScreenTwo(),
    );
  }
}
