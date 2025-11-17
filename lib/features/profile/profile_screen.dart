import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/brand_background.dart';
import '../../widgets/profile_avatar.dart';
import '../../core/design_system.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Keluar'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final repo = ref.read(authRepositoryProvider);
              await repo?.logout();
              ref.invalidate(categoriesProvider);
              ref.invalidate(transactionsProvider);
              if (context.mounted) context.go('/login');
            },
            style: FilledButton.styleFrom(backgroundColor: cs.error),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    // TODO: Get user data from auth provider
    const userName = 'Pengguna DanaKu';
    const userEmail = 'user@danaku.com';

    return Scaffold(
      body: BrandBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const AppLogo(size: 56, animated: false),
                    ),
                    const SizedBox(width: Spacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profil Saya',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                        ),
                        Text(
                          'Kelola akun Anda',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.white.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.xl),

                // Profile Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(Spacing.xl),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: cs.primary.withOpacity(0.15),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Profile Avatar
                      ProfileAvatar(
                        name: userName,
                        radius: 50,
                        showEditButton: true,
                        onEdit: () => context.push('/profile/edit'),
                      ),
                      const SizedBox(height: Spacing.md),

                      // User Name
                      Text(
                        userName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: Spacing.xs),

                      // User Email
                      Text(
                        userEmail,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: cs.outline),
                      ),
                      const SizedBox(height: Spacing.sm),

                      // Edit Profile Button
                      OutlinedButton.icon(
                        onPressed: () => context.push('/profile/edit'),
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        label: const Text('Edit Profil'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      const SizedBox(height: Spacing.xl),

                      // Account Section
                      _buildSectionTitle(context, 'Akun'),
                      const SizedBox(height: Spacing.sm),

                      _buildMenuItem(
                        context: context,
                        icon: Icons.person_outline,
                        title: 'Informasi Pribadi',
                        subtitle: 'Nama, email, dan foto profil',
                        onTap: () => context.push('/profile/edit'),
                      ),
                      _buildMenuItem(
                        context: context,
                        icon: Icons.lock_outline,
                        title: 'Ubah Kata Sandi',
                        subtitle: 'Perbarui kata sandi akun Anda',
                        onTap: () => context.push('/settings/change-password'),
                      ),

                      const SizedBox(height: Spacing.lg),

                      // App Section
                      _buildSectionTitle(context, 'Aplikasi'),
                      const SizedBox(height: Spacing.sm),

                      _buildMenuItem(
                        context: context,
                        icon: Icons.notifications_outlined,
                        title: 'Notifikasi',
                        subtitle: 'Atur preferensi notifikasi',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Fitur notifikasi segera hadir'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context: context,
                        icon: Icons.palette_outlined,
                        title: 'Tema',
                        subtitle: 'Light mode / Dark mode',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Fitur tema segera hadir'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context: context,
                        icon: Icons.language_outlined,
                        title: 'Bahasa',
                        subtitle: 'Indonesia',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Fitur bahasa segera hadir'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: Spacing.lg),

                      // Support Section
                      _buildSectionTitle(context, 'Bantuan & Dukungan'),
                      const SizedBox(height: Spacing.sm),

                      _buildMenuItem(
                        context: context,
                        icon: Icons.help_outline,
                        title: 'Pusat Bantuan',
                        subtitle: 'FAQ dan panduan penggunaan',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Fitur bantuan segera hadir'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context: context,
                        icon: Icons.info_outline,
                        title: 'Tentang DanaKu',
                        subtitle: 'Versi dan informasi aplikasi',
                        onTap: () => context.push('/about'),
                      ),
                      _buildMenuItem(
                        context: context,
                        icon: Icons.privacy_tip_outlined,
                        title: 'Kebijakan Privasi',
                        subtitle: 'Perlindungan data pengguna',
                        onTap: () => context.push('/privacy'),
                      ),

                      const SizedBox(height: Spacing.xl),

                      // Logout Button
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [cs.error, cs.error.withOpacity(0.8)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: cs.error.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: FilledButton.icon(
                          onPressed: () => _showLogoutDialog(context, ref),
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text(
                            'Keluar',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            minimumSize: const Size.fromHeight(56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: Spacing.md),

                      // App Version
                      Text(
                        'DanaKu v1.0.0',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: cs.outline),
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: Spacing.sm),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
