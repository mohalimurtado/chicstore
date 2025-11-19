import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import 'info_screen.dart'; // ✅ Tambahkan import InfoScreen

// ----------------------
// Data Dummy InfoScreen
// ----------------------
const String termsContent = '''
SYARAT & KETENTUAN CHICSTORE

1. KETENTUAN UMUM
Dengan mengakses dan menggunakan layanan ChicStore, Anda setuju untuk terikat oleh Syarat dan Ketentuan ini. Layanan ini disediakan oleh PT. Chic Retail Indonesia.

2. PENDAFTARAN AKUN
Anda diwajibkan untuk memberikan informasi yang akurat dan lengkap saat mendaftar. Anda bertanggung jawab penuh atas keamanan kata sandi dan semua aktivitas yang terjadi di bawah akun Anda.

3. PEMESANAN DAN PEMBAYARAN
Semua pesanan dianggap sebagai penawaran beli, dan kami berhak menolak atau membatalkan pesanan. Harga sudah termasuk PPN kecuali dinyatakan lain. Pembayaran harus dilakukan sebelum pesanan diproses (kecuali COD).

4. PENGIRIMAN
Kami akan berusaha mengirimkan produk sesuai perkiraan waktu, namun waktu pengiriman tidak dijamin. Kerusakan selama pengiriman menjadi tanggung jawab penyedia jasa kurir.

5. PENGEMBALIAN
Pengembalian hanya diterima jika produk cacat atau salah kirim, dan harus dikembalikan dalam waktu 7 hari setelah diterima. Produk harus dalam kondisi asli, belum dipakai, dan label masih terpasang.

6. HUKUM YANG BERLAKU
Syarat dan Ketentuan ini diatur dan ditafsirkan sesuai dengan hukum Republik Indonesia.
''';

const String privacyContent = '''
KEBIJAKAN PRIVASI CHICSTORE

1. INFORMASI YANG KAMI KUMPULKAN
Kami mengumpulkan informasi pribadi yang Anda berikan secara sukarela (seperti nama, alamat email, alamat pengiriman) saat Anda mendaftar atau melakukan transaksi. Kami juga mengumpulkan data penggunaan non-pribadi (misalnya, jenis perangkat, halaman yang dilihat).

2. PENGGUNAAN INFORMASI
Informasi yang kami kumpulkan digunakan untuk memproses pesanan, menyediakan layanan pelanggan, meningkatkan kualitas produk, dan mengirimkan promosi (jika Anda setuju).

3. KEAMANAN DATA
Kami berkomitmen untuk melindungi data pribadi Anda. Kami menerapkan berbagai langkah keamanan untuk menjaga keamanan informasi pribadi Anda saat berada di bawah kendali kami.

4. PENGUNGKAPAN KEPADA PIHAK KETIGA
Kami tidak menjual, memperdagangkan, atau mentransfer informasi identitas pribadi Anda kepada pihak luar kecuali untuk penyedia layanan pihak ketiga yang membantu operasional kami (misalnya, jasa pengiriman, pemroses pembayaran).

5. PERUBAHAN KEBIJAKAN
Kebijakan privasi ini dapat diubah sewaktu-waktu. Perubahan akan segera dipublikasikan di halaman ini.
''';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pusat Bantuan'), elevation: 1),
      body: ListView(
        children: [
          // --- Kontak & Informasi ---
          _buildCategoryHeader('Kontak & Informasi Cepat'),

          _buildHelpTile(
            icon: Icons.forum_outlined,
            title: 'Chat dengan Admin',
            subtitle: 'Hubungi kami secara real-time',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Membuka Chat Admin...')),
              );
            },
          ),

          // --- FAQ (Diperbarui ke InfoScreen) ---
          _buildHelpTile(
            icon: Icons.quiz_outlined,
            title: 'FAQ (Pertanyaan Umum)',
            subtitle: 'Temukan jawaban cepat',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfoScreen(
                    title: 'FAQ (Pertanyaan Umum)',
                    content:
                        'Ini adalah halaman FAQ. Tulis pertanyaan dan jawaban umum di sini.',
                  ),
                ),
              );
            },
          ),

          const Divider(height: 1),

          // --- Legalitas ---
          _buildCategoryHeader('Legalitas'),

          _buildHelpTile(
            icon: Icons.gavel_outlined,
            title: 'Syarat & Ketentuan',
            subtitle: 'Kebijakan penggunaan layanan',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfoScreen(
                    title: 'Syarat & Ketentuan',
                    content: termsContent,
                  ),
                ),
              );
            },
          ),

          _buildHelpTile(
            icon: Icons.lock_outline,
            title: 'Kebijakan Privasi',
            subtitle: 'Cara kami mengelola data Anda',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfoScreen(
                    title: 'Kebijakan Privasi',
                    content: privacyContent,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // -------------------------------
  // WIDGET PEMBANTU
  // -------------------------------
  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildHelpTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: const TextStyle(color: AppColors.text)),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(color: AppColors.secondaryText),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.secondaryText),
      onTap: onTap,
    );
  }
}
