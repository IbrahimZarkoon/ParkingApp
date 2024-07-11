import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';

class ElectricChargersTab extends StatefulWidget {
  const ElectricChargersTab({super.key});

  @override
  State<ElectricChargersTab> createState() => _ElectricChargersTabState();
}

class _ElectricChargersTabState extends State<ElectricChargersTab> {
  bool isElectricYesSelected = false;
  bool isElectricNoSelected = false;

  bool isShareYesSelected = false;
  bool isShareNoSelected = false;

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

            Text("Do you have an electric vehicle charger?",
              style: TextStyle(
                  color: black,
                  fontSize: height * 0.025,
                  fontFamily: "OpenSans_SemiBold"
              ),),

            SizedBox(height: height*0.025,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isElectricYesSelected = true;
                        isElectricNoSelected = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: height * 0.015, horizontal: height * 0.025),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                        border: Border.all(color: isElectricYesSelected ? primaryColor : Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: isElectricYesSelected ? primaryColor.withOpacity(0.25) : Colors.black.withOpacity(0.25),
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          fontSize: height * 0.018,
                          fontFamily: "OpenSans_SemiBold",
                          color: isElectricYesSelected ? primaryColor : black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: height * 0.025),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isElectricYesSelected = false;
                        isElectricNoSelected = true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: height * 0.015, horizontal: height * 0.025),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                        border: Border.all(color: isElectricNoSelected ? primaryColor : Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: isElectricNoSelected ? primaryColor.withOpacity(0.25) : Colors.black.withOpacity(0.25),
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Text(
                        "No",
                        style: TextStyle(
                          fontSize: height * 0.018,
                          fontFamily: "OpenSans_SemiBold",
                          color: isElectricNoSelected ? primaryColor : black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: height*0.025,),

            if(isElectricYesSelected)Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you want to share your electric vehicle charger with drivers?",
                  style: TextStyle(
                      color: black,
                      fontSize: height * 0.025,
                      fontFamily: "OpenSans_SemiBold"
                  ),),

                SizedBox(height: height*0.025,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isShareYesSelected = true;
                            isShareNoSelected = false;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: height * 0.015, horizontal: height * 0.025),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            border: Border.all(color: isShareYesSelected ? primaryColor : Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: isShareYesSelected ? primaryColor.withOpacity(0.25) : Colors.black.withOpacity(0.25),
                                offset: Offset(0, 0),
                                blurRadius: 1,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Text(
                            "Yes",
                            style: TextStyle(
                              fontSize: height * 0.018,
                              fontFamily: "OpenSans_SemiBold",
                              color: isShareYesSelected ? primaryColor : black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: height * 0.025),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isShareYesSelected = false;
                            isShareNoSelected = true;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: height * 0.015, horizontal: height * 0.025),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            border: Border.all(color: isShareNoSelected ? primaryColor : Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: isShareNoSelected ? primaryColor.withOpacity(0.25) : Colors.black.withOpacity(0.25),
                                offset: Offset(0, 0),
                                blurRadius: 1,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Text(
                            "No",
                            style: TextStyle(
                              fontSize: height * 0.018,
                              fontFamily: "OpenSans_SemiBold",
                              color: isShareNoSelected ? primaryColor : black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height*0.015,),

                Text("We only provide the location of your space once a driver has a confirmed booking.",
                  style: TextStyle(
                      color: black.withOpacity(0.6),
                      fontSize: height * 0.015,
                  ),),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
