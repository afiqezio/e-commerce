import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Product.dart';
import 'cart_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: product.imageUrl!.isNotEmpty
                      ? Image.network(
                    product.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150, // Fixed height for consistency
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        width: double.infinity,
                        height: 150,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  )
                      : Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 150,
                    child: const Center(
                      child: Text(
                        'No Image',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              // Product Details
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '\$${product.price}',
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartProvider>().addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.name} added to cart!')),
                        );
                      },
                      icon: Icon(Icons.add_shopping_cart),
                      label: Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red.shade400,
                        textStyle: TextStyle(fontSize: 12),
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
