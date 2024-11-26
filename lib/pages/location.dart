import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import '../custom_appbar.dart';

class NearestShopPage extends StatefulWidget {
  @override
  _NearestShopPageState createState() => _NearestShopPageState();
}

class _NearestShopPageState extends State<NearestShopPage> {
  LatLng? _currentPosition;
  List<Map<String, dynamic>> _shopLocations = [
    {
      'name': 'Churros Shop 1',
      'location': LatLng(3.223138, 101.464610), // Example: Kuala Lumpur location
    },
    {
      'name': 'Churros Shop 2',
      'location': LatLng(3.202443, 101.488343), // Another shop location
    },
  ];
  late MapController _mapController;
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
        _calculateNearestShop();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permission is required")),
      );
    }
  }

  // Calculate the distance to the nearest shop
  void _calculateNearestShop() {
    if (_currentPosition == null) return;

    double minDistance = double.infinity;
    for (var shop in _shopLocations) {
      double distance = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        shop['location'].latitude,
        shop['location'].longitude,
      );
      if (distance < minDistance) {
        minDistance = distance;
      }
    }

    setState(() {
      _distanceToNearestShop = minDistance / 1000; // Convert to kilometers
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Shop'),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_distanceToNearestShop != null)
              Card(
                margin: EdgeInsets.only(top: 16),
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
                      Text(
                        'Nearest Shop',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Shop: ${_shopLocations[0]['name']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Distance: ${_distanceToNearestShop!.toStringAsFixed(2)} km',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
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
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.brown,
                                size: 40.0,
                              ),
                            ),
                          ..._shopLocations.map(
                                (shopLocation) => Marker(
                              point: shopLocation['location'],
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.store,
                                color: Colors.red,
                                size: 40.0,
                              ),
                            ),
                          )
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
}
