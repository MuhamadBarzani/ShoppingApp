import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_config';
import 'cart_item.dart';
import 'cart_provider.dart';
class ProductDetails extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedOption = -1;

  void onTap() {
    if (selectedOption == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppConfig.selectOptionMessage),
          backgroundColor: Colors.black,
          elevation: 0,
          duration: AppConfig.snackBarDuration,
        ),
      );
      return;
    }

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final options = widget.product['options'] as List<String>;
    
    final cartItem = CartItem(
      id: widget.product['id'] as String,
      name: widget.product['name'] as String,
      price: double.parse(widget.product['price'].toString()),
      imageUrl: widget.product['url'] as String,
      option: options[selectedOption],
      category: widget.product['category'] as String,
    );

    cartProvider.addItem(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppConfig.productAddedMessage),
        backgroundColor: Colors.black,
        elevation: 0,
        duration: AppConfig.snackBarDuration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Details",
          style: theme.textTheme.titleSmall,
        ),
      ),
      body: Column(
        children: [
          Text(
            widget.product['name'] as String,
            style: theme.textTheme.titleMedium,
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConfig.borderRadius),
            ),
            padding: const EdgeInsets.all(AppConfig.defaultPadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConfig.borderRadius),
              child: Image.asset(
                widget.product['url'] as String,
                height: 250,
              ),
            ),
          ),
          const Spacer(flex: 2),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Text(
                  "\$${widget.product['price'] as String}",
                  style: theme.textTheme.titleSmall
                ),
                const SizedBox(height: 8),
                const Text(
                  "Options:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['options'] as List<String>).length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = index;
                            });
                          },
                          child: Chip(
                            label: Text(
                              (widget.product['options'] as List<String>)[index],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: selectedOption == index
                                ? theme.colorScheme.primary
                                : theme.colorScheme.secondary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("Add To Cart"),
                    onPressed: onTap,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}