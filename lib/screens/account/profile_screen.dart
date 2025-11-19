import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../config/app_colors.dart';
import '../auth/login_screen.dart';
import 'address_screen.dart';
import 'payment_method_screen.dart';
import 'settings_screen.dart';
import 'help_center_screen.dart';
import 'edit_profile_screen.dart'; // ✅ Tambahkan import ini

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _handleLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'Pengguna ChicStore';
    final userEmail = user?.email ?? 'email@tidakditemukan.com';

    return Scaffold(
      appBar: AppBar(title: const Text('Akun Saya'), elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Header Profil ---
            _buildProfileHeader(userName, userEmail, context),

            const Divider(height: 1),

            // --- Menu Pengguna ---
            _buildMenuSection(context, 'Menu Pengguna', [
              _buildMenuItem(
                context,
                Icons.edit_note_outlined,
                'Edit Profil',
                () {
                  // ✅ Navigasi ke Edit Profile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context,
                Icons.location_on_outlined,
                'Alamat Pengiriman (C.2)',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddressScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context,
                Icons.payment_outlined,
                'Metode Pembayaran (C.3)',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentMethodScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context,
                Icons.notifications_outlined,
                'Notifikasi (C.4)',
                () {
                  // TODO: Navigasi ke Notifications Screen
                },
              ),
            ]),

            const Divider(height: 1),

            // --- Pengaturan & Bantuan ---
            _buildMenuSection(context, 'Pengaturan & Bantuan', [
              _buildMenuItem(
                context,
                Icons.settings_outlined,
                'Pengaturan (C.5)',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context,
                Icons.help_outline,
                'Pusat Bantuan (C.6)',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpCenterScreen(),
                    ),
                  );
                },
              ),
            ]),

            const Divider(height: 1),

            // --- Logout ---
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => _handleLogout(context),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // -------------------------------
  // Header Profil
  // -------------------------------
  Widget _buildProfileHeader(String name, String email, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      color: AppColors.background,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, size: 40, color: AppColors.buttonText),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          const Spacer(),
          // ✅ Tombol Edit Profil di Header
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // -------------------------------
  // Menu Section
  // -------------------------------
  Widget _buildMenuSection(
    BuildContext context,
    String title,
    List<Widget> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryText,
            ),
          ),
        ),
        ...items,
      ],
    );
  }

  // -------------------------------
  // Item Menu
  // -------------------------------
  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: const TextStyle(color: AppColors.text)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.secondaryText),
      onTap: onTap,
    );
  }
}
