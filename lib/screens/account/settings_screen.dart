import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'Bahasa Indonesia';
  final List<String> availableLanguages = ['Bahasa Indonesia', 'English'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan'), elevation: 1),
      body: ListView(
        children: [
          _buildCategoryHeader('Tampilan'),
          SwitchListTile(
            title: const Text('Mode Gelap'),
            subtitle: Text(_isDarkMode ? 'Aktif' : 'Nonaktif'),
            secondary: const Icon(
              Icons.brightness_4_outlined,
              color: AppColors.primary,
            ),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode =
                    value; /* TODO: Implementasi logika perubahan tema */
              });
            },
            activeThumbColor: AppColors.primary,
          ),

          const Divider(height: 1),

          _buildCategoryHeader('Umum'),
          ListTile(
            title: const Text('Bahasa'),
            subtitle: Text(_selectedLanguage),
            leading: const Icon(
              Icons.language_outlined,
              color: AppColors.primary,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.secondaryText,
            ),
            onTap: () => _showLanguageSelection(context),
          ),
          ListTile(
            title: const Text('Keamanan Akun'),
            subtitle: const Text('Ubah password atau aktifkan 2FA'),
            leading: const Icon(
              Icons.security_outlined,
              color: AppColors.primary,
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.secondaryText,
            ),
            onTap: () {
              /* TODO: Navigasi ke Security Screen */
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Menuju Pengaturan Keamanan Akun'),
                ),
              );
            },
          ),

          const Divider(height: 1),
        ],
      ),
    );
  }

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

  void _showLanguageSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Bahasa'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableLanguages.length,
              itemBuilder: (BuildContext context, int index) {
                final language = availableLanguages[index];
                return RadioListTile<String>(
                  title: Text(language),
                  value: language,
                  groupValue: _selectedLanguage,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedLanguage = newValue;
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Bahasa diubah ke $newValue')),
                      );
                    }
                  },
                  activeColor: AppColors.primary,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
