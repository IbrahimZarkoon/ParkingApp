import 'package:airportparking/CustomWidgets/FilterBottomModal/FilterToggleButton.dart';
import 'package:airportparking/CustomWidgets/FilterBottomModal/PriceRangeFilter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';
import 'ChargingContainer.dart';

class FilterBottomModal extends StatefulWidget {
  const FilterBottomModal({super.key});

  @override
  State<FilterBottomModal> createState() => _FilterBottomModalState();
}

class _FilterBottomModalState extends State<FilterBottomModal> {

  bool smallVeh = false;
  bool mediumVeh = false;
  bool largeVeh = false;
  bool miniBusVeh = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
      Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: kToolbarHeight+height*0.025),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Top Row
              Container(
                padding: EdgeInsets.all(height * 0.025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: ()
                      {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        CupertinoIcons.xmark,
                        size: height * 0.0275,
                        color: black,
                      ),
                    ),
                    Text(
                      "Filter",
                      style: TextStyle(
                          color: black,
                          fontSize: height * 0.022,
                          fontFamily: "OpenSans_SemiBold",
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      CupertinoIcons.delete,
                      size: height * 0.0275,
                      color: Color(0xffd60f0f),
                    ),
                  ],
                ),
              ),

              shadowLine(context),

              SizedBox(
                height: height * 0.025,
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: height * 0.025),
                child: Text(
                  "Parking type",
                  style: TextStyle(
                      color: black,
                      fontSize: height * 0.02,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans_SemiBold"),
                ),
              ),

              SizedBox(
                height: height * 0.015,
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: height * 0.025),
                margin: EdgeInsets.only(bottom: height * 0.025),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  spacing: height * 0.025,
                  children: [
                    FilterToggleContainer(
                        text: "Out Door",
                        width: width,
                        height: height,
                        black: black,
                        primaryColor: primaryColor),
                    FilterToggleContainer(
                        text: "In Door",
                        width: width,
                        height: height,
                        black: black,
                        primaryColor: primaryColor)
                  ],
                ),
              ),

              shadowLine(context),

              priceColumn(),

              shadowLine(context),
              chargingColumn(),

              shadowLine(context),
              sizeColumn(),

            ],
          ),
        ),
      ),

        Positioned(
            bottom: height*0.025,left: 0,right: 0,
            child: InkWell(
              onTap: ()
              {
                Navigator.pop(context);
              },
              child: Container(
                        margin: EdgeInsets.symmetric(horizontal: height * 0.025),
                        padding: EdgeInsets.symmetric(vertical: height*0.015),
                        width: width,
                        decoration: BoxDecoration(
              color: primaryColor,
              border: Border.all(color: primaryColor,width: 1.5),
              borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
              "Apply",
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.02,
                fontFamily: "OpenSans_SemiBold",
              ),
                        ),
                      ),
            ))

    ]
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

  Widget sizeColumn()
  {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.025),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Vehicle Size",
            style: TextStyle(
                color: black,
                fontSize: height * 0.02,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans_SemiBold"
            ),),

          vehicleSizeCon(
              "Small",
              "i.e. VW Polo, Ford Fiesta",
              "assets/images/Blue_Hatchback.png",
              isTap: smallVeh,
              onTap: () {
                setState(() {
                  smallVeh = !smallVeh;

                });
              }
          ),

          vehicleSizeCon(
              "Medium",
              "i.e. Audi A3",
              "assets/images/Blue_Sedan.png",
              isTap: mediumVeh,
              onTap: () {
                setState(() {
                  mediumVeh = !mediumVeh;

                });
              }
          ),

          vehicleSizeCon(
              "Large",
              "i.e. Volvo XC90",
              "assets/images/SUV.png",
              isTap: largeVeh,
              onTap: () {
                setState(() {
                  largeVeh = !largeVeh;

                });
              }
          ),

          vehicleSizeCon(
              "Van & Minibus",
              "i.e. Ford Sprinter",
              "assets/images/Van.png",
              isTap: miniBusVeh,
              onTap: () {
                setState(() {
                  miniBusVeh = !miniBusVeh;

                });
              }
          )

        ],
      ),
    );
  }

  Widget priceColumn()
  {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.025),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Pricing",
            style: TextStyle(
                color: black,
                fontSize: height * 0.02,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans_SemiBold"
            ),),

          PriceRangeFilter()

        ],
      ),
    );
  }

  Widget chargingColumn()
  {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.025),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Vehicle Charging",
            style: TextStyle(
                color: black,
                fontSize: height * 0.02,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans_SemiBold"
            ),),

          SizedBox(height: height*0.015,),

          Container(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              spacing: height * 0.025,
              runSpacing: height*0.025,
              children: [
                ToggleContainerWithImage(
                  imageUrl: "assets/images/Pin_1.png",
                  width: width,
                  height: height,
                  black: black,
                  primaryColor: primaryColor,
                ),
                ToggleContainerWithImage(
                  imageUrl: "assets/images/Pin_2.png",
                  width: width,
                  height: height,
                  black: black,
                  primaryColor: primaryColor,
                ),
                ToggleContainerWithImage(
                  imageUrl: "assets/images/Pin_2.png",
                  width: width,
                  height: height,
                  black: black,
                  primaryColor: primaryColor,
                ),
                ToggleContainerWithImage(
                  imageUrl: "assets/images/Pin_1.png",
                  width: width,
                  height: height,
                  black: black,
                  primaryColor: primaryColor,
                ),
              ],
            ),
          ),




        ],
      ),
    );
  }


}
