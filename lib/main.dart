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
      debugShowCheckedModeBanner: false,
      title: 'ACT Task',
      navigatorKey: RM.navigate.navigatorKey,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFFFF4855,
          {
            50: AppColors.accent,
            100: AppColors.accent,
            200: AppColors.accent,
            300: AppColors.accent,
            400: AppColors.accent,
            500: AppColors.accent,
            600: AppColors.accent,
            700: AppColors.accent,
            800: AppColors.accent,
            900: AppColors.accent,
          },
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
