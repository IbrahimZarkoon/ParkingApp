import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Constants/Colors.dart';
import '../Modals/ParkingSpaceClass.dart';
import 'DurationPickerDialog.dart';

class BookingsBottomModal extends StatefulWidget {
  const BookingsBottomModal({super.key, required this.parkingSpace});
  final ParkingSpace parkingSpace;
  @override
  State<BookingsBottomModal> createState() => _BookingsBottomModalState();
}

class _BookingsBottomModalState extends State<BookingsBottomModal> {

  final Completer<GoogleMapController> googleMapController = Completer();
  final ScrollController _scrollController = ScrollController();

  Timer? _timer;
  Duration _TimerDuration = Duration(hours: 2,minutes: 16,seconds: 31);


  double totalAmount = 0.0;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _TimerDuration += Duration(seconds: 1);
        calculateTotal(double.parse("${widget.parkingSpace.dailyRate}"), double.parse("${widget.parkingSpace.hourlyRate}"));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    calculateTotal(double.parse("${widget.parkingSpace.dailyRate}"), double.parse("${widget.parkingSpace.hourlyRate}"));
    startTimer();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels < _scrollController.position.minScrollExtent) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  void calculateTotal(double dailyRate, double hourlyRate) {
    int days = _TimerDuration.inDays;
    int hours = _TimerDuration.inHours.remainder(24);
    int minutes = _TimerDuration.inMinutes.remainder(60);

    if (dailyRate > 0) {
      // Calculate total based on daily rate
      totalAmount = days * dailyRate;

      // If there are remaining hours or minutes, calculate additional amount
      if (hours > 0 || minutes > 0) {
        totalAmount += (hours * dailyRate / 24) + (minutes * dailyRate / (24 * 60));
      }
    } else if (hourlyRate > 0) {
      // Calculate total based on hourly rate
      totalAmount = days * 24 * hourlyRate + hours * hourlyRate + (minutes / 60) * hourlyRate;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: height * 0.035, vertical: height * 0.035),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        // Location Container
        Container(
          width: width,
          height: height * 0.25,
          margin: EdgeInsets.only(bottom: height * 0.025),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 0),
                    spreadRadius: 1,
                    blurRadius: 1.5
                )
              ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                googleMapController.complete(controller);
              },
              compassEnabled: true,
              onCameraMove: (position) {},
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              initialCameraPosition:
              CameraPosition(target: widget.parkingSpace.latlng ?? const LatLng(0, 0), zoom: 16),
              onTap: (latlong) {
                print(latlong);
              },
              mapType: MapType.satellite,
              markers: {
                Marker(
                  markerId: MarkerId(widget.parkingSpace.id),
                  position: widget.parkingSpace.latlng ?? const LatLng(0, 0),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
                )
              },
            ),
          ),
        ),

        // Details Column
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              "${widget.parkingSpace.title}",
              style: TextStyle(color: Colors.black, fontSize: height * 0.03, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: height * 0.005),

            Text(
              "${widget.parkingSpace.address}",
              style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: height * 0.02, fontWeight: FontWeight.normal),
            ),

            SizedBox(height: height * 0.01),

            // Capacity and Price Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(CupertinoIcons.car_detailed, size: height * 0.025, color: Colors.black.withOpacity(0.8)),
                // SizedBox(width: height * 0.01),
                // Text(
                //   '${widget.parkingSpace.capacity}',
                //   style: TextStyle(fontSize: height * 0.02, fontWeight: FontWeight.normal),
                // ),
                // SizedBox(width: height * 0.015),
                Icon(CupertinoIcons.money_dollar_circle, size: height * 0.025, color: Colors.black.withOpacity(0.8)),
                SizedBox(width: height * 0.01),
                if (widget.parkingSpace.hourlyRate! > 0)
                  Text(
                    '\$${widget.parkingSpace.hourlyRate}/hr',
                    style: TextStyle(fontSize: height * 0.02, fontWeight: FontWeight.normal),
                  ),
                if (widget.parkingSpace.dailyRate! > 0)
                  Text(
                    '\$${widget.parkingSpace.dailyRate}/day',
                    style: TextStyle(fontSize: height * 0.02, fontWeight: FontWeight.normal),
                  ),
              ],
            ),

            vehicleSizeCon("BMW M5", "AB-3344", "assets/images/Blue_Sedan.png"),

            SizedBox(height: height * 0.025),

            // Time and Place Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.4,
                  height: height*0.2,
                  padding: EdgeInsets.all(height * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 0),
                        spreadRadius: 1,
                        blurRadius: 1.5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(height * 0.005),
                        decoration: BoxDecoration(
                          color: Color(0xffffea00),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Icon(Icons.local_parking, size: height * 0.04, color: Colors.black),
                      ),
                      SizedBox(height: height * 0.01),
                      Text('B1', style: TextStyle(fontSize: height * 0.02, fontWeight: FontWeight.bold)),
                      SizedBox(height: height * 0.01),
                      Text('Parking Place', style: TextStyle(fontSize: height * 0.02)),
                    ],
                  ),
                ),
                SizedBox(width: width * 0.05),
                Container(
                  width: width * 0.4,
                  height: height*0.2,
                  padding: EdgeInsets.all(height * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(height * 0.025),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 0),
                        spreadRadius: 1,
                        blurRadius: 1.5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(height * 0.005),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Icon(Icons.access_time, size: height * 0.04, color: Colors.white),
                      ),
                      SizedBox(height: height * 0.01),
                      Text('Time elapsed', style: TextStyle(fontSize: height * 0.02, fontWeight: FontWeight.bold)),
                      SizedBox(height: height * 0.01),
                      Text(
                        '${_TimerDuration.inDays > 0 ? _TimerDuration.inDays.toString().padLeft(2, '0') + ' days ' : ''}${_TimerDuration.inHours.remainder(24).toString().padLeft(2, '0')} hrs ${_TimerDuration.inMinutes.remainder(60).toString().padLeft(2, '0')} mins ${_TimerDuration.inSeconds.remainder(60).toString().padLeft(2, '0')} secs',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: height * 0.02),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.035),

            // Total and Book Now Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Price Container
                Flexible(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(height * 0.015),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '\$${totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: height * 0.024, color: Colors.black),
                    ),
                  ),
                ),

                SizedBox(width: width * 0.05),

                // Book Now Container
                Flexible(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      // Handle booking logic here
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(height * 0.015),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(height * 0.025),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0, 0),
                              spreadRadius: 1,
                              blurRadius: 1.5,
                            ),
                          ],
                        ),
                        child: Text(
                          "End Booking",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: height * 0.024, color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget vehicleSizeCon(String title, String desc, String img,
      {bool isTap = false, VoidCallback? onTap}) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: height * 0.025),
        width: width,
        padding: EdgeInsets.all(height * 0.015),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 0),
              spreadRadius: 1,
              blurRadius: 1.5,
            ),
          ],
          color: Colors.white,
          border: Border.all(color: isTap ? primaryColor : Colors.white,),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(
                    color: isTap ? primaryColor : black,
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.bold,
                  )),

                  Text(desc, style: TextStyle(
                    color: isTap ? primaryColor : black,
                    fontSize: height * 0.016,
                    fontWeight: FontWeight.bold,
                  )),
                ],
              ),
            ),

            Container(
              width: width * 0.2,
              height: width * 0.15,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.cover
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
