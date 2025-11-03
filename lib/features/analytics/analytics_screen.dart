import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../core/formatters.dart';
import '../../data/models/category.dart';
import '../../data/models/transaction.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final List<AppTransaction> txs = ref.watch(transactionsProvider).value ?? const <AppTransaction>[];
    final cats = ref.watch(categoriesProvider).value ?? [];
    // Aggregate expense by category
    final expenseByCat = <String, int>{};
    for (final t in txs.where((e) => e.type.name == 'expense')) {
      expenseByCat[t.categoryId] = (expenseByCat[t.categoryId] ?? 0) + t.amount;
    }
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

    return Scaffold(
      appBar: AppBar(title: const Text('Analisis')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Pemasukan'),
                        const SizedBox(height: 6),
                        Text(formatRupiah(totalIncome), style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Pengeluaran'),
                        const SizedBox(height: 6),
                        Text(formatRupiah(totalExpense), style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pengeluaran per Kategori'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 260,
                    child: sections.isEmpty
                        ? const Center(child: Text('Belum ada data'))
                        : PieChart(PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 0,
                            sections: sections,
                          )),
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                                const SizedBox(width: 8),
                                Expanded(child: Text(cat.name)),
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tren 6 Bulan (Pemasukan vs Pengeluaran)'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
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
                                return Text('${dt.month}/${dt.year % 100}', style: const TextStyle(fontSize: 10));
                              },
                              interval: 1,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            color: Colors.green,
                            barWidth: 2,
                            dotData: const FlDotData(show: false),
                            spots: _monthlySpots(txs, true),
                          ),
                          LineChartBarData(
                            isCurved: true,
                            color: Colors.red,
                            barWidth: 2,
                            dotData: const FlDotData(show: false),
                            spots: _monthlySpots(txs, false),
                          ),
                        ],
                        minX: 0,
                        maxX: 5,
                      ),
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

List<FlSpot> _monthlySpots(List<AppTransaction> txs, bool income) {
  // last 6 months index 0..5, aggregate per month
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
