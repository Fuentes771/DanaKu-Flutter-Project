import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/formatters.dart';
import '../../data/models/category.dart';
import '../../widgets/transaction_tile.dart';
import '../../widgets/empty_state.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  String? _selectedCategoryId; // null = Semua
  int _monthsRange = 0; // 0=Semua, 1=Bulan ini, 3, 6
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final txs = ref.watch(transactionsProvider).value ?? [];
    final cats = ref.watch(categoriesProvider).value ?? [];

    // Filtering
    DateTime? threshold;
    if (_monthsRange > 0) {
      threshold = DateTime.now().subtract(Duration(days: _monthsRange * 30));
    }
    final filtered = txs.where((t) {
      final catOk = _selectedCategoryId == null || t.categoryId == _selectedCategoryId;
      final dateOk = threshold == null || t.date.isAfter(threshold);
      final searchOk = _searchQuery.isEmpty || (t.note ?? '').toLowerCase().contains(_searchQuery.toLowerCase()) || t.amount.toString().contains(_searchQuery.replaceAll('.', '').replaceAll(',', ''));
      return catOk && dateOk && searchOk;
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
        actions: [
          IconButton(
            onPressed: () => context.push('/app/transactions/categories'),
            icon: const Icon(Icons.category),
            tooltip: 'Kategori',
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/app/transactions/add'),
        tooltip: 'Tambah Transaksi',
        child: const Icon(Icons.add),
      ),
      body: txs.isEmpty
          ? const EmptyState(icon: Icons.receipt_long, title: 'Belum ada transaksi', subtitle: 'Tambahkan transaksi pertamamu dengan tombol + di bawah ini')
          : RefreshIndicator(
              onRefresh: () async {
                await ref.read(transactionsProvider.notifier).load();
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: filtered.length + 1, // + header
                separatorBuilder: (_, __) => const Divider(height: 0),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildHeaderFilters(context, cats);
                  }
                  final t = filtered[index - 1];
                  final catName = cats
                      .whereType<AppCategory>()
                      .firstWhere((c) => c.id == t.categoryId, orElse: () => const AppCategory(id: '', name: 'Lainnya', type: CategoryType.expense))
                      .name;
                  final isIncome = t.type.name == 'income';
                  final amountTxt = (isIncome ? '+' : '-') + formatRupiah(t.amount).replaceFirst('Rp ', '');
                  final item = Dismissible(
                    key: ValueKey(t.id),
                    background: Container(
                      decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(0)),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(0)),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (_) async {
                      return await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Hapus Transaksi?'),
                              content: const Text('Tindakan ini tidak dapat dibatalkan.'),
                              actions: [
                                TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Batal')),
                                FilledButton.tonal(
                                  onPressed: () => Navigator.of(ctx).pop(true),
                                  style: FilledButton.styleFrom(foregroundColor: Colors.red),
                                  child: const Text('Hapus'),
                                ),
                              ],
                            ),
                          ) ??
                          false;
                    },
                    onDismissed: (_) async {
                      final removed = t;
                      final messenger = ScaffoldMessenger.of(context);
                      try {
                        await ref.read(transactionsProvider.notifier).remove(t.id);
                        if (!mounted) return;
                        messenger.clearSnackBars();
                        messenger.showSnackBar(
                          SnackBar(
                            content: const Text('Transaksi dihapus'),
                            action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () async {
                                await ref.read(transactionsProvider.notifier).add(removed);
                              },
                            ),
                          ),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        messenger.showSnackBar(const SnackBar(content: Text('Gagal menghapus transaksi')));
                      }
                    },
                    child: TransactionTile(
                      title: t.note ?? 'Transaksi',
                      subtitle: '$catName • ${formatDateShort(t.date)}',
                      amountText: amountTxt,
                      isIncome: isIncome,
                      onTap: () => context.push('/app/transactions/${t.id}/edit'),
                    ),
                  );
                  // Animate appearance
                  return item
                      .animate(delay: Duration(milliseconds: 40 * (index - 1)))
                      .fadeIn(duration: 300.ms)
                      .slideY(begin: 0.05, end: 0, duration: 300.ms, curve: Curves.easeOut);
                },
              ),
            ),
    );
  }

  Widget _buildHeaderFilters(BuildContext context, List<AppCategory?> cats) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Cari transaksi (catatan/nominal)',
              prefixIcon: Icon(Icons.search),
              isDense: true,
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => setState(() => _searchQuery = v),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String?>(
                  initialValue: _selectedCategoryId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  items: [
                    const DropdownMenuItem<String?>(value: null, child: Text('Semua')),
                    ...cats
                        .whereType<AppCategory>()
                        .map((c) => DropdownMenuItem<String?>(value: c.id, child: Text(c.name)))
                        ,
                  ],
                  onChanged: (val) => setState(() => _selectedCategoryId = val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildRangeChip('Semua', 0),
              _buildRangeChip('Bulan ini', 1),
              _buildRangeChip('3 bln', 3),
              _buildRangeChip('6 bln', 6),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRangeChip(String label, int months) {
    final selected = _monthsRange == months;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _monthsRange = months),
    );
  }
}
