import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageSetup {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Create users data
  Future<void> createUsersData() async {
    try {
      final List<Map<String, dynamic>> users = [
        {
          'id': 'user1',
          'email': 'john@example.com',
          'displayName': 'John Doe',
          'createdAt': DateTime.now().toIso8601String(),
        },
        {
          'id': 'user2',
          'email': 'jane@example.com',
          'displayName': 'Jane Smith',
          'createdAt': DateTime.now().toIso8601String(),
        },
      ];

      // Convert users list to JSON string
      final String usersJson = jsonEncode(users);

      // Create a reference to users.json in Cloud Storage
      final Reference ref = _storage.ref().child('data/users.json');

      // Upload JSON string as bytes
      final bytes = utf8.encode(usersJson);
      await ref.putData(bytes);

      print('Users data uploaded successfully');
    } catch (e) {
      print('Error creating users data: $e');
    }
  }

  // Create orders data
  Future<void> createOrdersData() async {
    try {
      // Sample products
      final List<Map<String, dynamic>> sampleProducts = [
        {
          'id': 'prod1',
          'name': 'MSI GL 15 Laptop',
          'price': 1200.00,
          'imageUrl': 'assets/images/laptops/msi_gl.jpg',
          'option': 'Black',
          'category': 'Laptops'
        },
        {
          'id': 'prod2',
          'name': 'iPhone 15 Pro Max',
          'price': 1250.00,
          'imageUrl': 'assets/images/phones/Apple-iPhone-15-Pro-Max_-blue-titanium_featured-image-packshot-review-1024x691.jpg',
          'option': 'Blue',
          'category': 'Phones'
        }
      ];

      // Create sample orders
      final List<Map<String, dynamic>> orders = [
        {
          'id': 'order1',
          'userId': 'user1',
          'items': [sampleProducts[0]], // First user ordered a laptop
          'totalAmount': 1200.00,
          'createdAt': DateTime.now().toIso8601String(),
        },
        {
          'id': 'order2',
          'userId': 'user2',
          'items': [sampleProducts[1]], // Second user ordered a phone
          'totalAmount': 1250.00,
          'createdAt': DateTime.now().toIso8601String(),
        },
        {
          'id': 'order3',
          'userId': 'user1',
          'items': [sampleProducts[0], sampleProducts[1]], // First user ordered both
          'totalAmount': 2450.00,
          'createdAt': DateTime.now().toIso8601String(),
        }
      ];

      // Convert orders list to JSON string
      final String ordersJson = jsonEncode(orders);

      // Create a reference to orders.json in Cloud Storage
      final Reference ref = _storage.ref().child('data/orders.json');

      // Upload JSON string as bytes
      final bytes = utf8.encode(ordersJson);
      await ref.putData(bytes);

      print('Orders data uploaded successfully');
    } catch (e) {
      print('Error creating orders data: $e');
    }
  }

  // Create all data files
  Future<void> createAllData() async {
    try {
      await createUsersData();
      await createOrdersData();
      print('All data created successfully');
    } catch (e) {
      print('Error creating data: $e');
    }
  }
}

// Helper function to run the setup
Future<void> setupCloudStorage() async {
  final setup = CloudStorageSetup();
  await setup.createAllData();
}