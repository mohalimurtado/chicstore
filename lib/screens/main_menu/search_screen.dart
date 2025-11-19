import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> searchHistory = [
      'T-Shirt',
      'Celana Jeans Pria',
      'Dress',
    ];
    final List<String> recommendations = ['Kaos', 'Outerwear', 'Kemeja Flanel'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildSearchBar(context),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Pencarian',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: searchHistory
                  .map(
                    (query) => Chip(
                      label: Text(query),
                      onDeleted: () {
                        /* TODO: Logika Hapus Riwayat */
                      },
                      backgroundColor: AppColors.background,
                      side: const BorderSide(color: AppColors.secondaryText),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 25),

            Text(
              'Rekomendasi Kami',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            ...recommendations.map(
              (item) => ListTile(
                leading: const Icon(
                  Icons.star_border,
                  color: AppColors.primary,
                ),
                title: Text(item),
                onTap: () {
                  /* TODO: Mulai Pencarian dengan item ini */
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Cari produk di ChicStore...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: AppColors.primary),
          contentPadding: EdgeInsets.only(top: 10),
        ),
      ),
    );
  }
}
