import 'package:airportparking/CustomWidgets/setDaysBottomModalSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';

class SpaceAvailabilityTab extends StatefulWidget {
  const SpaceAvailabilityTab({super.key});

  @override
  State<SpaceAvailabilityTab> createState() => _SpaceAvailabilityTabState();
}

class _SpaceAvailabilityTabState extends State<SpaceAvailabilityTab> {
  bool allBookings = false;
  bool standardBookings = false;
  bool monthlyBookings = false;

  bool alwaysAv = false;
  bool workingWeek = false;
  bool custom = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
            horizontal: height * 0.025, vertical: height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Space availability",
              style: TextStyle(
                color: black,
                fontSize: height * 0.0325,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://img.freepik.com/free-vector/smartphone-controlling-smart-home_24877-52888.jpg?t=st=1720706919~exp=1720710519~hmac=180e0f3d8a812b8f2964604863c8182985bc8bc5d73cb3f96f5165dfaea131be&w=1480',
                width: width / 1.25,
                height: height * 0.25,
                fit: BoxFit.cover,
              ),
            )),
            SizedBox(
              height: height * 0.025,
            ),
            Text(
              "What type of bookings do you want?",
              style: TextStyle(
                  color: black,
                  fontSize: height * 0.025,
                  fontFamily: "OpenSans_SemiBold"),
            ),
            bookingTypeCon("All bookings (maximum earnings)",
                "Accept both monthly and standard (hourly / daily) bookings.",
                isTap: allBookings, onTap: () {
              setState(() {
                allBookings = !allBookings;
                standardBookings = false;
                monthlyBookings = false;
              });
            }),
            bookingTypeCon("Standard bookings - hourly / daily",
                "Drivers will be able to book your parking space for hours, days or weeks.",
                isTap: standardBookings, onTap: () {
              setState(() {
                allBookings = false;
                standardBookings = !standardBookings;
                monthlyBookings = false;
              });
            }),
            bookingTypeCon("Monthly bookings",
                "Accepting monthly rolling bookings means that a single driver will use this space. You will receive a regular monthly income.",
                isTap: monthlyBookings, onTap: () {
              setState(() {
                allBookings = false;
                standardBookings = false;
                monthlyBookings = !monthlyBookings;
              });
            }),
            if (allBookings || standardBookings) setAvailabilityColumn(),
          ],
        ),
      ),
    );
  }

  Widget bookingTypeCon(String title, String desc,
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
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          border: Border.all(
            color: isTap ? primaryColor : Colors.white,
          ),
          boxShadow: [
            BoxShadow(
              color: isTap
                  ? primaryColor.withOpacity(0.25)
                  : Colors.black.withOpacity(0.25),
              offset: const Offset(0, 0),
              blurRadius: 1,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: TextStyle(
                        color: isTap ? primaryColor : black,
                        fontSize: height * 0.018,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(desc,
                      style: TextStyle(
                        color: isTap ? primaryColor : black,
                        fontSize: height * 0.016,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setAvailabilityColumn() {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.025,
        ),
        Text(
          "Set the availability for your space",
          style: TextStyle(
              color: black,
              fontSize: height * 0.025,
              fontFamily: "OpenSans_SemiBold"),
        ),
        Text(
          "You can change this any time",
          style: TextStyle(
            color: black.withOpacity(0.6),
            fontSize: height * 0.017,
          ),
        ),
        bookingTypeCon(
          "Always available (Recommended)",
          "Monday - Sunday (06:00 - 19:00)",
          isTap: alwaysAv,
          onTap: () {
            setState(() {
              custom = false;
              alwaysAv = true;
              workingWeek = false;
            });
          },
        ),
        bookingTypeCon(
          "Working week",
          "Monday - Friday (06:00 - 19:00)",
          isTap: workingWeek,
          onTap: () {
            setState(() {
              custom = false;
              alwaysAv = false;
              workingWeek = true;
            });
          },
        ),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            setState(() {
              custom = !custom;
              workingWeek = false;
              alwaysAv = false;
            });

            showSetDaysBottomSheet(context, height, width, primaryColor);
          },
          child: Container(
            margin: EdgeInsets.only(top: height * 0.025),
            width: width,
            padding: EdgeInsets.all(height * 0.015),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              border: Border.all(
                color: custom ? primaryColor : Colors.white,
              ),
              boxShadow: [
                BoxShadow(
                  color: custom
                      ? primaryColor.withOpacity(0.25)
                      : Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 0),
                  blurRadius: 1,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Custom",
                          style: TextStyle(
                            color: custom ? primaryColor : black,
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("Personalised settings",
                          style: TextStyle(
                            color: custom ? primaryColor : black,
                            fontSize: height * 0.016,
                          )),
                    ],
                  ),
                ),
                Icon(
                  CupertinoIcons.right_chevron,
                  color: custom ? primaryColor : black,
                  size: height * 0.025,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showSetDaysBottomSheet(BuildContext context, double height, double width, Color primaryColor) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        return setDaysBottomSheet(height: height, width: width, primaryColor: primaryColor);
      },
    );
  }
}
