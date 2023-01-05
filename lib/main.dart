import 'package:flutter/material.dart';
import 'package:trade/screens/login_screen.dart';
import 'package:trade/utils/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trade',
      theme: ThemeData(
        primarySwatch: myPrimaryColor,
      ),
      home: const LoginScreen(),
    );
  }
}
