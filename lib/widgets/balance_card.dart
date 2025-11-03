import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required this.title, required this.amount, this.trailing});

  final String title;
  final String amount;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [cs.primary, cs.secondary], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: cs.primary.withOpacity(0.25), blurRadius: 24, offset: const Offset(0, 12))],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: TextStyle(color: cs.onPrimary.withOpacity(0.9))),
              const SizedBox(height: 6),
              Text(amount, style: TextStyle(color: cs.onPrimary, fontSize: 28, fontWeight: FontWeight.w800)),
            ]),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    ).animate().fadeIn(duration: 350.ms, curve: Curves.easeOut).slideY(begin: 0.1, end: 0, duration: 350.ms);
  }
}
