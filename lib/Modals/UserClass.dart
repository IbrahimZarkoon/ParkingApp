import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  String id;
  String name;
  String address;
  LatLng currentLocation;

  User({
    required this.id,
    required this.name,
    required this.address,
    required this.currentLocation,
  });
}
