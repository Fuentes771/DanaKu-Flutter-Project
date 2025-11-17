import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../data/models/transaction.dart';
import '../../data/models/category.dart';
import '../../widgets/date_field.dart';
import '../../widgets/amount_field.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key, this.initialType});
  final TransactionType? initialType;

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  bool _isSaving = false;
  String? _receiptInfo;
  late TransactionType _type;
  String? _categoryId;
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _type = widget.initialType ?? TransactionType.expense;
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final amount = int.tryParse(
      _amountCtrl.text.replaceAll('.', '').replaceAll(',', ''),
    );
    if (amount == null) return;
    if (_categoryId == null || _categoryId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih kategori terlebih dahulu')));
      return;
    }
    setState(() => _isSaving = true);
    try {
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final tx = AppTransaction(
        id: id,
        amount: amount,
        type: _type,
        categoryId: _categoryId ?? '',
        date: _date,
        note: _noteCtrl.text.isEmpty ? null : _noteCtrl.text,
      );
      await ref.read(transactionsProvider.notifier).add(tx);
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transaksi disimpan')));
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal menyimpan transaksi')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final catsAsync = ref.watch(categoriesProvider);
    final cats = (catsAsync.value ?? [])
        .where(
          (c) =>
              (c.type == CategoryType.expense &&
                  _type == TransactionType.expense) ||
              (c.type == CategoryType.income &&
                  _type == TransactionType.income),
        )
        .toList();
    _categoryId ??= cats.isNotEmpty ? cats.first.id : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Transaksi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<TransactionType>(
                initialValue: _type,
                decoration: const InputDecoration(labelText: 'Tipe'),
                items: const [
                  DropdownMenuItem(
                    value: TransactionType.expense,
                    child: Text('Pengeluaran'),
                  ),
                  DropdownMenuItem(
                    value: TransactionType.income,
                    child: Text('Pemasukan'),
                  ),
                ],
                onChanged: (v) => setState(() {
                  _type = v ?? TransactionType.expense;
                  _categoryId = null;
                }),
              ),
              const SizedBox(height: 12),
              if (cats.isEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Belum ada kategori untuk tipe ini.'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pushNamed('/app/transactions/categories'),
                          child: const Text('Buat Kategori'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                )
              else
                DropdownButtonFormField<String>(
                  initialValue: _categoryId,
                  decoration: const InputDecoration(labelText: 'Kategori'),
                  items: cats
                      .map(
                        (c) => DropdownMenuItem(value: c.id, child: Text(c.name)),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _categoryId = v),
                ),
              const SizedBox(height: 12),
              AmountField(controller: _amountCtrl),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteCtrl,
                decoration: const InputDecoration(
                  labelText: 'Catatan (opsional)',
                ),
              ),
              const SizedBox(height: 12),
              // Receipt / proof placeholder
              Row(
                children: [
                  Expanded(
                    child: _receiptInfo == null
                        ? const Text('Belum ada bukti transaksi')
                        : Text('Bukti: '),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Simple placeholder: allow user to paste a path or URL
                      final ctrl = TextEditingController();
                      final res = await showDialog<String?>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Pilih Bukti (placeholder)'),
                          content: TextField(controller: ctrl, decoration: const InputDecoration(hintText: 'Masukkan path atau URL gambar')),
                          actions: [
                            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Batal')),
                            FilledButton(onPressed: () => Navigator.of(ctx).pop(ctrl.text.trim().isEmpty ? null : ctrl.text.trim()), child: const Text('OK'))
                          ],
                        ),
                      );
                      if (res != null) setState(() => _receiptInfo = res);
                    },
                    child: const Text('Pilih Bukti'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DateField(date: _date, onChanged: (d) => setState(() => _date = d)),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
