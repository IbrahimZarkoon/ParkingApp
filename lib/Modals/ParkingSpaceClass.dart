import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingSpace{

  ParkingSpace(
      this.id,
      String this.title,
      String this.address,
      LatLng this.latlng,
      int this.capacity,
      double this.hourlyRate,
      double this.dailyRate,
      List<String> this.images
      );

  String id;
  String? title;
  String? address;
  LatLng? latlng;
  int? capacity;
  double? hourlyRate;
  double? dailyRate;
  List<String>? images;
}