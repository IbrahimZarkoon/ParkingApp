import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Constants/Colors.dart';
import '../../Providers/UserProvider.dart';

class SummaryTab extends StatefulWidget {
  const SummaryTab({super.key});

  @override
  State<SummaryTab> createState() => _SummaryTabState();
}

class _SummaryTabState extends State<SummaryTab> {
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: height * 0.025, vertical: height * 0.02),
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's get your listing available for bookings",
            style: TextStyle(
              color: black,
              fontSize: height * 0.0325,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            height:height*0.25,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  googleMapController.complete(controller);
                },
                compassEnabled: true,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                initialCameraPosition: CameraPosition(target: _userLatLng, zoom: 16),
                mapType: satelliteMode ? MapType.satellite : MapType.normal,
                markers: {
                  Marker(
                    markerId: MarkerId("Selected Location"),
                    position: _userLatLng,
                    draggable: false,
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                  ),
                },
              ),
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          summaryRow(CupertinoIcons.location_solid, "x2 Driveway ",
              "on 1002, The Hacienda 11-15, Whitworth Street West Manchester, M1 5DD"),

          summaryRow(CupertinoIcons.money_dollar_circle, "\$5.40 ",
              "per day"),

          summaryRow(CupertinoIcons.home, "Space includes: ",
              "Electric vehicle charging."),

          summaryRow(Icons.local_parking_outlined, "All Bookings: ",
              "accept both monthly rolling and standard (hourly / daily) bookings.")
        ],
      ),
    );
  }

  Widget summaryRow(IconData iconData, String boldText, String normalText) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height*0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, size: height * 0.0275, color: black),
          SizedBox(
            width: height * 0.015,
          ),
          Flexible(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: black, fontSize: height * 0.018,wordSpacing: height*0.001),
                children: [
                  TextSpan(
                    text: boldText,
                    style: TextStyle(
                      color: black,
                        fontFamily: "OpenSans_SemiBold",
                        fontSize: height * 0.018),
                  ),
                  TextSpan(
                    text: ' $normalText',
                    style: TextStyle(
                        fontSize: height * 0.017, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
