import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BrandBackground extends StatelessWidget {
  const BrandBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                  theme.colorScheme.primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
  Positioned(top: -60, left: -30, child: _circle(220, Colors.white.withValues(alpha: .06))),
  Positioned(bottom: -80, right: -20, child: _circle(280, Colors.white.withValues(alpha: .05))),
        if (child != null) Positioned.fill(child: child!),
      ],
    );
  }

  Widget _circle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(.95, .95), end: const Offset(1, 1), duration: 800.ms);
}
