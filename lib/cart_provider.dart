import 'package:flutter/material.dart';

import 'cart_item.dart';
class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  
  List<CartItem> get items => List.unmodifiable(_items);
  
  double get totalAmount => _items.fold(
    0, 
    (sum, item) => sum + item.price
  );

  int get itemCount => _items.length;

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool containsItem(String id) {
    return _items.any((item) => item.id == id);
  }
}