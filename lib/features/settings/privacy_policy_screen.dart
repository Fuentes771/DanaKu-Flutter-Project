import 'package:flutter/material.dart';
import '../../core/design_system.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kebijakan Privasi',
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
            // Header
            Container(
              padding: const EdgeInsets.all(Spacing.lg),
              decoration: BoxDecoration(
                color: cs.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.privacy_tip_outlined, color: cs.primary, size: 32),
                  const SizedBox(width: Spacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Privasi Anda Penting',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Terakhir diperbarui: November 2025',
                          style: TextStyle(fontSize: 12, color: cs.outline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: Spacing.xl),

            // Introduction
            _buildSection(
              context,
              '1. Pendahuluan',
              'DanaKu berkomitmen untuk melindungi privasi pengguna kami. Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda saat menggunakan aplikasi DanaKu.',
            ),

            // Information Collection
            _buildSection(
              context,
              '2. Informasi yang Kami Kumpulkan',
              'Kami mengumpulkan beberapa jenis informasi untuk memberikan dan meningkatkan layanan kami:',
            ),
            _buildBulletPoint(
              context,
              'Informasi Akun',
              'Nama, email, dan foto profil yang Anda berikan saat mendaftar.',
            ),
            _buildBulletPoint(
              context,
              'Data Transaksi',
              'Catatan transaksi keuangan yang Anda buat di aplikasi.',
            ),
            _buildBulletPoint(
              context,
              'Data Penggunaan',
              'Informasi tentang bagaimana Anda menggunakan aplikasi kami.',
            ),

            const SizedBox(height: Spacing.lg),

            // How We Use Information
            _buildSection(
              context,
              '3. Penggunaan Informasi',
              'Informasi yang kami kumpulkan digunakan untuk:',
            ),
            _buildBulletPoint(
              context,
              'Menyediakan Layanan',
              'Memproses dan menyimpan data transaksi Anda.',
            ),
            _buildBulletPoint(
              context,
              'Meningkatkan Pengalaman',
              'Menganalisis penggunaan untuk meningkatkan fitur aplikasi.',
            ),
            _buildBulletPoint(
              context,
              'Komunikasi',
              'Mengirimkan notifikasi dan informasi penting terkait akun Anda.',
            ),
            _buildBulletPoint(
              context,
              'Keamanan',
              'Melindungi akun Anda dari akses tidak sah.',
            ),

            const SizedBox(height: Spacing.lg),

            // Data Security
            _buildSection(
              context,
              '4. Keamanan Data',
              'Kami menggunakan langkah-langkah keamanan yang sesuai untuk melindungi informasi pribadi Anda:',
            ),
            _buildBulletPoint(
              context,
              'Enkripsi',
              'Data sensitif dienkripsi saat ditransmisikan dan disimpan.',
            ),
            _buildBulletPoint(
              context,
              'Autentikasi',
              'Sistem autentikasi yang aman menggunakan Firebase Authentication.',
            ),
            _buildBulletPoint(
              context,
              'Cloud Storage',
              'Data disimpan dengan aman di Firebase Cloud Firestore.',
            ),

            const SizedBox(height: Spacing.lg),

            // Data Sharing
            _buildSection(
              context,
              '5. Berbagi Data',
              'Kami tidak menjual, memperdagangkan, atau menyewakan informasi pribadi Anda kepada pihak ketiga. Informasi Anda hanya dapat dibagikan dalam kondisi berikut:',
            ),
            _buildBulletPoint(
              context,
              'Dengan Persetujuan',
              'Kami akan berbagi informasi hanya dengan persetujuan eksplisit Anda.',
            ),
            _buildBulletPoint(
              context,
              'Kepatuhan Hukum',
              'Jika diwajibkan oleh hukum atau proses hukum.',
            ),
            _buildBulletPoint(
              context,
              'Penyedia Layanan',
              'Dengan penyedia layanan pihak ketiga yang membantu mengoperasikan aplikasi (seperti Firebase).',
            ),

            const SizedBox(height: Spacing.lg),

            // User Rights
            _buildSection(
              context,
              '6. Hak Pengguna',
              'Anda memiliki hak untuk:',
            ),
            _buildBulletPoint(
              context,
              'Mengakses Data',
              'Melihat dan mengunduh data pribadi Anda.',
            ),
            _buildBulletPoint(
              context,
              'Mengedit Data',
              'Memperbarui informasi profil Anda kapan saja.',
            ),
            _buildBulletPoint(
              context,
              'Menghapus Akun',
              'Menghapus akun dan semua data terkait.',
            ),
            _buildBulletPoint(
              context,
              'Menarik Persetujuan',
              'Menarik persetujuan Anda untuk pemrosesan data tertentu.',
            ),

            const SizedBox(height: Spacing.lg),

            // Data Retention
            _buildSection(
              context,
              '7. Penyimpanan Data',
              'Kami menyimpan informasi pribadi Anda selama akun Anda aktif atau selama diperlukan untuk menyediakan layanan. Jika Anda menghapus akun, data Anda akan dihapus secara permanen dalam 30 hari.',
            ),

            // Children's Privacy
            _buildSection(
              context,
              '8. Privasi Anak-anak',
              'Layanan kami tidak ditujukan untuk anak-anak di bawah usia 13 tahun. Kami tidak dengan sengaja mengumpulkan informasi pribadi dari anak-anak.',
            ),

            // Changes to Policy
            _buildSection(
              context,
              '9. Perubahan Kebijakan',
              'Kami dapat memperbarui Kebijakan Privasi ini dari waktu ke waktu. Perubahan akan diposting di halaman ini dengan tanggal "Terakhir diperbarui" yang baru.',
            ),

            // Contact
            _buildSection(
              context,
              '10. Hubungi Kami',
              'Jika Anda memiliki pertanyaan tentang Kebijakan Privasi ini, silakan hubungi kami di:',
            ),

            const SizedBox(height: Spacing.md),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Column(
                  children: [
                    _buildContactRow(
                      context,
                      Icons.email_outlined,
                      'privacy@danaku.com',
                    ),
                    const SizedBox(height: Spacing.sm),
                    _buildContactRow(
                      context,
                      Icons.language_outlined,
                      'www.danaku.com/privacy',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: Spacing.xl),

            // Acceptance
            Container(
              padding: const EdgeInsets.all(Spacing.lg),
              decoration: BoxDecoration(
                color: cs.secondaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.outline.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline, color: cs.secondary),
                  const SizedBox(width: Spacing.md),
                  Expanded(
                    child: Text(
                      'Dengan menggunakan DanaKu, Anda menyetujui pengumpulan dan penggunaan informasi sesuai dengan kebijakan ini.',
                      style: TextStyle(fontSize: 13, color: cs.onSurface),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: Spacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: Spacing.sm),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(
    BuildContext context,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.lg, bottom: Spacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.outline,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: Spacing.md),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
