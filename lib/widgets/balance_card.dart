import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';
import '../core/design_system.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.title,
    required this.amount,
    this.trailing,
  });

  final String title;
  final String amount;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final finance = Theme.of(context).extension<FinanceColors>()!;
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [finance.accentGradientStart, finance.accentGradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(Radii.xl),
            boxShadow: Shadows.medium(finance.accentGradientStart),
            border: Border.all(
              color: Colors.white.withValues(alpha: .15),
              width: 1.2,
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        color: cs.onPrimary.withValues(alpha: 0.85),
                        fontSize: 12,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: Spacing.xs),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: 600.ms,
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) => ShaderMask(
                        shaderCallback: (rect) => LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white.withValues(alpha: 0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [value * 0.4, value],
                        ).createShader(rect),
                        blendMode: BlendMode.srcIn,
                        child: child,
                      ),
                      child: Text(
                        amount,
                        style: TextStyle(
                          color: cs.onPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: Spacing.md),
                trailing!,
              ],
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, curve: Curves.easeOut)
        .slideY(begin: 0.12, end: 0, duration: 400.ms, curve: Curves.easeOut)
        .blurXY(begin: 6, end: 0, duration: 600.ms);
  }
}
