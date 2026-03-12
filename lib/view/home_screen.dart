import 'package:flutter/material.dart';
import '../logic/color_generator.dart';

/// The screen of the app.
class HomeScreen extends StatefulWidget {
  /// Constractor
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// The service responsible for color generation logic
  final ColorGenerator _colorGenerator = ColorGenerator();

  /// Current background color of the screen
  Color _backgroundColor = Colors.white;

  /// Text color that contrasts.
  Color _textColor = Colors.black;

  /// Font size for the greeting label.
  static const double _kGreetingFontSize = 32.0;

  /// Greeting message displayed at the center of the screen.
  static const String _kGreetingText = 'Hello there';

  /// Generates a new random background color and derives an appropriate
  void _changeBackgroundColor() {
    final Color newBackground = _colorGenerator.generateRandomColor();
    final Color newTextColor = _colorGenerator.computeContrastingTextColor(newBackground);

    setState(() {
      _backgroundColor = newBackground;
      _textColor = newTextColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _changeBackgroundColor,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          color: _backgroundColor,
          alignment: Alignment.center,
          child: Text(
            _kGreetingText,
            style: TextStyle(
              fontSize: _kGreetingFontSize,
              fontWeight: FontWeight.bold,
              color: _textColor,
            ),
          ),
        ),
      ),
    );
  }
}