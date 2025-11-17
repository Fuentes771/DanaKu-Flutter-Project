import 'package:flutter/material.dart';
import '../../widgets/app_logo.dart';
import '../../core/design_system.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang DanaKu',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: cs.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App Logo & Name
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Spacing.xl),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cs.primary, cs.primary.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: cs.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const AppLogo(size: 100),
                  const SizedBox(height: Spacing.md),
                  Text(
                    'DanaKu',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: Spacing.xs),
                  Text(
                    'Aplikasi Manajemen Keuangan',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: cs.outline),
                  ),
                  const SizedBox(height: Spacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.md,
                      vertical: Spacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Versi 1.0.0',
                      style: TextStyle(
                        color: cs.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: Spacing.xl),

            // Description Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: cs.primary),
                        const SizedBox(width: Spacing.sm),
                        Text(
                          'Tentang Aplikasi',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    Text(
                      'DanaKu adalah aplikasi manajemen keuangan pribadi yang membantu Anda mengelola pemasukan dan pengeluaran dengan mudah. Dengan fitur-fitur lengkap seperti pencatatan transaksi, kategorisasi, dan analisis keuangan, DanaKu menjadi solusi terbaik untuk mengatur keuangan Anda.',
                      style: TextStyle(color: cs.onSurface, height: 1.6),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: Spacing.md),

            // Features Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.featured_play_list_outlined,
                          color: cs.primary,
                        ),
                        const SizedBox(width: Spacing.sm),
                        Text(
                          'Fitur Utama',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    _buildFeature(
                      context,
                      Icons.account_balance_wallet_outlined,
                      'Pencatatan Transaksi',
                      'Catat pemasukan dan pengeluaran dengan mudah',
                    ),
                    _buildFeature(
                      context,
                      Icons.category_outlined,
                      'Kategorisasi',
                      'Kelompokkan transaksi berdasarkan kategori',
                    ),
                    _buildFeature(
                      context,
                      Icons.analytics_outlined,
                      'Analisis Keuangan',
                      'Visualisasi data dengan grafik dan chart',
                    ),
                    _buildFeature(
                      context,
                      Icons.cloud_sync_outlined,
                      'Sinkronisasi Cloud',
                      'Data tersimpan aman di cloud',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: Spacing.md),

            // Developer Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.code_outlined, color: cs.primary),
                        const SizedBox(width: Spacing.sm),
                        Text(
                          'Dikembangkan Oleh',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    _buildDeveloperInfo(
                      context,
                      'Tim',
                      'DanaKu Development Team',
                    ),
                    _buildDeveloperInfo(
                      context,
                      'Teknologi',
                      'Flutter & Firebase',
                    ),
                    _buildDeveloperInfo(context, 'Tahun', '2025'),
                    _buildDeveloperInfo(context, 'Lisensi', 'MIT License'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: Spacing.md),

            // Contact Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.contact_support_outlined, color: cs.primary),
                        const SizedBox(width: Spacing.sm),
                        Text(
                          'Hubungi Kami',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    _buildContactItem(
                      context,
                      Icons.email_outlined,
                      'Email',
                      'support@danaku.com',
                    ),
                    _buildContactItem(
                      context,
                      Icons.language_outlined,
                      'Website',
                      'www.danaku.com',
                    ),
                    _buildContactItem(
                      context,
                      Icons.phone_outlined,
                      'Telepon',
                      '+62 812-3456-7890',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: Spacing.xl),

            // Copyright
            Center(
              child: Column(
                children: [
                  Text(
                    '© 2025 DanaKu. All rights reserved.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: cs.outline),
                  ),
                  const SizedBox(height: Spacing.sm),
                  Text(
                    'Made with ❤️ in Indonesia',
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
    );
  }

  Widget _buildFeature(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperInfo(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.sm),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontSize: 13,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
