import 'dart:async';

import 'package:airportparking/Modals/ParkingSpaceClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Constants/Colors.dart';
import 'DurationPickerDialog.dart';

class SingleParkingSpaceModal extends StatefulWidget {
  SingleParkingSpaceModal({super.key, required this.parkingSpace});

  final ParkingSpace parkingSpace;

  @override
  State<SingleParkingSpaceModal> createState() => _SingleParkingSpaceModalState();
}

class _SingleParkingSpaceModalState extends State<SingleParkingSpaceModal> {
  final Completer<GoogleMapController> googleMapController = Completer();
  final ScrollController _scrollController = ScrollController();

  Duration selectedDuration = Duration(days: 0, hours: 0, minutes: 0);

  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels <= _scrollController.position.minScrollExtent) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDuration(BuildContext context) async {
    final Duration? picked = await showDialog<Duration>(
      context: context,
      builder: (context) {
        return DurationPicker(initialDuration: selectedDuration);
      },
    );
    if (picked != null) {
      setState(() {
        selectedDuration = picked;
        calculateTotal(widget.parkingSpace.dailyRate ?? 0, widget.parkingSpace.hourlyRate ?? 0);
      });
    }
  }

  void calculateTotal(double dailyRate, double hourlyRate) {
    int days = selectedDuration.inDays;
    int hours = selectedDuration.inHours.remainder(24);
    int minutes = selectedDuration.inMinutes.remainder(60);

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
              liteModeEnabled: true,
              onCameraMove: (position) {},
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              initialCameraPosition:
              CameraPosition(target: widget.parkingSpace.latlng ?? const LatLng(0, 0), zoom: 15),
              onTap: (latlong) {
                print(latlong);
              },
              mapType: MapType.terrain,
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
                Icon(CupertinoIcons.car_detailed, size: height * 0.025, color: Colors.black.withOpacity(0.8)),
                SizedBox(width: height * 0.01),
                Text(
                  '${widget.parkingSpace.capacity}',
                  style: TextStyle(fontSize: height * 0.02, fontWeight: FontWeight.normal),
                ),
                SizedBox(width: height * 0.015),
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

            SizedBox(height: height * 0.025),

            // Time and Place Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.4,
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                InkWell(
                  onTap: () async {
                    await _selectDuration(context);
                  },
                  child: Container(
                    width: width * 0.4,
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        if (!(selectedDuration.inDays > 0))
                          Text(
                            'Select Duration',
                            style: TextStyle(fontSize: height * 0.02, color: primaryColor, fontWeight: FontWeight.bold),
                          ),
                        SizedBox(height: height * 0.01),
                        Text(
                          '${selectedDuration.inDays > 0 ? selectedDuration.inDays.toString().padLeft(2, '0') + ' days ' : ''}${selectedDuration.inHours.remainder(24).toString().padLeft(2, '0')} hrs ${selectedDuration.inMinutes.remainder(60).toString().padLeft(2, '0')} mins',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: height * 0.02),
                        ),
                      ],
                    ),
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
                          "Book Now",
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
}