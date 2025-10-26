import 'package:flutter/material.dart';
import 'screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AidMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 194, 144, 17,),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(246, 244, 131, 3),
          foregroundColor: Color.fromARGB(255, 61, 4, 231),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.redAccent,
        ),
      ),
      home: const Homescreen(),
    );
  }
}
