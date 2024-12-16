import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controller/shop_controller.dart';
import '../custom_appbar.dart';
import '../models/Shop.dart';

class NearestShopPage extends StatefulWidget {
  @override
  _NearestShopPageState createState() => _NearestShopPageState();
}

class _NearestShopPageState extends State<NearestShopPage> {
  LatLng? _currentPosition;
  final ShopService _shopService = ShopService();
  List<Shop> _shop = [];
  bool _isLoading = true;

  late MapController _mapController;
  Shop? _nearestShop; // Store the nearest shop
  double? _distanceToNearestShop;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
  }

// Request location permission and get the user's current location
  Future<void> _getCurrentLocation() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = true;
      });

      await _fetchShops();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission is required")),
      );
    }
  }

  Future<void> _fetchShops() async {
    try {
      _shop = await _shopService.getShops();
      setState(() {
        _isLoading = false;
      });
      _calculateNearestShop(); // Calculate nearest shop after fetching
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching shops: $e')),
      );
    }
  }


  // Calculate the distance to the nearest shop and find the shop
  void _calculateNearestShop() {
    if (_currentPosition == null) return;

    double minDistance = double.infinity;
    Shop? nearestShop;

    for (var shop in _shop) {
      double distance = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        shop.latitude,
        shop.longitude,
      );
      if (distance < minDistance) {
        minDistance = distance;
        nearestShop = shop; // Update nearest shop
      }
    }

    setState(() {
      _nearestShop = nearestShop;
      _distanceToNearestShop = minDistance / 1000; // Convert to kilometers
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Shop'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_nearestShop != null && _distanceToNearestShop != null)
              Card(
                margin: const EdgeInsets.only(top: 16),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                color: Colors.white,
                shadowColor: Colors.black.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nearest Shop',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Shop: ${_nearestShop!.name}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Distance: ${_distanceToNearestShop!.toStringAsFixed(2)} km',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 300,
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _currentPosition!,
                      initialZoom: 14.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          if (_currentPosition != null)
                            Marker(
                              point: _currentPosition!,
                              width: 50,
                              height: 50,
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.brown,
                                size: 40.0,
                              ),
                            ),
                          for (var shop in _shop)
                            Marker(
                              point: LatLng(shop.latitude, shop.longitude),
                              width: 50,
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  _showShopDetails(shop);
                                },
                                child: const Icon(
                                  Icons.store,
                                  color: Colors.red,
                                  size: 40.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show shop details when a marker is tapped
  void _showShopDetails(Shop shop) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shop.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                shop.address,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              // Use a container to limit image size
              if (shop.imageUrl != null)
                Container(
                  width: double.infinity,  // Ensure the image takes the full width
                  height: 200, // Set a fixed height for the image
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(shop.imageUrl!),
                      fit: BoxFit.cover, // Make sure image scales properly
                    ),
                  ),
                )
              else
                const Icon(Icons.image, size: 100, color: Colors.grey),
            ],
          ),
        );
      },
    );
  }
}
