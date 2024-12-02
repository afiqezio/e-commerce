import 'package:flutter/material.dart';

import '../custom_appbar.dart';
import 'authentication/auth_service.dart';
import 'authentication/login.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/john.jpg'),
                backgroundColor: Colors.grey.shade300,
              ),
              SizedBox(height: 20),

              // Name
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade600,
                ),
              ),
              SizedBox(height: 5),

              // Email
              Text(
                'johndoe@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 20),

              // Bio or About Section
              Text(
                'A churros enthusiast who loves coding and creating delicious experiences for users.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 30),

              // Action Buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to edit profile screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 16, color: Colors.white)
                  ,
                ),
              ),
              SizedBox(height: 15),
              OutlinedButton(
                onPressed: () {
                  final AuthService _authService = AuthService();
                  _authService.logout();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red.shade400),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16, color: Colors.red.shade400),
                ),
              ),
              SizedBox(height: 30),

              // Additional Information Section
              Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Orders Completed',
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '15',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Favorites',
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '5',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
