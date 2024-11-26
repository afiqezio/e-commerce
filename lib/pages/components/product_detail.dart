// import 'package:flutter/material.dart';
//
// class ProductDetailScreen extends StatelessWidget {
//   final Map<String, String> product;
//
//   const ProductDetailScreen({Key? key, required this.product}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product['name']!),
//         elevation: 0,
//         backgroundColor: Colors.red,
//       ),
//       body: Column(
//         children: [
//           Hero(
//             tag: product['name']!,
//             child: Image.asset(
//               product['image']!,
//               fit: BoxFit.cover,
//               height: 300,
//               width: double.infinity,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product['name']!,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.brown,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   product['price']!,
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'A delicious churro made to perfection. Indulge in the soft, crispy texture with a hint of sweetness.',
//                   style: TextStyle(fontSize: 16, color: Colors.brown[700]),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
