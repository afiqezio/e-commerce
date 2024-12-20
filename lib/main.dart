import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:churros/splash_screen.dart';
import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/provider/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pages/location.dart';
import 'pages/profile.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: ChurrosApp(),
    ),
  );
}

class ChurrosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red.shade600,
        secondaryHeaderColor: Colors.orange.shade400,
        scaffoldBackgroundColor: Colors.red.shade50,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(color: Colors.white),
          displayMedium: GoogleFonts.poppins(color: Colors.black87),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange.shade400,
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final _controller = NotchBottomBarController(index: 0);

  final List<Widget> _pages = [
    HomeScreen(),
    NearestShopPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: true,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.home, color: Colors.grey),
            activeItem: Icon(Icons.home, color: Colors.red),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.location_city_sharp, color: Colors.grey),
            activeItem: Icon(Icons.location_city_sharp, color: Colors.red),
            itemLabel: 'Shop',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person, color: Colors.grey),
            activeItem: Icon(Icons.person, color: Colors.red),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (selectedIndex) {
          setState(() {
            _currentIndex = selectedIndex;
          });
        },
        kIconSize: 24.0,
        kBottomRadius: 28.0,
      ),
    );
  }
}
