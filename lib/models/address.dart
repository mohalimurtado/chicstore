// lib/models/address.dart

class Address {
  final String id; // ubah dari int ke String
  final String recipientName;
  final String phoneNumber;
  final String street;
  final String city;
  final String postalCode;
  final bool isDefault;

  Address({
    required this.id,
    required this.recipientName,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.postalCode,
    this.isDefault = false,
  });
}

// Data dummy alamat (ID sekarang String)
final List<Address> dummyAddresses = [
  Address(
    id: '1',
    recipientName: 'Ali Murtado',
    phoneNumber: '081234567890',
    street: 'Jl. Merdeka No. 10',
    city: 'Pamekasan',
    postalCode: '69317',
    isDefault: true,
  ),
  Address(
    id: '2',
    recipientName: 'Budi Santoso',
    phoneNumber: '081298765432',
    street: 'Jl. Raya Pegantenan No. 45',
    city: 'Pegantenan',
    postalCode: '69318',
  ),
];
