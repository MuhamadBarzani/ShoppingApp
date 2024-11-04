
class CartItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String option;
  final String category;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.option,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'url': imageUrl,
      'option': option,
      'category': category,
    };
  }

  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      name: map['name'] as String,
      price: double.parse(map['price'].toString()),
      imageUrl: map['url'] as String,
      option: map['options'].toString(),
      category: map['category'] as String,
    );
  }
}
