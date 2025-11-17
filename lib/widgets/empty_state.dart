import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/design_system.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.illustrationAsset,
  }) : assert(
         icon != null || illustrationAsset != null,
         'Provide either an icon or an illustrationAsset',
       );

  final IconData? icon;
  final String? illustrationAsset; // Optional SVG/PNG path
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (illustrationAsset != null)
                SvgPicture.asset(
                  illustrationAsset!,
                  width: 140,
                  height: 140,
                  colorFilter: ColorFilter.mode(cs.outline, BlendMode.srcIn),
                )
              else if (icon != null)
                Icon(icon, size: 72, color: cs.outline),
              const SizedBox(height: Spacing.md),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: Spacing.sm),
                Text(
                  subtitle!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: cs.outline),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
