import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String category;
  final bool isPopular;
  final String description;
  final double rating;
  final int reviewCount;
  final List<String> sizes;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    this.isPopular = false,
    required this.description,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.sizes = const ['S', 'M', 'L'],
  });
}

// Data Dummy Produk
final List<Product> dummyProducts = [
  Product(
    id: 'p1',
    name: 'T-Shirt Oversize Hitam',
    imageUrl:
        'https://tse4.mm.bing.net/th/id/OIP.SSPX7S14CK5tsjGtne6YvQHaHa?pid=Api&h=220&P=0cls',
    price: 99000,
    category: 'Kaos',
    isPopular: true,
    description: 'Kaos oversized 100% katun premium.',
    rating: 4.8,
    reviewCount: 150,
    sizes: const ['S', 'M', 'L', 'XL'],
  ),
  Product(
    id: 'p2',
    name: 'Kemeja Flanel Merah',
    imageUrl:
        'https://tse2.mm.bing.net/th/id/OIP.kTP37HB22bH--lznPFMgSQHaHa?pid=Api&h=220&P=0',
    price: 185000,
    category: 'Kemeja',
    description: 'Kemeja flanel tebal dengan motif kotak-kotak merah klasik.',
    rating: 4.5,
    reviewCount: 95,
  ),
  Product(
    id: 'p3',
    name: 'Jaket Denim Vintage',
    imageUrl:
        'https://tse4.mm.bing.net/th/id/OIP.6_u4Gek6wSrHCwzjG9F1pQHaHa?pid=Api&h=220&P=0',
    price: 350000,
    category: 'Outerwear',
    isPopular: true,
    description: 'Jaket denim dengan aksen pudar, gaya vintage abadi.',
    rating: 4.9,
    reviewCount: 220,
    sizes: const ['M', 'L', 'XL'],
  ),
  Product(
    id: 'p4',
    name: 'Celana Jeans Slimfit',
    imageUrl:
        'https://tse2.mm.bing.net/th/id/OIP.yBh50L8wYsUcH2Su6SkV3gHaHa?pid=Api&h=220&P=0',
    price: 240000,
    category: 'Celana',
    description: 'Jeans slimfit abu-abu gelap, bahan melar dan elastis.',
    rating: 4.2,
    reviewCount: 60,
  ),
  Product(
    id: 'p5',
    name: 'Dress Midi Bunga',
    imageUrl:
        'https://tse4.mm.bing.net/th/id/OIP.Wdsu460pT7SeiX4-p3cYAwHaHa?pid=Api&h=220&P=0',
    price: 155000,
    category: 'Baju Wanita',
    isPopular: true,
    description:
        'Dress midi berbahan rayon lembut dengan motif bunga-bunga kecil.',
    rating: 5.0,
    reviewCount: 15,
    sizes: const ['S', 'M', 'L'],
  ),
  Product(
    id: 'p6',
    name: 'Tas Selempang Kulit',
    imageUrl:
        'https://tse3.mm.bing.net/th/id/OIP.38V-6csTUOi3yk-zLebBQgHaHa?pid=Api&h=220&P=0',
    price: 199000,
    category: 'Aksesoris',
    description: 'Tas selempang kulit sintetis dengan desain minimalis.',
    rating: 4.7,
    reviewCount: 88,
    sizes: const ['All Size'],
    isPopular: true,
  ),
  // ======================================
  // PRODUK SEPATU BARU DIMULAI DI SINI
  // ======================================
  Product(
    id: 'p7',
    name: 'Sepatu Sneakers Putih',
    imageUrl:
        'https://tse1.mm.bing.net/th/id/OIP.-PWOWSBmkzqaQayHm0dHHwHaHa?pid=Api&h=220&P=0',
    price: 450000,
    category: 'Sepatu',
    description:
        'Sepatu sneakers klasik warna putih bersih, nyaman untuk kasual.',
    rating: 4.6,
    reviewCount: 190,
    sizes: const ['38', '39', '40', '41', '42'],
    isPopular: true,
  ),
  Product(
    id: 'p8',
    name: 'Sepatu Lari Sporty Hitam',
    imageUrl:
        'https://tse1.mm.bing.net/th/id/OIP.mbYbiHtqzHSWnshn-DcB9gHaFj?pid=Api&h=220&P=0',
    price: 780000,
    category: 'Sepatu',
    description:
        'Sepatu lari ringan dengan bantalan yang responsif, cocok untuk jogging harian.',
    rating: 4.8,
    reviewCount: 350,
    sizes: const ['40', '41', '42', '43', '44'],
  ),
  Product(
    id: 'p9',
    name: 'Loafers Kulit Cokelat',
    imageUrl:
        'https://tse1.mm.bing.net/th/id/OIP.z934RVVzpBy-0UxR1r2VsQHaHa?pid=Api&h=220&P=0',
    price: 950000,
    category: 'Sepatu',
    description:
        'Sepatu Loafers kulit asli, memberikan kesan elegan dan profesional.',
    rating: 4.5,
    reviewCount: 120,
    sizes: const ['39', '40', '41', '42'],
  ),
  Product(
    id: 'p10',
    name: 'Boots Kulit Vintage',
    imageUrl:
        'https://tse3.mm.bing.net/th/id/OIP.BGGj_4CX3Zq3fSHtS7LCBQHaHa?pid=Api&h=220&P=0',
    price: 1200000,
    category: 'Sepatu',
    description:
        'Boots kulit dengan desain vintage yang tangguh dan tahan lama.',
    rating: 4.7,
    reviewCount: 95,
    sizes: const ['41', '42', '43', '44'],
  ),
];

// Data Dummy Kategori
final List<Map<String, dynamic>> dummyCategories = [
  {'name': 'Wanita', 'icon': Icons.woman, 'color': Colors.pink.shade100},
  {'name': 'Pria', 'icon': Icons.man, 'color': Colors.blue.shade100},
  {'name': 'Kaos', 'icon': Icons.style, 'color': Colors.yellow.shade100},
  {
    'name': 'Outer',
    'icon': Icons.accessibility_new,
    'color': Colors.green.shade100,
  },
  {'name': 'Celana', 'icon': Icons.cut, 'color': Colors.purple.shade100},
];
