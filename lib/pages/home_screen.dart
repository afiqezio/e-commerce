import 'package:flutter/material.dart';
import '../custom_appbar.dart';
import 'components/product_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {'name': 'Classic Churros', 'price': 'RM10', 'image': 'assets/chu1.jpeg'},
    {'name': 'Chocolate Churros', 'price': 'RM12', 'image': 'assets/chu2.jpg'},
    {'name': 'Strawberry Churros', 'price': 'RM12', 'image': 'assets/chu3.jpeg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Mr. Churros'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product: product);
          },
        ),
      ),
    );
  }
}




