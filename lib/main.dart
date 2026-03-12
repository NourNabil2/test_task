import 'package:flutter/material.dart';
import 'package:test_task/view/home_screen.dart';

void main() {
  runApp(const ColorTapApp());
}

/// Color test App
class ColorTapApp extends StatelessWidget {
  const ColorTapApp({super.key});

  /// title of the app.
  static const String _kAppTitle = 'Color Tap';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _kAppTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}