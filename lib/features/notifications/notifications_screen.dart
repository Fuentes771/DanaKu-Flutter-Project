import 'package:flutter/material.dart';
import '../../core/notifications.dart';
import '../../widgets/brand_background.dart';
import '../../core/design_system.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BrandBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(Spacing.lg),
            children: [
              Text('Notifikasi', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w800)),
              const SizedBox(height: Spacing.lg),
              Container(
                padding: const EdgeInsets.all(Spacing.lg),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(Radii.lg),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .1), blurRadius: 18, offset: const Offset(0, 10))],
                ),
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
              const SizedBox(height: Spacing.lg),
              const Divider(),
              // Contoh list; ganti dengan data nyata jika sudah ada
              ...List.generate(
                5,
                (index) => ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text('Notifikasi ${index + 1}'),
                  subtitle: const Text('Ini adalah notifikasi contoh'),
                ),
              ),
              // Jika nantinya kosong, gunakan EmptyState berikut:
              // const EmptyState(icon: Icons.notifications_off, title: 'Belum ada notifikasi', subtitle: 'Notifikasi akan tampil di sini'),
            ],
          ),
        ),
      ),
    );
  }
}
