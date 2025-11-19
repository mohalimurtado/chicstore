// lib/models/user_data.dart

class UserData {
  final String uid;
  final String email;
  final String name;
  final DateTime registrationDate;
  final bool isActive;

  UserData({
    required this.uid,
    required this.email,
    required this.name,
    required this.registrationDate,
    this.isActive = true,
  });
}

// Data Dummy Pengguna (Menggambarkan data dari Firebase Firestore/Auth)
final List<UserData> dummyUsersList = [
  UserData(
    uid: 'user-001',
    email: 'mohalmurtado21@gmail.com',
    name: 'Mohal Murtado',
    registrationDate: DateTime(2025, 11, 12),
    isActive: true,
  ),
  UserData(
    uid: 'user-002',
    email: 'siti.rahma@yahoo.com',
    name: 'Siti Rahmawati',
    registrationDate: DateTime(2025, 11, 10),
    isActive: true,
  ),
  UserData(
    uid: 'user-003',
    email: 'bambang.admin@mail.com',
    name: 'Bambang Sudiro',
    registrationDate: DateTime(2025, 11, 5),
    isActive: false, // Contoh pengguna yang diblokir
  ),
];
