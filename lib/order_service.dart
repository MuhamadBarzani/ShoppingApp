import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_item.dart';
import 'order.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new order
  Future<void> createOrder(
    String userId,
    List<CartItem> items,
    double totalAmount,
  ) async {
    try {
      // Create a reference to a new document with auto-generated ID
      final orderRef = _firestore.collection('orders').doc();
      
      final order = ShoppingOrder(
        id: orderRef.id,
        userId: userId,
        items: items,
        totalAmount: totalAmount,
        createdAt: DateTime.now(),
      );

      // Set the document data
      await orderRef.set(order.toMap());
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  // Get all orders for a user as a Stream
  Stream<List<ShoppingOrder>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ShoppingOrder.fromMap(doc.data()))
            .toList());
  }

  // Get a specific order by ID
  Future<ShoppingOrder?> getOrderById(String orderId) async {
    try {
      final doc = await _firestore.collection('orders').doc(orderId).get();
      if (doc.exists) {
        return ShoppingOrder.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }
}