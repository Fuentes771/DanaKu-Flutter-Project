import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/providers.dart';
import '../../core/formatters.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/category.dart';
import '../../data/models/transaction.dart';
import '../../core/theme.dart';
import '../../widgets/transaction_tile.dart';
import '../../widgets/brand_background.dart';
import '../../widgets/app_logo.dart';
import '../../core/design_system.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final finance = theme.extension<FinanceColors>();
    final txsAsync = ref.watch(transactionsProvider);
    final txs = txsAsync.value ?? [];
    final cats = ref.watch(categoriesProvider).value ?? [];
    final balance = txs.fold<int>(
      0,
      (sum, t) => t.type.name == 'income' ? sum + t.amount : sum - t.amount,
    );
    final recent = txs.take(5).toList();

    // Calculate statistics
    final now = DateTime.now();
    final thisMonth = txs.where(
      (t) => t.date.year == now.year && t.date.month == now.month,
    );
    final monthIncome = thisMonth
        .where((t) => t.type == TransactionType.income)
        .fold<int>(0, (s, t) => s + t.amount);
    final monthExpense = thisMonth
        .where((t) => t.type == TransactionType.expense)
        .fold<int>(0, (s, t) => s + t.amount);
    final monthSavings = monthIncome - monthExpense;

    // Last 7 days trend
    final last7Days = List.generate(
      7,
      (i) => now.subtract(Duration(days: 6 - i)),
    );
    final dailyExpenses = last7Days.map((day) {
      return txs
          .where(
            (t) =>
                t.type == TransactionType.expense &&
                t.date.year == day.year &&
                t.date.month == day.month &&
                t.date.day == day.day,
          )
          .fold<int>(0, (s, t) => s + t.amount)
          .toDouble();
    }).toList();

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
                      Text(
                        'Beranda',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.lg),
                  // Main Balance Card dengan gradient
                  Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Radii.xl),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .1),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Saldo',
                                      style: TextStyle(
                                        color: theme.colorScheme.primary
                                            .withValues(alpha: 0.7),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      formatRupiah(balance),
                                      style: TextStyle(
                                        color: theme.colorScheme.primary,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.account_balance_wallet,
                                    color: theme.colorScheme.primary,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.05,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildQuickStat(
                                      icon: Icons.trending_up,
                                      label: 'Pemasukan',
                                      amount: formatRupiah(monthIncome),
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 40,
                                    color: theme.colorScheme.primary.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildQuickStat(
                                      icon: Icons.trending_down,
                                      label: 'Pengeluaran',
                                      amount: formatRupiah(monthExpense),
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: -0.1, end: 0),
                  const SizedBox(height: 16),
                  // Quick Actions
                  Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                              context: context,
                              label: 'Pemasukan',
                              icon: Icons.add_circle,
                              color: finance?.income ?? Colors.green,
                              onTap: () => context.push(
                                '/app/transactions/add?type=income',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildActionButton(
                              context: context,
                              label: 'Pengeluaran',
                              icon: Icons.remove_circle,
                              color: finance?.expense ?? Colors.red,
                              onTap: () => context.push(
                                '/app/transactions/add?type=expense',
                              ),
                            ),
                          ),
                        ],
                      )
                      .animate(delay: 100.ms)
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 16),
                  // Statistics Grid
                  Container(
                        padding: const EdgeInsets.all(Spacing.lg),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(Radii.lg),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ringkasan Bulan Ini',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildStatCard(
                                    context: context,
                                    title: 'Tabungan',
                                    value: formatRupiah(monthSavings),
                                    icon: Icons.savings,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildStatCard(
                                    context: context,
                                    title: 'Transaksi',
                                    value: '${thisMonth.length}',
                                    icon: Icons.receipt_long,
                                    color: finance?.expense ?? Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      .animate(delay: 200.ms)
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 16),
                  // Spending Trend Chart
                  Container(
                        padding: const EdgeInsets.all(Spacing.lg),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(Radii.lg),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tren 7 Hari',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () => context.go('/app/analytics'),
                                  icon: const Icon(Icons.analytics, size: 16),
                                  label: const Text(
                                    'Detail',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 120,
                              child: LineChart(
                                LineChartData(
                                  gridData: const FlGridData(show: false),
                                  titlesData: const FlTitlesData(show: false),
                                  borderData: FlBorderData(show: false),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: dailyExpenses
                                          .asMap()
                                          .entries
                                          .map(
                                            (e) => FlSpot(
                                              e.key.toDouble(),
                                              e.value,
                                            ),
                                          )
                                          .toList(),
                                      isCurved: true,
                                      color: finance?.expense ?? Colors.red,
                                      barWidth: 3,
                                      isStrokeCapRound: true,
                                      dotData: FlDotData(
                                        show: true,
                                        getDotPainter:
                                            (spot, percent, barData, index) {
                                              return FlDotCirclePainter(
                                                radius: 3,
                                                color: Colors.white,
                                                strokeWidth: 2,
                                                strokeColor:
                                                    finance?.expense ??
                                                    Colors.red,
                                              );
                                            },
                                      ),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        color: (finance?.expense ?? Colors.red)
                                            .withValues(alpha: 0.1),
                                      ),
                                    ),
                                  ],
                                  minY: 0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(7, (i) {
                                final day = last7Days[i];
                                return Text(
                                  [
                                    'Sen',
                                    'Sel',
                                    'Rab',
                                    'Kam',
                                    'Jum',
                                    'Sab',
                                    'Min',
                                  ][day.weekday - 1],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      )
                      .animate(delay: 300.ms)
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.1, end: 0),
                  const SizedBox(height: Spacing.lg),
                  // Recent Transactions
                  Container(
                    padding: const EdgeInsets.all(Spacing.lg),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(Radii.lg),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transaksi Terbaru',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextButton(
                              onPressed: () => context.go('/app/transactions'),
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
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
                                .firstWhere(
                                  (c) => c.id == t.categoryId,
                                  orElse: () => const AppCategory(
                                    id: '',
                                    name: 'Lainnya',
                                    type: CategoryType.expense,
                                  ),
                                )
                                .name;
                            final isIncome = t.type.name == 'income';
                            final amountTxt =
                                (isIncome ? '+' : '-') +
                                formatRupiah(t.amount).replaceFirst('Rp ', '');
                            return TransactionTile(
                                  title: t.note ?? 'Transaksi',
                                  subtitle:
                                      '$catName • ${formatDateShort(t.date)}',
                                  amountText: amountTxt,
                                  isIncome: isIncome,
                                  onTap: () => context.push(
                                    '/app/transactions/${t.id}/edit',
                                  ),
                                )
                                .animate(
                                  delay: Duration(milliseconds: 60 * index),
                                )
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

Widget _buildQuickStat({
  required IconData icon,
  required String label,
  required String amount,
  required Color color,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color.withValues(alpha: 0.9)),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget _buildActionButton({
  required BuildContext context,
  required String label,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(Radii.lg),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Radii.lg),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStatCard({
  required BuildContext context,
  required String title,
  required String value,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(Radii.md),
      border: Border.all(color: color.withValues(alpha: 0.2), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
