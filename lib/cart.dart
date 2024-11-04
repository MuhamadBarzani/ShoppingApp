import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_config';
import 'auth_service.dart';
import 'cart_item.dart';
import 'cart_provider.dart';
import 'order_service.dart';
class CartDetails extends StatelessWidget {
  const CartDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final items = cartProvider.items;
        final theme = Theme.of(context);
        
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Cart",
              style: theme.textTheme.titleMedium
            ),
            actions: [
              if (items.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.delete_sweep),
                  onPressed: () => _showClearCartDialog(context, cartProvider),
                ),
            ],
          ),
          body: items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 100,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppConfig.cartEmptyMessage,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return _buildCartItem(context, item, cartProvider);
                        },
                      ),
                    ),
                    if (items.isNotEmpty) _buildTotalSection(context, cartProvider),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildCartItem(
    BuildContext context,
    CartItem item,
    CartProvider cartProvider
  ) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Card(
        elevation: AppConfig.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: _buildProductImage(item.imageUrl),
          title: Text(
            item.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                "Option: ${item.option}",
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                "Price: \$${item.price}",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () => _showDeleteDialog(context, cartProvider, item),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 60,
            height: 60,
            color: Colors.grey[200],
            child: const Icon(Icons.error_outline),
          );
        },
      ),
    );
  }

  Widget _buildTotalSection(BuildContext context, CartProvider cartProvider) {
  final theme = Theme.of(context);
  final OrderService orderService = OrderService();
  final AuthService authService = AuthService();
  
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total:",
              style: theme.textTheme.titleMedium,
            ),
            Text(
              "\$${cartProvider.totalAmount.toStringAsFixed(2)}",
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.green[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showPurchaseConfirmation(
            context,
            cartProvider,
            orderService,
            authService,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Purchase Now'),
        ),
      ],
    ),
  );
}
  void _showPurchaseConfirmation(
  BuildContext context,
  CartProvider cartProvider,
  OrderService orderService,
  AuthService authService,
  ) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "Confirm Purchase",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      content: Text(
        "Total Amount: \$${cartProvider.totalAmount.toStringAsFixed(2)}\n\nDo you want to proceed with the purchase?"
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextButton(
          onPressed: () async {
            final user = authService.currentUser;
            if (user != null) {
              // Create the order
              await orderService.createOrder(
                user.uid,
                cartProvider.items,
                cartProvider.totalAmount,
              );
              
              // Clear the cart
              cartProvider.clearCart();
              
              if (context.mounted) {
                Navigator.pop(context); // Close dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Purchase completed successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            }
          },
          child: const Text(
            "Confirm",
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    ),
  );
}
  void _showDeleteDialog(
    BuildContext context,
    CartProvider cartProvider,
    CartItem item,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Delete Product",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        content: const Text(
          "Are you sure you want to delete this product from your cart?"
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "No",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () {
              cartProvider.removeItem(item);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppConfig.productRemovedMessage),
                  duration: AppConfig.snackBarDuration,
                ),
              );
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Clear Cart",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        content: const Text(
          "Are you sure you want to clear your entire cart?"
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "No",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () {
              cartProvider.clearCart();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppConfig.cartClearedMessage),
                  duration: AppConfig.snackBarDuration,
                ),
              );
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}