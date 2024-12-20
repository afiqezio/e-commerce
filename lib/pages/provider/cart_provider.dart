import 'package:flutter/material.dart';
import '../../models/Product.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  int get cartCount => _cartItems.length;

  // Add product to cart with initial quantity of 1
  void addToCart(Product product) {
    // Check if the product is already in the cart
    var existingProduct = _cartItems.firstWhere(
          (item) => item['productId'] == product.productId,
      orElse: () => {},
    );

    if (existingProduct.isEmpty) {
      // If the product is not in the cart, add it with quantity 1
      _cartItems.add({
        'productId': product.productId,
        'name': product.name,
        'price': product.price,
        'imageUrl': product.imageUrl, // Assuming imageUrl is a field in Product
        'quantity': 1,
      });
    } else {
      // If the product is already in the cart, increase the quantity
      existingProduct['quantity'] += 1;
    }

    notifyListeners();
  }

  // Remove product from the cart
  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item['productId'] == product.productId);
    notifyListeners();
  }

  // Update product quantity in the cart
  void updateQuantity(Product product, int quantity) {
    var cartProduct = _cartItems.firstWhere(
          (item) => item['productId'] == product.productId,
      orElse: () => {},
    );

    if (cartProduct.isNotEmpty) {
      cartProduct['quantity'] = quantity;
      notifyListeners();
    }
  }

  // Clear the entire cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
