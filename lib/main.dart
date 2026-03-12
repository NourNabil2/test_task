import 'package:flutter/material.dart';
import 'package:test_task/view/home_screen.dart';

void main() {
  runApp(const ColorTapApp());
}

/// Root widget of the application.
///
/// Configured as a [StatelessWidget] with [const] constructor for optimal
/// performance — it never needs to rebuild itself.
class ColorTapApp extends StatelessWidget {
  /// Creates the [ColorTapApp].
  const ColorTapApp({super.key});

  /// Application title used by the OS task switcher.
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