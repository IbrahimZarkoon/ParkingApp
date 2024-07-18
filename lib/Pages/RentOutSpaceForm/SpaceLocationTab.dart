import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Providers/UserProvider.dart';

class SpaceLocationTab extends StatefulWidget {
  const SpaceLocationTab({super.key});

  @override
  State<SpaceLocationTab> createState() => _SpaceLocationTabState();
}

class _SpaceLocationTabState extends State<SpaceLocationTab> {
  final TextEditingController _locCon = TextEditingController();
  final Completer<GoogleMapController> googleMapController = Completer();

  LatLng _userLatLng = const LatLng(0, 0);
  LatLng _selectedLatLng = const LatLng(0, 0);

  bool satelliteMode = true;

  bool parentScroll = true;

  bool _locationLoaded = false;
  String loc = "Select location";

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
    final GoogleMapController controller = await googleMapController.future;
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

  @override
  void initState() {
    super.initState();
    _checkAndSetLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _locCon.dispose();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics:parentScroll? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (details)
        {
          setState(() {
            parentScroll = true; // Disable parent scrolling when interaction starts
          });
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.network(
                    'https://img.freepik.com/free-vector/location-pin-with-winding-dashed-arrow_78370-4253.jpg?t=st=1721292915~exp=1721296515~hmac=2c4cac11d33889b45136bc8de527f1f0fa3eec89bcb2c3bf142fe18925d7ee9f&w=1480',
                    width: width/1.75,)),

                  SizedBox(height: height*0.025,),

                  Text("What is your space address?",
                    style: TextStyle(
                        color: black,
                        fontSize: height * 0.025,
                        fontFamily: "OpenSans_SemiBold"
                    ),),

                  Container(
                    margin: EdgeInsets.only(top: height*0.025),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, 0),
                          blurRadius: 1,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: TextField(
                      controller: _locCon,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: height * 0.019,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: height * 0.015,
                          vertical: height * 0.015,
                        ),
                        hintText: 'Enter your address',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: height * 0.018,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.streetAddress,
                    ),
                  ),

                  SizedBox(height: height*0.025,),

                  Text("Place the pin on the map",
                    style: TextStyle(
                        color: black,
                        fontSize: height * 0.025,
                        fontFamily: "OpenSans_SemiBold"
                    ),),
                ],
              ),
            ),

            // Location Container
            googleMapCon(),

          ],
        ),
      ),
    );
  }

  Widget googleMapCon() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      behavior: HitTestBehavior.opaque, // Ensure GestureDetector receives all touch events
      onPanDown: (details) {
        setState(() {
          parentScroll = false; // Disable parent scrolling when interaction starts
        });
      },
      onPanEnd: (details) {
        setState(() {
          parentScroll = true; // Enable parent scrolling when interaction ends
        });
      },
      child: Container(
        width: width,
        height: height * 0.5,
        margin: EdgeInsets.only(bottom: height * 0.025),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 0),
              spreadRadius: 1,
              blurRadius: 1.5,
            ),
          ],
        ),
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                googleMapController.complete(controller);
              },
              compassEnabled: true,
              onCameraMove: (CameraPosition position) {
                setState(() {
                  _selectedLatLng = position.target;
                });
              },
              onTap: (LatLng latlong) {
                setState(() {
                  _selectedLatLng = latlong;
                });
              },
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true, // Enable zoom gestures
              scrollGesturesEnabled: true, // Enable scroll gestures
              gestureRecognizers: Set()
                ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
              initialCameraPosition: CameraPosition(target: _userLatLng, zoom: 16),
              mapType: satelliteMode ? MapType.satellite : MapType.normal,
              markers: {
                Marker(
                  markerId: MarkerId("Current Location"),
                  position: _userLatLng,
                  draggable: true,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
                ),
                Marker(
                  markerId: MarkerId("Selected Location"),
                  position: _selectedLatLng,
                  draggable: true,
                  onDragEnd: (LatLng newPosition) {
                    setState(() {
                      _selectedLatLng = newPosition;
                    });
                  },
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                ),
              },
            ),
            Positioned(
              bottom: height * 0.02,
              left: height * 0.02,
              child: Container(
                height: height * 0.05,
                padding: EdgeInsets.all(height * 0.01),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(1, 1),
                      spreadRadius: 1,
                      blurRadius: 1.5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          satelliteMode = false;
                        });
                      },
                      child: Text(
                        "Map",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: height * 0.018,
                          fontWeight: satelliteMode ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: height * 0.01),
                      width: 1,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          satelliteMode = true;
                        });
                      },
                      child: Text(
                        "Satellite",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: height * 0.016,
                          fontWeight: satelliteMode ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: height * 0.02,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(height * 0.01),
                margin: EdgeInsets.symmetric(horizontal: height*0.05),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(1, 1),
                      spreadRadius: 1,
                      blurRadius: 1.5,
                    ),
                  ],
                ),
                child: Text(
                  "Drag the map to place the pin at the entrance of your parking space.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: black,
                    fontSize: height * 0.015,
                    fontFamily: "OpenSans_SemiBold",
                    fontWeight: FontWeight.bold
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
