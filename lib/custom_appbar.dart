import 'package:churros/pages/news.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pages/cart_screen.dart';
import 'pages/provider/cart_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(70), // Custom height
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade400, Colors.brown.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button if there is a previous page
                if (Navigator.canPop(context))
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                  ),
                // Title of the screen
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0), // Position of the shadow (x, y)
                        blurRadius: 4.0,          // Blurriness of the shadow
                        color: Colors.black.withOpacity(0.6), // Color of the shadow
                      ),
                    ],
                  ),
                ),

                // Row to include Cart and Notification Icons
                Row(
                  children: [
                    // Notification Icon
                    IconButton(
                      icon: Icon(Icons.notifications, color: Colors.white, shadows: [
                          Shadow(
                          offset: Offset(2.0, 2.0),
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ],),
                      onPressed: () {
                        // Navigate to NewsScreen when notification icon is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => NewsScreen()),
                        );
                      },
                    ),
                    // Shopping cart icon with cart count
                    Consumer<CartProvider>(
                      builder: (context, cart, child) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: 28,
                                shadows: [
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 4.0,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => CartScreen()),
                                );
                              },
                            ),
                            if (cart.cartCount > 0)
                              Positioned(
                                right: 2,
                                top: 2,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    '${cart.cartCount}',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
