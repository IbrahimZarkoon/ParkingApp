import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';

class SpaceTypeTab extends StatefulWidget {
  const SpaceTypeTab({super.key});

  @override
  State<SpaceTypeTab> createState() => _SpaceTypeTabState();
}

class _SpaceTypeTabState extends State<SpaceTypeTab> {
  final TextEditingController _zipCodeCon = TextEditingController();

  int selectedCount = 0;
  String selectedType = '';
  bool isExpanded = false;

  bool smallVeh = false;
  bool mediumVeh = false;
  bool largeVeh = false;
  bool miniBusVeh = false;

  bool isYesSelected = false;
  bool isNoSelected = false;

  @override
  void dispose() {
    super.dispose();
    _zipCodeCon.dispose();
  }

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

            Text("What type of space do you have?",
              style: TextStyle(
                color: black,
                fontSize: height * 0.0325,
                fontWeight: FontWeight.bold,
              ),),

            SizedBox(height: height*0.025,),

            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  selectedType = 'Driveway';
                  isExpanded = true;
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: height * 0.025),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                  border: Border.all(color: selectedType.toLowerCase() == 'driveway'? primaryColor :  Colors.white,),
                  boxShadow: [
                    BoxShadow(
                      color:selectedType.toLowerCase() == 'driveway'? primaryColor.withOpacity(0.25) : Colors.black.withOpacity(0.25),
                      offset: Offset(0, 0),
                      blurRadius: 1,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(height * 0.015),
                  child: Text('Driveway', style: TextStyle(
                    color: selectedType.toLowerCase() == 'driveway'? primaryColor :  black,
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  selectedType = 'Car Park';
                  isExpanded = true;
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: height * 0.025),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                  border: Border.all(color: selectedType.toLowerCase() == 'car park'? primaryColor :  Colors.white,),
                  boxShadow: [
                    BoxShadow(
                      color:selectedType.toLowerCase() == 'car park'? primaryColor.withOpacity(0.25) : Colors.black.withOpacity(0.25),
                      offset: Offset(0, 0),
                      blurRadius: 1,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                width: width,

                child: Padding(
                  padding: EdgeInsets.all(height * 0.015),
                  child: Text('Car Park', style: TextStyle(
                    color: selectedType.toLowerCase() == 'car park'? primaryColor :  black,
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  selectedType = 'Garage';
                  isExpanded = true;
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: height * 0.025),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                  border: Border.all(color: selectedType.toLowerCase() == 'garage'? primaryColor :  Colors.white,),
                  boxShadow: [
                    BoxShadow(
                      color:selectedType.toLowerCase() == 'garage'? primaryColor.withOpacity(0.25) : Colors.black.withOpacity(0.25),
                      offset: Offset(0, 0),
                      blurRadius: 1,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                width: width,
                child: Padding(
                  padding: EdgeInsets.all(height * 0.015),
                  child: Text('Garage', style: TextStyle(
                    color: selectedType.toLowerCase() == 'garage'? primaryColor :  black,
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
            ),

            SizedBox(height: height * 0.025,),

            if(isExpanded) Column(
              children: [
                Text("How many spaces are available to rent out?",
                  style: TextStyle(
                      color: black,
                      fontSize: height * 0.025,
                      fontFamily: "OpenSans_SemiBold"
                  ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedCount > 0) selectedCount--;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(height*0.01),
                        decoration: BoxDecoration(
                            border: Border.all(color: black.withOpacity(0.6),width: 0.5),
                            borderRadius: BorderRadius.circular(500)
                        ),
                        child: Icon(Icons.remove),
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(height*0.01),
                      margin: EdgeInsets.symmetric(horizontal: height*0.025),
                      constraints: BoxConstraints(
                          minWidth: height*0.05
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: black.withOpacity(0.6),width: 0.5),
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child: Text(
                        selectedCount.toString(),
                        style: TextStyle(
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedCount++;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(height*0.01),
                        decoration: BoxDecoration(
                            border: Border.all(color: black.withOpacity(0.6),width: 0.5),
                            borderRadius: BorderRadius.circular(500)
                        ),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: height * 0.025,),

            if(selectedCount == 1) whatSizeColumn(),

            if(selectedCount> 1) Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Are they all the same size?",
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
                            isYesSelected = true;
                            isNoSelected = false;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: height * 0.015, horizontal: height * 0.025),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            border: Border.all(color: isYesSelected ? primaryColor : Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: isYesSelected ? primaryColor.withOpacity(0.25) : Colors.black.withOpacity(0.25),
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
                              color: isYesSelected ? primaryColor : black,
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
                            isYesSelected = false;
                            isNoSelected = true;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: height * 0.015, horizontal: height * 0.025),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            border: Border.all(color: isNoSelected ? primaryColor : Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: isNoSelected ? primaryColor.withOpacity(0.25) : Colors.black.withOpacity(0.25),
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
                              color: isNoSelected ? primaryColor : black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height*0.025,),

                if(isYesSelected) whatSizeColumn(),

                if(isNoSelected) NoSameSizeColumn()

              ],
            )

          ],
        ),
      ),
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

  Widget whatSizeColumn()
  {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Text("What size vehicle can your space accommodate?",
          style: TextStyle(
              color: black,
              fontSize: height * 0.025,
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
                mediumVeh = false;
                largeVeh = false;
                miniBusVeh = false;
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
                smallVeh = false;
                largeVeh = false;
                miniBusVeh = false;
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
                mediumVeh = false;
                smallVeh = false;
                miniBusVeh = false;
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
                mediumVeh = false;
                largeVeh = false;
                smallVeh = false;
              });
            }
        )

      ],
    );
  }

  Widget NoSameSizeColumn()
  {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Text("What size vehicle can your space accommodate?",
          style: TextStyle(
              color: black,
              fontSize: height * 0.025,
              fontFamily: "OpenSans_SemiBold"
          ),),

        SizedBox(height: height*0.015,),

        Text("You indicated that the space sizes are not the same. Please select a vehicle size that will fit into both spaces.",
          style: TextStyle(
              color: black.withOpacity(0.6),
              fontSize: height * 0.016,
              fontFamily: "OpenSans"
          ),),

        vehicleSizeCon(
            "Small",
            "i.e. VW Polo, Ford Fiesta",
            "assets/images/Blue_Hatchback.png",
            isTap: smallVeh,
            onTap: () {
              setState(() {
                smallVeh = !smallVeh;
                mediumVeh = false;
                largeVeh = false;
                miniBusVeh = false;
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
                smallVeh = false;
                largeVeh = false;
                miniBusVeh = false;
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
                mediumVeh = false;
                smallVeh = false;
                miniBusVeh = false;
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
                mediumVeh = false;
                largeVeh = false;
                smallVeh = false;
              });
            }
        )

      ],
    );
  }
}
