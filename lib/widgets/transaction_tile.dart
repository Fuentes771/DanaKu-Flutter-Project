import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.title, required this.subtitle, required this.amountText, required this.isIncome, this.onTap});

  final String title;
  final String subtitle;
  final String amountText;
  final bool isIncome;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = isIncome ? Colors.green : Colors.red;
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        child: Icon(isIncome ? Icons.arrow_downward : Icons.arrow_upward),
      ),
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Text(amountText, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
    );
  }
}
