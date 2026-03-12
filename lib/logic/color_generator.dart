import 'dart:math';
import 'package:flutter/material.dart';


/// Colors "light".
const double _kLuminanceThreshold = 0.179; // I used AI here to understand how to handle contrast colors.


/// Single responsibility principle from SOLID.
class ColorGenerator {
  /// Private random instance
  final Random _random = Random();
  static const int _kMaxChannelValue = 255;

  /// Generates a fully random Color by random
  /// RGB the full 0–255 range
  Color generateRandomColor() {
    final int red = _random.nextInt(_kMaxChannelValue + 1);
    final int green = _random.nextInt(_kMaxChannelValue + 1);
    final int blue = _random.nextInt(_kMaxChannelValue + 1);

    return Color.fromRGBO(red, green, blue, 1);
  }

  /// returning white for dark backgrounds and black for light backgrounds.
  Color computeContrastingTextColor(Color backgroundColor) {
    final double luminance = backgroundColor.computeLuminance();
    return luminance > _kLuminanceThreshold ? Colors.black : Colors.white;
  }
}