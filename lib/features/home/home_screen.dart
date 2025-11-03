import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: theme.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Saldo Uang', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('Rp 0', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Transaksi Terbaru', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          const ListTile(
            leading: Icon(Icons.arrow_upward, color: Colors.red),
            title: Text('Pengeluaran contoh'),
            trailing: Text('-Rp 10.000'),
          ),
          const ListTile(
            leading: Icon(Icons.arrow_downward, color: Colors.green),
            title: Text('Pemasukan contoh'),
            trailing: Text('+Rp 50.000'),
          ),
        ],
      ),
    );
  }
}
