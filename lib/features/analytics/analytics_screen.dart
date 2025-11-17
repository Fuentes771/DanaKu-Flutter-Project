import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../core/formatters.dart';
import '../../data/models/category.dart';
import '../../data/models/transaction.dart';
import '../../core/theme.dart';
import '../../core/design_system.dart';
import 'dart:math' as math;

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<AppTransaction> txs = ref.watch(transactionsProvider).value ?? const <AppTransaction>[];
    final finance = Theme.of(context).extension<FinanceColors>();
    final cats = ref.watch(categoriesProvider).value ?? [];
    
    // Aggregate expense by category
    final expenseByCat = <String, int>{};
    for (final t in txs.where((e) => e.type.name == 'expense')) {
      expenseByCat[t.categoryId] = (expenseByCat[t.categoryId] ?? 0) + t.amount;
    }
    
    // Sort categories by amount
    final sortedCategories = expenseByCat.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    final sections = <PieChartSectionData>[];
    final colors = [Colors.red, Colors.orange, Colors.blue, Colors.purple, Colors.brown, Colors.teal, Colors.indigo];
    int i = 0;
    expenseByCat.forEach((catId, amount) {
      final cat = cats.firstWhere((c) => c.id == catId, orElse: () => AppCategory(id: 'unknown', name: 'Lainnya', type: CategoryType.expense));
      sections.add(PieChartSectionData(
        color: colors[i % colors.length],
        value: amount.toDouble(),
        title: cat.name,
        radius: 60,
        titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
      ));
      i++;
    });

    final totalIncome = txs.where((t) => t.type.name == 'income').fold<int>(0, (s, t) => s + t.amount);
    final totalExpense = txs.where((t) => t.type.name == 'expense').fold<int>(0, (s, t) => s + t.amount);
    final savings = totalIncome - totalExpense;
    final savingsRate = totalIncome > 0 ? (savings / totalIncome * 100) : 0.0;
    
    // Calculate daily average for last 30 days
    final now = DateTime.now();
    final last30Days = txs.where((t) => now.difference(t.date).inDays <= 30 && t.type == TransactionType.expense);
    final dailyAverage = last30Days.isEmpty ? 0 : last30Days.fold<int>(0, (s, t) => s + t.amount) ~/ 30;

    return Scaffold(
      appBar: AppBar(title: const Text('Analisis')),
      body: ListView(
        padding: const EdgeInsets.all(Spacing.lg),
        children: [
          // Summary Cards Row
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Pemasukan', style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 6),
                        Text(
                          formatRupiah(totalIncome),
                          style: TextStyle(color: finance?.income ?? Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Pengeluaran', style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 6),
                        Text(
                          formatRupiah(totalExpense),
                          style: TextStyle(color: finance?.expense ?? Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Second Row - Savings and Daily Average
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tabungan', style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 6),
                        Text(
                          formatRupiah(savings),
                          style: TextStyle(
                            color: savings >= 0 ? Colors.blue : Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Rata-rata/Hari', style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 6),
                        Text(
                          formatRupiah(dailyAverage),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Cash Flow Card
          Card(
            color: savings >= 0 ? Colors.green[50] : Colors.orange[50],
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: savings >= 0 ? Colors.green[100] : Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      savings >= 0 ? Icons.trending_up : Icons.trending_down,
                      color: savings >= 0 ? Colors.green[700] : Colors.orange[700],
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          savings >= 0 ? 'Arus Kas Positif' : 'Arus Kas Negatif',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: savings >= 0 ? Colors.green[900] : Colors.orange[900],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          savings >= 0 
                            ? 'Pemasukan lebih besar dari pengeluaran'
                            : 'Pengeluaran melebihi pemasukan',
                          style: TextStyle(
                            fontSize: 12,
                            color: savings >= 0 ? Colors.green[700] : Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatRupiah(savings.abs()),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: savings >= 0 ? Colors.green[700] : Colors.orange[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Savings Rate Progress
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tingkat Tabungan', style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('${savingsRate.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: (savingsRate / 100).clamp(0.0, 1.0),
                      minHeight: 12,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        savingsRate >= 20 ? Colors.green : savingsRate >= 10 ? Colors.orange : Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    savingsRate >= 20 ? 'Bagus! Terus pertahankan' : savingsRate >= 10 ? 'Lumayan, bisa ditingkatkan' : 'Perlu lebih hemat',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Monthly Bar Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Perbandingan Bulanan', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: _getMaxMonthlyValue(txs) * 1.2,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final idx = value.toInt();
                                final dt = DateTime.now().subtract(Duration(days: (5 - idx) * 30));
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text('${dt.month}/${dt.year % 100}', style: const TextStyle(fontSize: 10)),
                                );
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: _getMonthlyBarGroups(txs, finance),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem('Pemasukan', finance?.income ?? Colors.green),
                      const SizedBox(width: 16),
                      _buildLegendItem('Pengeluaran', finance?.expense ?? Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Weekly Trend
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tren Pengeluaran Mingguan', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: _getMaxWeeklyValue(txs) / 4,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey[300]!,
                              strokeWidth: 1,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const weeks = ['Mg 1', 'Mg 2', 'Mg 3', 'Mg 4'];
                                final idx = value.toInt();
                                if (idx >= 0 && idx < weeks.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(weeks[idx], style: const TextStyle(fontSize: 10)),
                                  );
                                }
                                return const Text('');
                              },
                              interval: 1,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            color: finance?.expense ?? Colors.red,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: Colors.white,
                                  strokeWidth: 2,
                                  strokeColor: finance?.expense ?? Colors.red,
                                );
                              },
                            ),
                            spots: _weeklySpots(txs),
                            belowBarData: BarAreaData(
                              show: true,
                              color: (finance?.expense ?? Colors.red).withOpacity(0.1),
                            ),
                          ),
                        ],
                        minX: 0,
                        maxX: 3,
                        minY: 0,
                        maxY: _getMaxWeeklyValue(txs) * 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Daily Spending Pattern
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pola Pengeluaran Harian', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  ..._buildDailyPattern(txs),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rendah', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                      Row(
                        children: [
                          Container(width: 12, height: 12, color: Colors.green[100]),
                          const SizedBox(width: 4),
                          Container(width: 12, height: 12, color: Colors.green[300]),
                          const SizedBox(width: 4),
                          Container(width: 12, height: 12, color: Colors.green[500]),
                          const SizedBox(width: 4),
                          Container(width: 12, height: 12, color: Colors.green[700]),
                        ],
                      ),
                      Text('Tinggi', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Pie Chart - Expense by Category
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pengeluaran per Kategori', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 260,
                    child: sections.isEmpty
                        ? const Center(child: Text('Belum ada data'))
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              PieChart(PieChartData(
                                sectionsSpace: 2,
                                centerSpaceRadius: 50,
                                sections: sections,
                              )),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    formatRupiah(totalExpense),
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const Text(
                                    'Total',
                                    style: TextStyle(fontSize: 11, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 12),
                  if (expenseByCat.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...expenseByCat.entries.toList().asMap().entries.map((entry) {
                          final idx = entry.key;
                          final catId = entry.value.key;
                          final amount = entry.value.value;
                          final cat = cats.firstWhere((c) => c.id == catId, orElse: () => AppCategory(id: 'unknown', name: 'Lainnya', type: CategoryType.expense));
                          final color = colors[idx % colors.length];
                          final percentage = totalExpense > 0 ? (amount / totalExpense * 100).toStringAsFixed(1) : '0';
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                                const SizedBox(width: 8),
                                Expanded(child: Text(cat.name)),
                                Text('$percentage%', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                const SizedBox(width: 8),
                                Text(formatRupiah(amount), style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Top Categories Horizontal Bar Chart
          if (sortedCategories.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Top 5 Kategori Pengeluaran', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    ...sortedCategories.take(5).toList().asMap().entries.map((entry) {
                      final idx = entry.key;
                      final catId = entry.value.key;
                      final amount = entry.value.value;
                      final cat = cats.firstWhere((c) => c.id == catId, orElse: () => AppCategory(id: 'unknown', name: 'Lainnya', type: CategoryType.expense));
                      final percentage = totalExpense > 0 ? amount / totalExpense : 0.0;
                      final color = colors[idx % colors.length];
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(cat.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                                Text(formatRupiah(amount), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: percentage,
                                minHeight: 8,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(color),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
          // Income vs Expense Comparison
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Perbandingan Detail', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.arrow_downward, color: finance?.income ?? Colors.green, size: 40),
                            const SizedBox(height: 8),
                            Text(
                              formatRupiah(totalIncome),
                              style: TextStyle(
                                color: finance?.income ?? Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('Pemasukan', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 80,
                        color: Colors.grey[300],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.arrow_upward, color: finance?.expense ?? Colors.red, size: 40),
                            const SizedBox(height: 8),
                            Text(
                              formatRupiah(totalExpense),
                              style: TextStyle(
                                color: finance?.expense ?? Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('Pengeluaran', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Selisih:', style: TextStyle(fontWeight: FontWeight.w500)),
                        Text(
                          formatRupiah(savings.abs()),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: savings >= 0 ? Colors.blue[700] : Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Line Chart - 6 Month Trend
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tren 6 Bulan Terakhir', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey[300]!,
                              strokeWidth: 1,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final idx = value.toInt();
                                final dt = DateTime.now().subtract(Duration(days: (5 - idx) * 30));
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text('${dt.month}/${dt.year % 100}', style: const TextStyle(fontSize: 10)),
                                );
                              },
                              interval: 1,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            color: finance?.income ?? Colors.green,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                            spots: _monthlySpots(txs, true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: (finance?.income ?? Colors.green).withOpacity(0.1),
                            ),
                          ),
                          LineChartBarData(
                            isCurved: true,
                            color: finance?.expense ?? Colors.red,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                            spots: _monthlySpots(txs, false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: (finance?.expense ?? Colors.red).withOpacity(0.1),
                            ),
                          ),
                        ],
                        minX: 0,
                        maxX: 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem('Pemasukan', finance?.income ?? Colors.green),
                      const SizedBox(width: 16),
                      _buildLegendItem('Pengeluaran', finance?.expense ?? Colors.red),
                    ],
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

Widget _buildLegendItem(String label, Color color) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 6),
      Text(label, style: const TextStyle(fontSize: 12)),
    ],
  );
}

List<FlSpot> _monthlySpots(List<AppTransaction> txs, bool income) {
  final now = DateTime.now();
  final buckets = List<int>.filled(6, 0);
  for (final t in txs) {
    final monthsDiff = (now.year - t.date.year) * 12 + (now.month - t.date.month);
    if (monthsDiff >= 0 && monthsDiff < 6) {
      final isIncome = t.type.name == 'income';
      if (isIncome == income) buckets[5 - monthsDiff] += t.amount;
    }
  }
  return [for (int i = 0; i < 6; i++) FlSpot(i.toDouble(), buckets[i].toDouble())];
}

List<FlSpot> _weeklySpots(List<AppTransaction> txs) {
  final now = DateTime.now();
  final buckets = List<int>.filled(4, 0);
  for (final t in txs.where((t) => t.type == TransactionType.expense)) {
    final daysDiff = now.difference(t.date).inDays;
    if (daysDiff >= 0 && daysDiff < 28) {
      final weekIndex = 3 - (daysDiff ~/ 7);
      buckets[weekIndex] += t.amount;
    }
  }
  return [for (int i = 0; i < 4; i++) FlSpot(i.toDouble(), buckets[i].toDouble())];
}

double _getMaxWeeklyValue(List<AppTransaction> txs) {
  final spots = _weeklySpots(txs);
  if (spots.isEmpty) return 1000000;
  final max = spots.map((s) => s.y).reduce(math.max);
  return max > 0 ? max : 1000000;
}

double _getMaxMonthlyValue(List<AppTransaction> txs) {
  final incomeSpots = _monthlySpots(txs, true);
  final expenseSpots = _monthlySpots(txs, false);
  final allValues = [...incomeSpots.map((s) => s.y), ...expenseSpots.map((s) => s.y)];
  if (allValues.isEmpty) return 1000000;
  final max = allValues.reduce(math.max);
  return max > 0 ? max : 1000000;
}

List<Widget> _buildDailyPattern(List<AppTransaction> txs) {
  final now = DateTime.now();
  final Map<int, int> dailyExpense = {};
  
  // Aggregate last 28 days
  for (final t in txs.where((t) => t.type == TransactionType.expense)) {
    final daysDiff = now.difference(t.date).inDays;
    if (daysDiff >= 0 && daysDiff < 28) {
      dailyExpense[daysDiff] = (dailyExpense[daysDiff] ?? 0) + t.amount;
    }
  }
  
  final maxDaily = dailyExpense.values.isEmpty ? 1 : dailyExpense.values.reduce(math.max);
  final days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
  
  final rows = <Widget>[];
  for (int week = 0; week < 4; week++) {
    final cells = <Widget>[];
    cells.add(
      SizedBox(
        width: 32,
        child: Text('W${week + 1}', style: const TextStyle(fontSize: 10)),
      ),
    );
    for (int day = 0; day < 7; day++) {
      final dayIndex = (3 - week) * 7 + day;
      final amount = dailyExpense[dayIndex] ?? 0;
      final intensity = maxDaily > 0 ? (amount / maxDaily).clamp(0.0, 1.0) : 0.0;
      Color color = Colors.grey[200]!;
      if (intensity > 0) {
        if (intensity > 0.75) {
          color = Colors.green[700]!;
        } else if (intensity > 0.5) {
          color = Colors.green[500]!;
        } else if (intensity > 0.25) {
          color = Colors.green[300]!;
        } else {
          color = Colors.green[100]!;
        }
      }
      cells.add(
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      );
    }
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(children: cells),
      ),
    );
  }
  
  // Add day labels
  rows.insert(
    0,
    Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 32),
          ...days.map((d) => Expanded(
                child: Center(
                  child: Text(d, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
                ),
              )),
        ],
      ),
    ),
  );
  
  return rows;
}

List<BarChartGroupData> _getMonthlyBarGroups(List<AppTransaction> txs, FinanceColors? finance) {
  final incomeSpots = _monthlySpots(txs, true);
  final expenseSpots = _monthlySpots(txs, false);
  
  return List.generate(6, (index) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: incomeSpots[index].y,
          color: finance?.income ?? Colors.green,
          width: 12,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        BarChartRodData(
          toY: expenseSpots[index].y,
          color: finance?.expense ?? Colors.red,
          width: 12,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  });
}
