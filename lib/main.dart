import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/components/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pages/news.dart';
import 'pages/profile.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
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
        scaffoldBackgroundColor: Colors.red.shade50, // Light red background
        textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(
            color: Colors.white, // Adjust text color for better contrast
          ),
          displayMedium: GoogleFonts.poppins(
            color: Colors.black87,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange.shade400, // Buttons matching the churros theme
        ),
      ),

      home: MainNavigation(),
    );
  }
}


class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    NewsScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.brown,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.location_city_sharp), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}





