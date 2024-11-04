import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSetup {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create Users Collection and Sample Data
  Future<void> createUsersCollection() async {
    try {
      // Sample users data
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

      // Create a batch write
      final WriteBatch batch = _firestore.batch();

      // Add each user to the batch
      for (var userData in users) {
        final docRef = _firestore.collection('users').doc(userData['id']);
        batch.set(docRef, userData);
      }

      // Commit the batch
      await batch.commit();
      print('Users collection created successfully');
    } catch (e) {
      print('Error creating users collection: $e');
    }
  }

  // Create Orders Collection and Sample Data
  Future<void> createOrdersCollection() async {
    try {
      // Sample orders data
      final List<Map<String, dynamic>> orders = [
        {
          'id': 'order1',
          'userId': 'user1',
          'items': [
            {
              'id': 'prod1',
              'name': 'MSI GL 15 Laptop',
              'price': 1200.00,
              'imageUrl': 'assets/images/laptops/msi_gl.jpg',
              'option': 'Black',
              'category': 'Laptops'
            }
          ],
          'totalAmount': 1200.00,
          'createdAt': Timestamp.now(),
        },
        {
          'id': 'order2',
          'userId': 'user2',
          'items': [
            {
              'id': 'prod2',
              'name': 'iPhone 15 Pro Max',
              'price': 1250.00,
              'imageUrl': 'assets/images/phones/Apple-iPhone-15-Pro-Max_-blue-titanium_featured-image-packshot-review-1024x691.jpg',
              'option': 'Blue',
              'category': 'Phones'
            }
          ],
          'totalAmount': 1250.00,
          'createdAt': Timestamp.now(),
        }
      ];

      // Create a batch write
      final WriteBatch batch = _firestore.batch();

      // Add each order to the batch
      for (var orderData in orders) {
        final docRef = _firestore.collection('orders').doc(orderData['id']);
        batch.set(docRef, orderData);
      }

      // Commit the batch
      await batch.commit();
      print('Orders collection created successfully');
    } catch (e) {
      print('Error creating orders collection: $e');
    }
  }

  // Create all collections
  Future<void> createAllCollections() async {
    try {
      await createUsersCollection();
      await createOrdersCollection();
      print('All collections created successfully');
    } catch (e) {
      print('Error creating collections: $e');
    }
  }
}

// Helper function to run the setup
Future<void> setupFirestore() async {
  final setup = FirestoreSetup();
  await setup.createAllCollections();
}