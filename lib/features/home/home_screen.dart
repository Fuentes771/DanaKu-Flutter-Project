import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/providers.dart';
import '../../core/formatters.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/category.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/transaction_tile.dart';
import '../../widgets/brand_background.dart';
import '../../widgets/app_logo.dart';
import '../../core/design_system.dart';

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
      body: Stack(
        children: [
          const Positioned.fill(child: BrandBackground()),
          Positioned.fill(
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(Spacing.lg),
                children: [
                  Row(
                    children: [
                      const AppLogo(size: 40, animated: false),
                      const SizedBox(width: Spacing.md),
                      Text('Beranda',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w800,
                          )),
                    ],
                  ),
                  const SizedBox(height: Spacing.lg),
                  // Content card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(Spacing.lg),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(Radii.xl),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: .15), blurRadius: 24, offset: const Offset(0, 12)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BalanceCard(title: 'Saldo Uang', amount: formatRupiah(balance)),
                        const SizedBox(height: Spacing.lg),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: () => context.push('/app/transactions/add?type=income'),
                                icon: const Icon(Icons.add),
                                label: const Text('Tambah Pemasukan'),
                              ),
                            ),
                            const SizedBox(width: Spacing.md),
                            Expanded(
                              child: FilledButton.tonalIcon(
                                onPressed: () => context.push('/app/transactions/add?type=expense'),
                                icon: const Icon(Icons.remove),
                                label: const Text('Tambah Pengeluaran'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Spacing.lg),
                        Text('Transaksi Terbaru', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: Spacing.sm),
                        if (recent.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: Spacing.md),
                            child: Center(child: Text('Belum ada transaksi')),
                          )
                        else
                          ...recent.asMap().entries.map((entry) {
                            final index = entry.key;
                            final t = entry.value;
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
                            )
                                .animate(delay: Duration(milliseconds: 60 * index))
                                .fadeIn(duration: 300.ms)
                                .slideY(begin: 0.06, end: 0, duration: 300.ms);
                          }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
