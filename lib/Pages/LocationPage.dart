import 'dart:async';

import 'package:airportparking/Constants/Colors.dart';
import 'package:airportparking/CustomWidgets/ParkingSpaceCarousel.dart';
import 'package:airportparking/Modals/ParkingSpaceClass.dart';
import 'package:airportparking/Providers/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Constants/Icons.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  final Completer<GoogleMapController> _controller = Completer();
  late PageController _pageController;

  FocusNode searchNode = FocusNode();

  LatLng _userLatLng = const LatLng(0, 0);
  LatLng _selectedLatLng = const LatLng(0, 0);

  bool _locationLoaded = false;
  String loc = "Select location";
  bool _showSearchBar = false;
  String _searchQuery = '';

  List<ParkingSpace> parkingSpacesList = [
    ParkingSpace(
        "0",
        "Downtown Garage",
        "123 Main St, Cityville",
        const LatLng(24.8742059, 67.0545099),
        200,
        5.00,
        0.00,
        ["https://img.freepik.com/free-photo/city-square_1359-706.jpg?t=st=1720013545~exp=1720017145~hmac=7573362b63f0631a28b9674d3ec10b40ce3a7f0d47bfc6223fbbebce258fa768&w=2000",
          "https://img.freepik.com/free-photo/bridge-sunset_1127-2045.jpg?t=st=1720013793~exp=1720017393~hmac=c065f8215902ce3a711b12e421b8002d6ef3c4d64a19490b083311e428d6c1e8&w=2000"]),
    ParkingSpace(
        "1",
        "City Center Lot",
        "456 Center St, Cityville",
        const LatLng(24.8722059, 67.0545099),
        150,
        0,
        18.00,
        ["https://img.freepik.com/free-photo/hallway-garage_23-2149397542.jpg?t=st=1720013709~exp=1720017309~hmac=800e80fa1a50cf3834b492616651f6a9bbde3bc3efaad2dc1377f7d9d9546054&w=2000",
          "https://img.freepik.com/free-photo/horizontal-picture-car-parking-underground-garage-interior-with-neon-lights-autocars-parked-buildings-urban-constructions-space-transportation-vehicle-night-city-concept_343059-3077.jpg?t=st=1720013731~exp=1720017331~hmac=324e1a9a268497cddb93da92bf2efa1a4beaf1de5593c38a93b4c919a3eabcd7&w=2000"]),
    ParkingSpace(
        "2",
        "Eastside Parking",
        "789 East St, Cityville",
        const LatLng(24.8732059, 67.0555099),
        100,
        4.00,
        00,
        ["https://img.freepik.com/free-photo/blank-spaces-parking-lot_1127-36.jpg?t=st=1720013745~exp=1720017345~hmac=9e88788d92f224f7f9fc9b34ee3957155a64b6fbbd1b95972fd6e7587cbf2cd1&w=2000",
          "https://img.freepik.com/free-photo/structure-indoor-automobile-basement-large_1127-2362.jpg?t=st=1720013762~exp=1720017362~hmac=b53823777ca2d35f665c7b16fb0899f7b6bdbf4ef2d874b81653d759a7b2baeb&w=2000"]),
    ParkingSpace(
        "3",
        "Westend Garage",
        "321 West St, Cityville",
        const LatLng(24.8732059, 67.0535099),
        250,
        6.00,
        00,
        ["westend_garage_1.jpg", "westend_garage_2.jpg"]),
    ParkingSpace(
        "4",
        "Northside Lot",
        "654 North St, Cityville",
        const LatLng(24.8732059, 67.0835099),
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
    _pageController = PageController();
    _createMarkers(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _checkAndSetLocation() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user.currentLocation.latitude != 0 &&
        userProvider.user.currentLocation.longitude != 0) {
      setState(() {
        _userLatLng = userProvider.user.currentLocation;
        _locationLoaded = true;
        loc = "${_userLatLng.latitude}, ${_userLatLng.longitude}";
      });
      _moveCamera(_userLatLng);
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await determinePosition();
      setState(() {
        _userLatLng = LatLng(position.latitude, position.longitude);
        Provider.of<UserProvider>(context, listen: false)
            .setCurrentLocation(_userLatLng);
        _locationLoaded = true;
        loc = "${_userLatLng.latitude}, ${_userLatLng.longitude}";
      });
      _moveCamera(_userLatLng);
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

  void _createMarkers(int selectedIndex) {
    setState(() {
      markerList = parkingSpacesList.map((parkingSpace) {
        int index = parkingSpacesList.indexOf(parkingSpace);
        return Marker(
          markerId: MarkerId(parkingSpace.id),
          position: parkingSpace.latlng ?? const LatLng(0, 0),
          onTap: () {
            setState(() {
              _selectedLatLng = parkingSpace.latlng!;
            });
            print("SELECTED ::::::::::;; $_selectedLatLng");
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          icon: index == selectedIndex
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
          // Remove or adjust the anchor property
          // anchor: const Offset(0.5, 0.5), // Center of the marker
        );
      }).toSet();
    });
  }

  void _onCarouselChange(LatLng target) {
    _moveCamera(target);
  }

  List<ParkingSpace> _searchParkingSpaces(String query) {
    return parkingSpacesList
        .where((space) =>
    space.title!.toLowerCase().contains(query.toLowerCase()) ||
        space.address!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    print("_currentLatLng: $_userLatLng");

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    List<ParkingSpace> filteredParkingSpaces =
    _searchParkingSpaces(_searchQuery);


    return Scaffold(
      body: _locationLoaded
          ? SafeArea(
            child: Stack(children: [
                SizedBox(
                  width: width,
                  height: height,
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    compassEnabled: true,
                    onCameraMove: (position)
                    {
                      searchNode.unfocus();
                    },
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    initialCameraPosition:
                        CameraPosition(target: _userLatLng, zoom: 15),
                    onTap: (latlong) {
                      print(latlong);
                    },
                    mapType: MapType.terrain,

                    markers: {
            
                      Marker(
                        markerId: const MarkerId('currentLocation'),
                        position: _userLatLng,
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
                      Row(
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: ()
                              {
                                setState(() {
                                  _showSearchBar = true;
                                });
                                searchNode.requestFocus();
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: height * 0.015,right: height * 0.015),
                                padding: EdgeInsets.symmetric(horizontal: height * 0.015),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.15),
                                      offset: const Offset(1, 1),
                                      blurRadius: 1.5,
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 300),
                                        child: _showSearchBar
                                            ? TextField(
                                          focusNode: searchNode,
                                          cursorColor: primaryColor,
                                          style: TextStyle(
                                              color: primaryColor, fontSize: 14),
                                          decoration: InputDecoration(
                                            hintText: 'Where are you going?',
                                            border: InputBorder.none,
                                            hintStyle:
                                            TextStyle(color: primaryColor),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              _searchQuery = value;
                                            });
                                          },
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
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: height * 0.015),
                            padding: EdgeInsets.all( height * 0.015),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: black.withOpacity(0.15),
                                  offset: const Offset(1, 1),
                                  blurRadius: 1.5,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: SvgPicture.string(
                              svgFilterIcon,
                              fit: BoxFit.contain,
                              color: white,
                            ),
                          ),
                        ],
                      ),
                      if (_searchQuery.isNotEmpty) Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: black.withOpacity(0.15),
                                offset: const Offset(1, 1),
                                blurRadius: 1.5,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredParkingSpaces.length,
                            itemBuilder: (context, index) {
                              final space = filteredParkingSpaces[index];
                              return ListTile(
                                title: Text("${space.title}"),
                                subtitle: Text("${space.address}"),
                                onTap: () {
                                  _moveCamera(space.latlng!);
                                  int ind = parkingSpacesList.indexOf(space);
                                  _pageController.animateToPage(
                                    ind,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                  setState(() {
                                    _showSearchBar = false;
                                    loc = "${space.title}";
                                    _searchQuery = '';
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      InkWell(
                        onTap: ()
                        async {
                          await _getCurrentLocation();
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: height * 0.015),
                          padding: EdgeInsets.all( height * 0.015),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: black.withOpacity(0.15),
                                offset: const Offset(1, 1),
                                blurRadius: 1.5,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: const Icon(
                            CupertinoIcons.location,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
            
                ),
            
                Positioned(
            bottom: 0, left: 0,
            right: 0,
            
                    child: SizedBox(
                      width: width,
                      height: height*0.175,
                      child: FutureBuilder<GoogleMapController>(
                        future: _controller.future,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return ParkingSpacesCarousel(
                              createMarkers: _createMarkers,
                              parkingSpacesList: parkingSpacesList,
                              gmController: snapshot.data!,
                              pageController: _pageController,
                              onCarouselChange: _onCarouselChange,
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                )]),
          )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
