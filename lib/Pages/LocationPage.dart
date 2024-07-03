import 'dart:async';

import 'package:airportparking/Constants/Colors.dart';
import 'package:airportparking/Modals/ParkingSpaceClass.dart';
import 'package:airportparking/Providers/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng _currentLatLng = LatLng(0, 0);
  bool _locationLoaded = false;
  String loc = "Select location";
  bool _showSearchBar = false;
  List<ParkingSpace> parkingSpacesList = [
    ParkingSpace(
        "0",
        "Downtown Garage",
        "123 Main St, Cityville",
        LatLng(24.8742059, 67.0545099),
        200,
        5.00,
        20.00,
        ["downtown_garage_1.jpg", "downtown_garage_2.jpg"]),
    ParkingSpace(
        "1",
        "City Center Lot",
        "456 Center St, Cityville",
        LatLng(24.8722059, 67.0545099),
        150,
        4.50,
        18.00,
        ["city_center_lot_1.jpg", "city_center_lot_2.jpg"]),
    ParkingSpace(
        "2",
        "Eastside Parking",
        "789 East St, Cityville",
        LatLng(24.8732059, 67.0555099),
        100,
        4.00,
        15.00,
        ["eastside_parking_1.jpg", "eastside_parking_2.jpg"]),
    ParkingSpace(
        "3",
        "Westend Garage",
        "321 West St, Cityville",
        LatLng(24.8732059, 67.0535099),
        250,
        6.00,
        25.00,
        ["westend_garage_1.jpg", "westend_garage_2.jpg"]),
    ParkingSpace(
        "4",
        "Northside Lot",
        "654 North St, Cityville",
        LatLng(24.8732059, 67.0835099),
        175,
        4.75,
        19.00,
        ["northside_lot_1.jpg", "northside_lot_2.jpg"])
  ];

  Set<Marker> markerList = {};

  @override
  void initState() {
    super.initState();
    _checkAndSetLocation();
    _createMarkers();
  }

  void _checkAndSetLocation() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user.currentLocation.latitude != 0 && userProvider.user.currentLocation.longitude != 0) {
      setState(() {
        _currentLatLng = userProvider.user.currentLocation;
        _locationLoaded = true;
        loc = "${_currentLatLng.latitude}, ${_currentLatLng.longitude}";
      });
      _moveCamera(_currentLatLng);
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await determinePosition();
      setState(() {
        _currentLatLng = LatLng(position.latitude, position.longitude);
        Provider.of<UserProvider>(context, listen: false).setCurrentLocation(_currentLatLng);
        _locationLoaded = true;
        loc = "${_currentLatLng.latitude}, ${_currentLatLng.longitude}";
      });
      _moveCamera(_currentLatLng);
    } catch (e) {
      print(e);
    }
  }

  void _moveCamera(LatLng target) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(target, 18),
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _createMarkers() {
    setState(() {
      markerList = parkingSpacesList.map((parkingSpace) => Marker(
        markerId: MarkerId(parkingSpace.id),
        position: parkingSpace.latlng ?? LatLng(0, 0),
        onTap: () {},
        anchor: Offset(0, -1),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      )).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("_currentLatLng: $_currentLatLng");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leadingWidth: 30,
        automaticallyImplyLeading: true,
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _showSearchBar
              ? TextField(
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white),
            ),
          )
              : Text(
            loc,
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          IconButton(
            icon: _showSearchBar ? Icon(Icons.close) : Icon(Icons.search),
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
              });
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: _locationLoaded
          ? GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(target: _currentLatLng, zoom: 15),
        onTap: (latlong) {
          print(latlong);
        },
        mapType: MapType.terrain,
        markers: {
          Marker(
            markerId: MarkerId('currentLocation'),
            position: _currentLatLng,
            icon: BitmapDescriptor.defaultMarker,
          ),
          ...markerList,
        },
      )
          : Center(child: CircularProgressIndicator()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: Color(0xffff1f6f),
            onPressed: () {
              _moveCamera(_currentLatLng);
            },
            child: const Icon(CupertinoIcons.location),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
