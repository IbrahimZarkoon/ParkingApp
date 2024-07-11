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


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text("Space availability",
              style: TextStyle(
                color: black,
                fontSize: height * 0.0325,
                fontWeight: FontWeight.bold,
              ),),

            SizedBox(height: height*0.025,),

            Center(child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://img.freepik.com/free-vector/smartphone-controlling-smart-home_24877-52888.jpg?t=st=1720706919~exp=1720710519~hmac=180e0f3d8a812b8f2964604863c8182985bc8bc5d73cb3f96f5165dfaea131be&w=1480',
                width: width/1.25,height: height*0.25,fit: BoxFit.cover,),
            )),

            SizedBox(height: height*0.025,),

            Text("What type of bookings do you want?",
              style: TextStyle(
                  color: black,
                  fontSize: height * 0.025,
                  fontFamily: "OpenSans_SemiBold"
              ),),

            bookingTypeCon(
                "All bookings (maximum earnings)",
                "Accept both monthly and standard (hourly / daily) bookings.",
                isTap: allBookings,
                onTap: () {
                  setState(() {
                    allBookings = !allBookings;
                    standardBookings = false;
                    monthlyBookings = false;
                  });
                }
            ),

            bookingTypeCon(
                "Standard bookings - hourly / daily",
                "Drivers will be able to book your parking space for hours, days or weeks.",
                isTap: standardBookings,
                onTap: () {
                  setState(() {
                    allBookings = false;
                    standardBookings = !standardBookings;
                    monthlyBookings = false;
                  });
                }
            ),

            bookingTypeCon(
                "Monthly bookings",
                "Accepting monthly rolling bookings means that a single driver will use this space. You will receive a regular monthly income.",
                isTap: monthlyBookings,
                onTap: () {
                  setState(() {
                    allBookings = false;
                    standardBookings = false;
                    monthlyBookings = !monthlyBookings;
                  });
                }
            ),



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
          border: Border.all(color: isTap ? primaryColor : Colors.white,),
          boxShadow: [
            BoxShadow(
              color: isTap ? primaryColor.withOpacity(0.25) : Colors.black.withOpacity(0.25),
              offset: Offset(0, 0),
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
                  Text(title, style: TextStyle(
                    color: isTap ? primaryColor : black,
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.bold,
                  )),

                  Text(desc, style: TextStyle(
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
}
