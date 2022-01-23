import 'package:act_task/screen/home/home_screen.dart';
import 'package:act_task/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACT Task',
      navigatorKey: RM.navigate.navigatorKey,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFFFF4855,
          {
            50: Color(0xFFFF4855),
            100: Color(0xFFFF4855),
            200: Color(0xFFFF4855),
            300: Color(0xFFFF4855),
            400: Color(0xFFFF4855),
            500: Color(0xFFFF4855),
            600: Color(0xFFFF4855),
            700: Color(0xFFFF4855),
            800: Color(0xFFFF4855),
            900: Color(0xFFFF4855),
          },
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
