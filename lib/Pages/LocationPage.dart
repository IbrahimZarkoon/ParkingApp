import 'dart:async';

import 'package:airportparking/Constants/Colors.dart';
import 'package:airportparking/CustomWidgets/ParkingSpaceCarousel.dart';
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
        0.00,
        ["https://img.freepik.com/free-photo/city-square_1359-706.jpg?t=st=1720013545~exp=1720017145~hmac=7573362b63f0631a28b9674d3ec10b40ce3a7f0d47bfc6223fbbebce258fa768&w=2000",
          "https://img.freepik.com/free-photo/bridge-sunset_1127-2045.jpg?t=st=1720013793~exp=1720017393~hmac=c065f8215902ce3a711b12e421b8002d6ef3c4d64a19490b083311e428d6c1e8&w=2000"]),
    ParkingSpace(
        "1",
        "City Center Lot",
        "456 Center St, Cityville",
        LatLng(24.8722059, 67.0545099),
        150,
        0,
        18.00,
        ["https://img.freepik.com/free-photo/hallway-garage_23-2149397542.jpg?t=st=1720013709~exp=1720017309~hmac=800e80fa1a50cf3834b492616651f6a9bbde3bc3efaad2dc1377f7d9d9546054&w=2000",
          "https://img.freepik.com/free-photo/horizontal-picture-car-parking-underground-garage-interior-with-neon-lights-autocars-parked-buildings-urban-constructions-space-transportation-vehicle-night-city-concept_343059-3077.jpg?t=st=1720013731~exp=1720017331~hmac=324e1a9a268497cddb93da92bf2efa1a4beaf1de5593c38a93b4c919a3eabcd7&w=2000"]),
    ParkingSpace(
        "2",
        "Eastside Parking",
        "789 East St, Cityville",
        LatLng(24.8732059, 67.0555099),
        100,
        4.00,
        00,
        ["https://img.freepik.com/free-photo/blank-spaces-parking-lot_1127-36.jpg?t=st=1720013745~exp=1720017345~hmac=9e88788d92f224f7f9fc9b34ee3957155a64b6fbbd1b95972fd6e7587cbf2cd1&w=2000",
          "https://img.freepik.com/free-photo/structure-indoor-automobile-basement-large_1127-2362.jpg?t=st=1720013762~exp=1720017362~hmac=b53823777ca2d35f665c7b16fb0899f7b6bdbf4ef2d874b81653d759a7b2baeb&w=2000"]),
    ParkingSpace(
        "3",
        "Westend Garage",
        "321 West St, Cityville",
        LatLng(24.8732059, 67.0535099),
        250,
        6.00,
        00,
        ["westend_garage_1.jpg", "westend_garage_2.jpg"]),
    ParkingSpace(
        "4",
        "Northside Lot",
        "654 North St, Cityville",
        LatLng(24.8732059, 67.0835099),
        175,
        0,
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
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user.currentLocation.latitude != 0 &&
        userProvider.user.currentLocation.longitude != 0) {
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
        Provider.of<UserProvider>(context, listen: false)
            .setCurrentLocation(_currentLatLng);
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
      markerList = parkingSpacesList
          .map((parkingSpace) => Marker(
                markerId: MarkerId(parkingSpace.id),
                position: parkingSpace.latlng ?? LatLng(0, 0),
                onTap: () {},
                anchor: Offset(0, -1),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueYellow),
              ))
          .toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("_currentLatLng: $_currentLatLng");

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: _locationLoaded
          ? Stack(children: [
              Container(
                width: width,
                height: height,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  initialCameraPosition:
                      CameraPosition(target: _currentLatLng, zoom: 15),
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
                ),
              ),
              Positioned(
                top: height * 0.015, left: height * 0.015,
                right: height * 0.015,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: height * 0.015),
                        padding:
                            EdgeInsets.symmetric(horizontal: height * 0.015),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: black.withOpacity(0.15),
                                  offset: Offset(1, 1),
                                  blurRadius: 1.5,
                                  spreadRadius: 1)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: _showSearchBar
                                    ? TextField(
                                        cursorColor: primaryColor,
                                        style: TextStyle(
                                            color: primaryColor, fontSize: 14),
                                        decoration: InputDecoration(
                                          hintText: 'Search',
                                          border: InputBorder.none,
                                          hintStyle:
                                              TextStyle(color: primaryColor),
                                        ),
                                      )
                                    : Text(
                                        loc,
                                        style: TextStyle(
                                            fontSize: 14, color: primaryColor),
                                      ),
                              ),
                            ),
                            IconButton(
                              icon: _showSearchBar
                                  ? Icon(
                                      Icons.close,
                                      color: primaryColor,
                                    )
                                  : Icon(
                                      Icons.search,
                                      color: primaryColor,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _showSearchBar = !_showSearchBar;
                                });
                              },
                            ),
                          ],
                        )),
                    FloatingActionButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: primaryColor,
                      onPressed: () {
                        _getCurrentLocation();
                      },
                      child:  Icon(
                        CupertinoIcons.location,
                        color: Colors.white,
                      ),
                    ),
                    // SizedBox(
                    //   height: height * 0.015,
                    // ),
                    // FloatingActionButton(
                    //   backgroundColor: Colors.white,
                    //   onPressed: () {
                    //     _getCurrentLocation();
                    //   },
                    //   child: Icon(
                    //     Icons.location_searching,
                    //     color: primaryColor,
                    //   ),
                    // ),
                  ],
                ),
                //   child: AppBar(
                //   backgroundColor: primaryColor,
                //   leadingWidth: 30,
                //   automaticallyImplyLeading: true,
                //   title: AnimatedSwitcher(
                //     duration: Duration(milliseconds: 300),
                //     child: _showSearchBar
                //         ? TextField(
                //       cursorColor: Colors.white,
                //       style: TextStyle(color: Colors.white, fontSize: 14),
                //       decoration: InputDecoration(
                //         hintText: 'Search',
                //         border: InputBorder.none,
                //         hintStyle: TextStyle(color: Colors.white),
                //       ),
                //     )
                //         : Text(
                //       loc,
                //       style: TextStyle(fontSize: 14),
                //     ),
                //   ),
                //   actions: [
                //     IconButton(
                //       icon: _showSearchBar ? Icon(Icons.close) : Icon(Icons.search),
                //       onPressed: () {
                //         setState(() {
                //           _showSearchBar = !_showSearchBar;
                //         });
                //       },
                //     ),
                //     const SizedBox(width: 20),
                //   ],
                // ),
              ),

              Positioned(
          bottom: 0, left: 0,
          right: 0,

          child: Container(
              width: width,
              height: height*0.175,
              child: ParkingSpacesCarousel(parkingSpacesList: parkingSpacesList,))
        ),
            ])
          : Center(child: CircularProgressIndicator()),
    );
  }
}
