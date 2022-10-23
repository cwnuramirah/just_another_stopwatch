import 'package:flutter/material.dart';
import 'package:just_another_stopwatch/stopwatch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Another Stopwatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'WorkSans',
        useMaterial3: true,
      ),
      home: const StopwatchPage(),
    );
  }
}