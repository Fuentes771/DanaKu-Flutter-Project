import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../core/providers.dart';
import '../../data/models/transaction.dart';
import '../../data/models/category.dart';
import '../../core/formatters.dart';

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
