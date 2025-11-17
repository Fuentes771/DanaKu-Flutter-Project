import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/design_system.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.title, required this.subtitle, required this.amountText, required this.isIncome, this.onTap});

  final String title;
  final String subtitle;
  final String amountText;
  final bool isIncome;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
  final finance = Theme.of(context).extension<FinanceColors>();
  final fallbackIncome = const Color(0xFF079B4B);
  final fallbackExpense = const Color(0xFFDA3D2A);
  final color = isIncome ? (finance?.income ?? fallbackIncome) : (finance?.expense ?? fallbackExpense);
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Radii.lg),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(Radii.lg),
          boxShadow: Shadows.soft(color),
          border: Border(left: BorderSide(color: color, width: 4)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.sm),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(isIncome ? Icons.call_received : Icons.call_made, color: color),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.outline),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Spacing.md),
            Text(
              amountText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
