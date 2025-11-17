import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 72, this.animated = true});

  final double size;
  final bool animated;

  @override
  Widget build(BuildContext context) {
    final logo = SvgPicture.asset('assets/logo.svg', width: size, height: size);

    if (!animated) return logo;

    return logo
        .animate()
        .fadeIn(duration: 500.ms, curve: Curves.easeOut)
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 600.ms,
          curve: Curves.easeOutBack,
        );
  }
}
