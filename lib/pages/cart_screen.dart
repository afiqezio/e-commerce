import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_appbar.dart';
import 'provider/cart_provider.dart';
import '../../models/Product.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: CustomAppBar(title: 'Your Cart'),
      body: cart.cartItems.isEmpty
          ? _buildEmptyCart()
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        itemCount: cart.cartItems.length,
        itemBuilder: (context, index) {
          final item = cart.cartItems[index];
          return _buildCartItem(context, cart, item);
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.red.shade300,
          ),
          SizedBox(height: 20),
          Text(
            'Your cart is empty!',
            style: TextStyle(
              fontSize: 18,
              color: Colors.brown.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Start adding some delicious churros!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartProvider cart, Map<String, dynamic> item) {
    // We assume that the item is a map with product details and quantity
    final product = Product(
      productId: item['productId'],
      name: item['name'],
      description: item['description'],
      price: item['price'],
      imageUrl: item['imageUrl'],
      categoryId : item['categoryId'],
    );
    final quantity = item['quantity'];

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            product.imageUrl!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          product.name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '\$${product.price} x $quantity',
          style: TextStyle(color: Colors.red.shade400, fontSize: 14),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red.shade400),
          onPressed: () => cart.removeFromCart(product),
        ),
      ),
    );
  }
}
