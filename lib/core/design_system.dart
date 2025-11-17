import 'package:flutter/material.dart';

/// Centralized spacing, radii, and shadow tokens to keep visuals consistent.
class Spacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 20.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

class Radii {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
}

class Shadows {
  static List<BoxShadow> soft(Color color) => [
        BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 6)),
      ];

  static List<BoxShadow> medium(Color color) => [
        BoxShadow(color: color.withValues(alpha: 0.12), blurRadius: 20, offset: const Offset(0, 10)),
      ];
}
