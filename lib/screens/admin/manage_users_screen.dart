// lib/screens/admin/manage_users_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/app_colors.dart';
import '../../models/user_data.dart'; // Import model UserData

// Catatan: Anda perlu package intl di pubspec.yaml

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  // Gunakan state lokal agar dapat merefresh status pengguna
  List<UserData> users = dummyUsersList;

  void _toggleUserStatus(UserData user) {
    // TODO: Implementasi logika update status pengguna (blokir/aktifkan) di Firebase Firestore

    // Logika dummy untuk refresh UI
    setState(() {
      final index = users.indexWhere((u) => u.uid == user.uid);
      if (index != -1) {
        // Buat objek baru untuk mengubah isActive (karena UserData adalah final)
        users[index] = UserData(
          uid: user.uid,
          email: user.email,
          name: user.name,
          registrationDate: user.registrationDate,
          isActive: !user.isActive,
        );
      }

      final action = users[index].isActive ? 'diaktifkan' : 'diblokir';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Akun ${user.name} berhasil $action!')),
      );
    });
  }

  void _viewUserDetails(UserData user) {
    // TODO: Navigasi ke Detail Pengguna Admin (Opsional)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Melihat detail admin untuk ${user.name}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelola Pengguna',
          style: TextStyle(color: AppColors.buttonText),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonText,
      ),
      body: ListView.separated(
        itemCount: users.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: user.isActive
                  ? Colors.green.shade100
                  : Colors.red.shade100,
              child: Icon(
                user.isActive ? Icons.person_outline : Icons.lock,
                color: user.isActive ? Colors.green : Colors.red,
                size: 20,
              ),
            ),
            title: Text(
              user.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: user.isActive ? AppColors.text : AppColors.secondaryText,
              ),
            ),
            subtitle: Text(
              '${user.email}\nDaftar: ${DateFormat('dd MMM yyyy').format(user.registrationDate)}',
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tombol Detail
                IconButton(
                  icon: const Icon(Icons.info_outline, color: Colors.blue),
                  onPressed: () => _viewUserDetails(user),
                ),
                // Tombol Blokir/Aktifkan
                IconButton(
                  icon: Icon(
                    user.isActive
                        ? Icons.lock_open_outlined
                        : Icons.lock_outlined,
                    color: user.isActive ? Colors.red : Colors.green,
                  ),
                  onPressed: () => _toggleUserStatus(user),
                ),
              ],
            ),
            onTap: () => _viewUserDetails(user),
          );
        },
      ),
    );
  }
}
