import 'package:flutter/material.dart';
import '../logic/color_generator.dart';

/// The single screen of the app.
///
/// Displays a centered greeting and changes its background color to a
/// randomly generated value whenever the user taps anywhere on the screen.
/// Text color adapts automatically to maintain readability (WCAG contrast).
class HomeScreen extends StatefulWidget {
  /// Creates the [HomeScreen].
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// The service responsible for color generation logic.
  /// Kept as a field so [Random] is not re-instantiated on every rebuild.
  final ColorGenerator _colorGenerator = ColorGenerator();

  /// Current background color of the screen.
  Color _backgroundColor = Colors.white;

  /// Text color that contrasts with [_backgroundColor].
  Color _textColor = Colors.black;

  /// Font size for the greeting label (named constant to avoid magic numbers).
  static const double _kGreetingFontSize = 32.0;

  /// Greeting message displayed at the center of the screen.
  static const String _kGreetingText = 'Hello there';

  /// Generates a new random background color and derives an appropriate
  /// contrasting text color, then triggers a UI rebuild via [setState].
  void _changeBackgroundColor() {
    final Color newBackground = _colorGenerator.generateRandomColor();
    final Color newTextColor =
    _colorGenerator.computeContrastingTextColor(newBackground);

    setState(() {
      _backgroundColor = newBackground;
      _textColor = newTextColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// [GestureDetector] with [HitTestBehavior.opaque] ensures the entire
      /// screen surface is tappable, including areas without child widgets.
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