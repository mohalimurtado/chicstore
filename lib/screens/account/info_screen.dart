// lib/screens/account/info_screen.dart

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class InfoScreen extends StatelessWidget {
  final String title;
  final String content; // Konten utama (bisa berupa teks panjang)

  const InfoScreen({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), elevation: 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 15,
            height: 1.5,
            color: AppColors.text,
          ),
        ),
      ),
    );
  }
}
