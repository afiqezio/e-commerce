import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../controller/user_controller.dart';
import '../custom_appbar.dart';
import '../models/User.dart';
import '../controller/authentication/auth_service.dart';
import 'authentication/login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final userId = await _secureStorage.read(key: 'userId');
      if (userId == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
      final fetchedUser = await _userService.getUserById(userId!);
      setState(() {
        _user = fetchedUser;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _user == null
          ? Center(child: Text('User data could not be loaded'))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
          ClipOval(
          child: _user!.imageUrl != null && _user!.imageUrl!.isNotEmpty
          ? Image.network(
            _user!.imageUrl!,
            fit: BoxFit.cover,
            width: 150,
            height: 150,
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
              return const Icon(
                Icons.broken_image,
                size: 50,
                color: Colors.grey,
              );
            },
          )
              : Container(
          width: 150,
          height: 150,
          color: Colors.grey[300],
          child: const Icon(
            Icons.person,
            size: 50,
            color: Colors.grey,
          ),
        ),
      ),
              SizedBox(height: 20),
              // Name
              Text(
                _user!.fullName,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade600,
                ),
              ),
              SizedBox(height: 5),

              // Email
              Text(
                _user!.email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 20),

              // Phone
              Text(
                _user!.phone.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 30),

              // Edit Profile Button
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 15),

              // Log Out Button
              OutlinedButton(
                onPressed: () async {
                  final AuthService _authService = AuthService();
                  await _authService.logout();
                  await _secureStorage.deleteAll();

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
