import 'package:flutter/material.dart';
import '../../core/notifications.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Uji Coba Notifikasi Lokal'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          await LocalNotifications.requestPermissions();
                        },
                        icon: const Icon(Icons.verified_user),
                        label: const Text('Minta Izin'),
                      ),
                      FilledButton.icon(
                        onPressed: () async {
                          await LocalNotifications.scheduleTestNotification();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Notifikasi akan tampil dalam 5 detik')),
                            );
                          }
                        },
                        icon: const Icon(Icons.alarm),
                        label: const Text('Jadwalkan Notifikasi Contoh'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),
          ...List.generate(5, (index) => ListTile(
                leading: const Icon(Icons.notifications),
                title: Text('Notifikasi ${index + 1}'),
                subtitle: const Text('Ini adalah notifikasi contoh'),
              )),
        ],
      ),
    );
  }
}
