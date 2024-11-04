import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSetup {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create Users Table and Sample Data
  Future<void> createUsersTable() async {
    try {
      // Create sample users
      final List<Map<String, dynamic>> users = [
        {
          'id': 'user1',
          'email': 'john@example.com',
          'displayName': 'John Doe',
          'createdAt': Timestamp.now(),
        },
        {
          'id': 'user2',
          'email': 'jane@example.com',
          'displayName': 'Jane Smith',
          'createdAt': Timestamp.now(),
        },
      ];

      // Add users to Firestore
      for (var userData in users) {
        await _firestore
            .collection('users')
            .doc(userData['id'])
            .set(userData);
      }

      print('Users table created successfully');
    } catch (e) {
      print('Error creating users table: $e');
    }
  }

  // Create Orders Table and Sample Data
  Future<void> createOrdersTable() async {
    try {
      // Sample products that will be used in orders
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
          'createdAt': Timestamp.now(),
        },
        {
          'id': 'order2',
          'userId': 'user2',
          'items': [sampleProducts[1]], // Second user ordered a phone
          'totalAmount': 1250.00,
          'createdAt': Timestamp.now(),
        },
        {
          'id': 'order3',
          'userId': 'user1',
          'items': [sampleProducts[0], sampleProducts[1]], // First user ordered both
          'totalAmount': 2450.00,
          'createdAt': Timestamp.now(),
        }
      ];

      // Add orders to Firestore
      for (var orderData in orders) {
        await _firestore
            .collection('orders')
            .doc(orderData['id'])
            .set(orderData);
      }

      print('Orders table created successfully');
    } catch (e) {
      print('Error creating orders table: $e');
    }
  }

  // Create all tables at once
  Future<void> createAllTables() async {
    try {
      await createUsersTable();
      await createOrdersTable();
      print('All tables created successfully');
    } catch (e) {
      print('Error creating tables: $e');
    }
  }
}

// Helper function to run the setup
Future<void> setupFirebaseTables() async {
  final setup = FirebaseSetup();
  await setup.createAllTables();
}