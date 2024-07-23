import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';

class AddVehicleTab extends StatefulWidget {
  const AddVehicleTab({super.key});

  @override
  State<AddVehicleTab> createState() => _AddVehicleTabState();
}

class _AddVehicleTabState extends State<AddVehicleTab> {

  TextEditingController plateCon = TextEditingController();

  bool smallVeh = false;
  bool mediumVeh = false;
  bool largeVeh = false;
  bool miniBusVeh = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    plateCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new,color: white,size: height*0.025,)),
        leadingWidth: 40,
        centerTitle: true,
        title: Text("Vehicles",
          style: TextStyle(
              color: Colors.white,
              fontSize: height * 0.025,
              fontFamily: "OpenSans_SemiBold"
          ),),

      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.025),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Text(
              "You do not currently have any vehicles registered with Trinqoo. Input your number plate below to add your first vehicle.",
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontFamily: "OpenSans",
                fontSize: height * 0.017,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: height * 0.025),

            Text(
              "Add a New Vehicle",
              style: TextStyle(
                color: black,
                fontFamily: "OpenSans_SemiBold",
                fontWeight: FontWeight.bold,
                fontSize: height * 0.017,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: height * 0.005),
            customTextField(hintText: "XYZ-123", controller: plateCon),

            SizedBox(height: height * 0.025),

            plateCon.text != ''? whatSizeColumn() : SizedBox(),

            plateCon.text != ''?  InkWell(
              onTap: () async {
              },
              child: Container(
                width: width,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: height*0.025),
                padding: EdgeInsets.symmetric(horizontal: height * 0.025, vertical: height * 0.015),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(0, 0),
                      blurRadius: 1,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.019,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget customTextField({required String hintText, required TextEditingController controller, bool isPassword = false, TextInputType keyboardType = TextInputType.text, IconData? suffixIcon, Function? onTapSuffixIcon}) {
    double height = MediaQuery.of(context).size.height;
    return Container(
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
        controller: controller,
        style: TextStyle(
          color: Colors.black,
          fontSize: height * 0.019,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (String value)
        {
          setState(() {
            controller.text = value;
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: height * 0.02,
            vertical: height * 0.015,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: height * 0.018,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),

          ),
          enabledBorder: InputBorder.none,
          suffixIcon: suffixIcon != null
              ? IconButton(
            icon: Icon(suffixIcon, color: black),
            onPressed: () {
              if (onTapSuffixIcon != null) {
                onTapSuffixIcon();
              }
            },
          )
              : null,
        ),
        keyboardType: keyboardType,
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
}
