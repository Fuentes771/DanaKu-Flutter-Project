import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../core/providers.dart';
import '../../data/models/transaction.dart';
import '../../data/models/category.dart';
import '../../core/formatters.dart';

class EditTransactionScreen extends ConsumerStatefulWidget {
  const EditTransactionScreen({super.key, required this.txId});
  final String txId;

  @override
  ConsumerState<EditTransactionScreen> createState() =>
      _EditTransactionScreenState();
}

class _EditTransactionScreenState extends ConsumerState<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  TransactionType _type = TransactionType.expense;
  String? _categoryId;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    final txs = ref.read(transactionsProvider).value ?? [];
    final tx = txs.firstWhere(
      (e) => e.id == widget.txId,
      orElse: () => AppTransaction(
        id: widget.txId,
        amount: 0,
        type: TransactionType.expense,
        categoryId: '',
        date: DateTime.now(),
      ),
    );
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
    final amount = int.tryParse(
      _amountCtrl.text.replaceAll('.', '').replaceAll(',', ''),
    );
    if (amount == null) return;
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
    Navigator.of(context).pop();
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
              TextFormField(
                controller: _amountCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nominal',
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  RupiahInputFormatter(),
                ],
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Nominal wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteCtrl,
                decoration: const InputDecoration(
                  labelText: 'Catatan (opsional)',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: Text('Tanggal: ${formatDateShort(_date)}')),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => _date = picked);
                    },
                    child: const Text('Pilih'),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
