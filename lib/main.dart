import 'package:flutter/material.dart';
import 'package:shop_easy/home_screen.dart';
import 'package:shop_easy/shopping_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 190, 8, 8),
        ),
        fontFamily: 'Suwannaphum',
      ),
      home: const MyHomePage(),
    );
  }
}
