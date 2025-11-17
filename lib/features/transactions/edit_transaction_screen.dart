import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../data/models/transaction.dart';
import '../../data/models/category.dart';
import '../../core/formatters.dart';
import '../../widgets/amount_field.dart';
import '../../widgets/date_field.dart';

class EditTransactionScreen extends ConsumerStatefulWidget {
  const EditTransactionScreen({super.key, required this.txId});
  final String txId;

  @override
  ConsumerState<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends ConsumerState<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  TransactionType _type = TransactionType.expense;
  String? _categoryId;
  DateTime _date = DateTime.now();
  bool _isSaving = false;
  String? _receiptInfo;

  @override
  void initState() {
    super.initState();
    final txs = ref.read(transactionsProvider).value ?? [];
    final tx = txs.firstWhere((e) => e.id == widget.txId, orElse: () =>
        AppTransaction(id: widget.txId, amount: 0, type: TransactionType.expense, categoryId: '', date: DateTime.now()));
    _type = tx.type;
    _categoryId = tx.categoryId;
    _date = tx.date;
  _amountCtrl.text = formatRupiahNoSymbol(tx.amount);
    _noteCtrl.text = tx.note ?? '';
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final amount = int.tryParse(_amountCtrl.text.replaceAll('.', '').replaceAll(',', ''));
    if (amount == null) return;
    if (_categoryId == null || _categoryId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih kategori terlebih dahulu')));
      return;
    }
    setState(() => _isSaving = true);
    try {
      final tx = AppTransaction(
        id: widget.txId,
        amount: amount,
        type: _type,
        categoryId: _categoryId ?? '',
        date: _date,
        note: _noteCtrl.text.isEmpty ? null : _noteCtrl.text,
      );
      await ref.read(transactionsProvider.notifier).update(tx);
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Perubahan transaksi disimpan')));
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal menyimpan perubahan')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final catsAsync = ref.watch(categoriesProvider);
    final cats = (catsAsync.value ?? []).where((c) => (c.type == CategoryType.expense && _type == TransactionType.expense) || (c.type == CategoryType.income && _type == TransactionType.income)).toList();
    if (_categoryId == null && cats.isNotEmpty) _categoryId = cats.first.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Ubah Transaksi')),
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
                  DropdownMenuItem(value: TransactionType.expense, child: Text('Pengeluaran')),
                  DropdownMenuItem(value: TransactionType.income, child: Text('Pemasukan')),
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
                  items: cats.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                  onChanged: (v) => setState(() => _categoryId = v),
                ),
              const SizedBox(height: 12),
              AmountField(controller: _amountCtrl),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteCtrl,
                decoration: const InputDecoration(labelText: 'Catatan (opsional)'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _receiptInfo == null ? const Text('Belum ada bukti transaksi') : Text('Bukti: '),
                  ),
                  TextButton(
                    onPressed: () async {
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
