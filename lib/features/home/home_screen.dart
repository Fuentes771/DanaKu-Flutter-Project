import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../core/formatters.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/category.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/transaction_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
  final txsAsync = ref.watch(transactionsProvider);
  final txs = txsAsync.value ?? [];
  final cats = ref.watch(categoriesProvider).value ?? [];
    final balance = txs.fold<int>(0, (sum, t) => t.type.name == 'income' ? sum + t.amount : sum - t.amount);
    final recent = txs.take(5).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BalanceCard(title: 'Saldo Uang', amount: formatRupiah(balance)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => context.push('/app/transactions/add?type=income'),
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Pemasukan'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () => context.push('/app/transactions/add?type=expense'),
                  icon: const Icon(Icons.remove),
                  label: const Text('Tambah Pengeluaran'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Transaksi Terbaru', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          if (recent.isEmpty)
            const Center(child: Text('Belum ada transaksi'))
          else
            ...recent.map((t) {
              final catName = cats
                  .whereType<AppCategory>()
                  .firstWhere((c) => c.id == t.categoryId, orElse: () => const AppCategory(id: '', name: 'Lainnya', type: CategoryType.expense))
                  .name;
              final isIncome = t.type.name == 'income';
              final amountTxt = (isIncome ? '+' : '-') + formatRupiah(t.amount).replaceFirst('Rp ', '');
              return TransactionTile(
                title: t.note ?? 'Transaksi',
                subtitle: '$catName • ${formatDateShort(t.date)}',
                amountText: amountTxt,
                isIncome: isIncome,
                onTap: () => context.push('/app/transactions/${t.id}/edit'),
              );
            }),
        ],
      ),
    );
  }
}
