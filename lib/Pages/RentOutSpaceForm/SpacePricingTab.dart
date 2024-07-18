import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';

class SpacePricingTab extends StatefulWidget {
  const SpacePricingTab({super.key});

  @override
  State<SpacePricingTab> createState() => _SpacePricingTabState();
}

class _SpacePricingTabState extends State<SpacePricingTab> {
  final TextEditingController _zipCodeCon = TextEditingController();

  bool automatedPricing = false;
  bool manualPricing = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _zipCodeCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.02),
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text("Space pricing",
            style: TextStyle(
              color: black,
              fontSize: height * 0.0325,
              fontWeight: FontWeight.bold,
            ),),


          Center(child: Image.network(
            'https://img.freepik.com/free-vector/reserve-parking-space-curbside-pickup-abstract-concept-illustration-customer-walk-pickup-station-customers-arrival-keep-employees-safe-small-business_335657-3337.jpg?t=st=1721299991~exp=1721303591~hmac=5828734a6d98daf5b2d9cd4cf67e2e3c3d1a2a52be6828cb3efc95c27c6215cf&w=1480',
            width: width/1.5,)),

          SizedBox(height: height*0.025,),

          Text("What pricing works best for you?",
            style: TextStyle(
                color: black,
                fontSize: height * 0.025,
                fontFamily: "OpenSans_SemiBold"
            ),),

          bookingTypeCon("Automated (recommended)",
              "We'll set the price on your behalf taking into account seasonal trends and local demand.",
              isTap: automatedPricing, onTap: () {
                setState(() {
                  manualPricing = false;
                  automatedPricing = !automatedPricing;
                });
              }),

          bookingTypeCon("Manual",
              "Set your own prices.",
              isTap: manualPricing, onTap: () {
                setState(() {
                  automatedPricing = false;
                  manualPricing = !manualPricing;
                });
              }),

          if(automatedPricing)
            automatedPricingColumn(),

          if(manualPricing)
            manualPricingColumn()
        ],
      ),
    );
  }

  Widget automatedPricingColumn()
  {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: height*0.025,),

        Text("The pricing breakdown",
          style: TextStyle(
              color: black,
              fontSize: height * 0.025,
              fontFamily: "OpenSans_SemiBold"
          ),),

        SizedBox(height: height*0.005,),
        Text("We will initially set your listing price as the following, but may change this based on the demand we see in your area.",
          style: TextStyle(
              color: black,
              fontSize: height * 0.016,
              fontFamily: "OpenSans_SemiBold"
          ),),

        SizedBox(height: height*0.025,),


        buildAutoPricingRow(CupertinoIcons.timer, "0.93", "per hour"),
        buildAutoPricingRow(CupertinoIcons.calendar_today, "5.40", "per day"),
        buildAutoPricingRow(CupertinoIcons.calendar, "27.00", "per week"),
        buildAutoPricingRow(CupertinoIcons.calendar, "89.93", "per monthly booking"),

        SizedBox(height: height*0.025,),

        Text("Good news, any earnings below \$1,000 are tax free!",
          style: TextStyle(
              color: black,
              fontSize: height * 0.016,
              fontFamily: "OpenSans_SemiBold"
          ),),

      ],

    );
  }

  Widget manualPricingColumn()
  {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: height*0.025,),

        Text("Set the space pricing",
          style: TextStyle(
              color: black,
              fontSize: height * 0.025,
              fontFamily: "OpenSans_SemiBold"
          ),),

        SizedBox(height: height*0.005,),
        Text("We've pre-populated the pricing using the average for your area and its a guide to what drivers will expect to pay. You can change this by simply selecting the relevant price.",
          style: TextStyle(
              color: black,
              fontSize: height * 0.016,
              fontFamily: "OpenSans_SemiBold"
          ),),

        SizedBox(height: height*0.025,),


        buildManualPricingRow(CupertinoIcons.timer, "Hourly",),
        buildManualPricingRow(CupertinoIcons.calendar_today, "Daily"),
        buildManualPricingRow(CupertinoIcons.calendar, "Weekly", ),
        buildManualPricingRow(CupertinoIcons.calendar, "Monthly",),

        SizedBox(height: height*0.025,),
      ],

    );
  }

  Widget buildAutoPricingRow(IconData iconData, String price, String perHourText) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height*0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, size: height*0.0275,color: black),
          SizedBox(width: height*0.015,),
          Text(
            "\$$price",
            style: TextStyle(fontFamily: "OpenSans_SemiBold",fontSize: height*0.02,color: black),
          ),
          Text(" / $perHourText", style: TextStyle(fontSize: height*0.018,color: black)),
        ],
      ),
    );
  }

  Widget buildManualPricingRow(IconData iconData, String title) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height*0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(iconData, size: height*0.0275,color: black),
              SizedBox(width: height*0.015,),
              Container(
                width: width*0.175,
                child: Text(
                  title,
                  style: TextStyle(fontFamily: "OpenSans_SemiBold",fontSize: height*0.02,color: black),
                ),
              ),
              SizedBox(width: height*0.015,),

              Text("\$", style: TextStyle(fontSize: height*0.022,color: black,fontFamily: "OpenSans_SemiBold",)),
              SizedBox(width: height*0.015,),
            ],
          ),


          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: width*0.5
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter price',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: height*0.015),
                ),
                style: TextStyle(fontSize: height*0.018),
              ),
            ),
          ),
        ],
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
}
