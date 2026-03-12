# Color Tap App 🎨

A Flutter application that changes its background to a random color on every tap, with automatic high-contrast text adjustment.

---

## ✨ Features

| Feature | Details |
|---|---|
| Random Color Generation | Manual RGB randomization — 16,777,216 possible colors |
| Full-Screen Tap Detection | `GestureDetector` with `HitTestBehavior.opaque` |
| Automatic Text Contrast | `computeLuminance()` picks black or white text per WCAG |
| Smooth Transition | `AnimatedContainer` with 300 ms ease-in-out curve |

---

## 🏗 Architecture

```
lib/
├── main.dart           # App entry point & root widget
├── home_screen.dart    # UI layer (StatefulWidget)
└── color_generator.dart # Business logic (pure Dart class)
```

### Why this separation?

The project intentionally **decouples color generation from the UI**, applying the **Single Responsibility Principle** (SRP from SOLID):

- `ColorGenerator` owns *what* a color is and *how* to pick a contrasting text color.
- `HomeScreen` owns *how* to display that information and *when* to request a new color.
- This makes both units independently testable and replaceable.

---

## 🔧 Technical Decisions

### 1. Manual RGB generation (no third-party packages)
```dart
final int red   = _random.nextInt(256);
final int green = _random.nextInt(256);
final int blue  = _random.nextInt(256);
return Color.fromRGB(red, green, blue);
```
Using `dart:math`'s `Random` directly gives us uniform access to all **256³ = 16,777,216** colors without any external dependency.

### 2. WCAG-based contrast with `computeLuminance()`
```dart
final double luminance = backgroundColor.computeLuminance();
return luminance > 0.179 ? Colors.black : Colors.white;
```
The threshold `0.179` is derived from the WCAG 2.1 relative luminance formula. It guarantees a minimum contrast ratio of ~4.5:1, ensuring the "Hello there" label is always readable — a tangible UX improvement.

### 3. `HitTestBehavior.opaque` on `GestureDetector`
Without this flag, taps on the empty screen area (no child widget underneath) would fall through and not register. `opaque` makes the entire bounding box of the detector respond to input, regardless of visual content.

### 4. `const` constructors throughout
Every widget that does not depend on runtime state uses `const`, letting Flutter skip unnecessary rebuilds and reducing widget tree reconstruction cost.

### 5. Named constants instead of magic numbers
```dart
static const double _kGreetingFontSize = 32.0;
static const double _kLuminanceThreshold = 0.179;
static const int    _kMaxChannelValue    = 255;
```
Named constants make intent explicit and eliminate "magic number" lint warnings.

---

## 🧪 Testing

```bash
flutter test
```

Unit tests cover:
- Color values are within the valid 0–255 RGB range.
- Dark backgrounds produce white text.
- Light backgrounds produce black text.
- Multiple calls produce varied results (probabilistic).

---

## 🛠 Tools & Static Analysis

- **`flutter_lints`** — enforces Flutter best practices via `analysis_options.yaml`.
- Rules enabled include `prefer_const_constructors`, `prefer_final_fields`, `public_member_api_docs`, and more.
- Zero analyzer warnings in the codebase.

---

## 🚀 Getting Started

```bash
flutter pub get
flutter run
```

**Requirements:** Flutter ≥ 3.10 · Dart ≥ 3.0# test_task
# test_task
