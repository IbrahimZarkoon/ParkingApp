import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String address;
  LatLng currentLocation;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.currentLocation,
  });
}
