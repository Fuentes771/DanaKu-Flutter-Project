import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/brand_background.dart';
import '../../core/design_system.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: BrandBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const AppLogo(size: 64, animated: false),
                    const SizedBox(width: Spacing.md),
                    Text('Profil',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: cs.onPrimary,
                              fontWeight: FontWeight.w700,
                            )),
                  ],
                ),
                const SizedBox(height: Spacing.xl),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(Spacing.lg),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .2), blurRadius: 24, offset: const Offset(0, 12))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
                      const SizedBox(height: Spacing.md),
                      Text('Pengguna',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: Spacing.sm),
                      Text('Kelola preferensi akun kamu',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.outline)),
                      const SizedBox(height: Spacing.lg),
                      Card(
                        elevation: 0,
                        child: ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('Pengaturan'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(height: Spacing.lg),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () async {
                            final repo = ref.read(authRepositoryProvider);
                            await repo?.logout();
                            ref.invalidate(categoriesProvider);
                            ref.invalidate(transactionsProvider);
                            if (context.mounted) context.go('/login');
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Keluar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
