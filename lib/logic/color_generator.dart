import 'dart:math';
import 'package:flutter/material.dart';

/// Threshold for determining text contrast based on WCAG guidelines.
/// Colors with luminance above this value are considered "light".
const double _kLuminanceThreshold = 0.179;

/// Handles all color generation logic, completely decoupled from the UI layer.
/// Follows the Single Responsibility Principle (SRP) from SOLID.
class ColorGenerator {
  /// Private random instance reused across calls for efficiency.
  final Random _random = Random();

  /// Maximum value for an 8-bit color channel (inclusive).
  static const int _kMaxChannelValue = 255;

  /// Generates a fully random [Color] by independently randomizing
  /// each of the three RGB channels across the full 0–255 range,
  /// yielding access to all 16,777,216 possible colors.
  Color generateRandomColor() {
    final int red = _random.nextInt(_kMaxChannelValue + 1);
    final int green = _random.nextInt(_kMaxChannelValue + 1);
    final int blue = _random.nextInt(_kMaxChannelValue + 1);

    return Color.fromRGBO(red, green, blue, 1);
  }

  /// Determines whether [Colors.white] or [Colors.black] provides
  /// better readability against the given [backgroundColor].
  ///
  /// Uses [Color.computeLuminance] per the WCAG relative luminance formula,
  /// returning white for dark backgrounds and black for light backgrounds.
  Color computeContrastingTextColor(Color backgroundColor) {
    final double luminance = backgroundColor.computeLuminance();
    return luminance > _kLuminanceThreshold ? Colors.black : Colors.white;
  }
}