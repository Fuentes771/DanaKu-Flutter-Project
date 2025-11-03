import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../data/models/category.dart';
import '../../data/models/transaction.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final cats = ref.watch(categoriesProvider).value ?? [];
  final txs = ref.watch(transactionsProvider).value ?? [];
    return Scaffold(
      appBar: AppBar(title: const Text('Kategori')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<_NewCategoryResult>(
              context: context,
              builder: (_) => const _AddCategoryDialog());
          if (result != null) {
            final id = 'cat_${DateTime.now().microsecondsSinceEpoch}';
            await ref
                .read(categoriesProvider.notifier)
                .add(AppCategory(id: id, name: result.name, type: result.type));
          }
        },
        tooltip: 'Tambah Kategori',
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        itemCount: cats.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final c = cats[index];
          final icon = c.type == CategoryType.expense ? Icons.remove_circle : Icons.add_circle;
          final usedCount = _countUsage(txs, c.id);
          return Dismissible(
            key: ValueKey('cat_${c.id}'),
            background: Container(
              color: Colors.redAccent,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.redAccent,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (_) async {
              if (usedCount > 0) {
                await showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Tidak dapat menghapus'),
                    content: Text('Kategori ini dipakai oleh $usedCount transaksi. Hapus atau ubah transaksi terkait terlebih dahulu.'),
                    actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Tutup'))],
                  ),
                );
                return false;
              }
              final ok = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Hapus Kategori?'),
                      content: const Text('Tindakan ini tidak dapat dibatalkan.'),
                      actions: [
                        TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Batal')),
                        FilledButton.tonal(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Hapus')),
                      ],
                    ),
                  ) ??
                  false;
              return ok;
            },
            onDismissed: (_) => ref.read(categoriesProvider.notifier).remove(c.id),
            child: ListTile(
              leading: Icon(icon, color: c.type == CategoryType.expense ? Colors.red : Colors.green),
              title: Text(c.name),
              subtitle: Text(c.type == CategoryType.expense ? 'Pengeluaran' : 'Pemasukan'),
              trailing: usedCount > 0 ? const Tooltip(message: 'Sedang dipakai', child: Icon(Icons.lock_outline)) : const Icon(Icons.chevron_left, color: Colors.transparent),
            ),
          );
        },
      ),
    );
  }
}

class _NewCategoryResult {
  final String name;
  final CategoryType type;
  const _NewCategoryResult(this.name, this.type);
}

class _AddCategoryDialog extends StatefulWidget {
  const _AddCategoryDialog();

  @override
  State<_AddCategoryDialog> createState() => _AddCategoryDialogState();
}

int _countUsage(List<AppTransaction> txs, String categoryId) {
  int count = 0;
  for (final t in txs) {
    if (t.categoryId == categoryId) count++;
  }
  return count;
}

class _AddCategoryDialogState extends State<_AddCategoryDialog> {
  final _nameCtrl = TextEditingController();
  CategoryType _type = CategoryType.expense;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Kategori Baru'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: 'Nama kategori'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<CategoryType>(
            initialValue: _type,
            decoration: const InputDecoration(labelText: 'Tipe'),
            items: const [
              DropdownMenuItem(value: CategoryType.expense, child: Text('Pengeluaran')),
              DropdownMenuItem(value: CategoryType.income, child: Text('Pemasukan')),
            ],
            onChanged: (v) => setState(() => _type = v ?? CategoryType.expense),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal')),
        FilledButton(
          onPressed: () {
            if (_nameCtrl.text.trim().isEmpty) return;
            Navigator.of(context).pop(_NewCategoryResult(_nameCtrl.text.trim(), _type));
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
