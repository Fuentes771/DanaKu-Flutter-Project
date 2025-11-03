import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        onPressed: () {},
        tooltip: 'Tambah Transaksi',
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const ListTile(
          leading: Icon(Icons.receipt_long),
          title: Text('Transaksi contoh'),
          subtitle: Text('Kategori • Tanggal'),
          trailing: Text('-Rp 10.000'),
        ),
      ),
    );
  }
}
