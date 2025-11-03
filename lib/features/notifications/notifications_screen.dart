import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi')),
      body: ListView.separated(
        itemCount: 5,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.notifications),
          title: Text('Notifikasi ${index + 1}'),
          subtitle: const Text('Ini adalah notifikasi contoh'),
        ),
      ),
    );
  }
}
