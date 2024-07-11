import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';

class ZipCodeTab extends StatefulWidget {
  const ZipCodeTab({super.key});

  @override
  State<ZipCodeTab> createState() => _ZipCodeTabState();
}

class _ZipCodeTabState extends State<ZipCodeTab> {
  final TextEditingController _zipCodeCon = TextEditingController();

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.02),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text("Tell us a little about your space",
            style: TextStyle(
              color: black,
              fontSize: height * 0.0325,
              fontWeight: FontWeight.bold,
            ),),


            Center(child: Image.network(
              'https://img.freepik.com/free-vector/townhouse-buildings-isometric-composition-with-modern-city-block-scenery-with-group-houses-location-sign_1284-31618.jpg?t=st=1720697360~exp=1720700960~hmac=636a64b2d6fe946421c3f7e65166955ae7a32111d85d124d2305689c20424475&w=1800',
               width: width/1.25,)),

            SizedBox(height: height*0.025,),

            Text("What is your postcode?",
              style: TextStyle(
                color: black,
                fontSize: height * 0.025,
                fontFamily: "OpenSans_SemiBold"
              ),),

            Container(
              margin: EdgeInsets.only(top: height*0.025),
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
                controller: _zipCodeCon,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.019,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: height * 0.015,
                    vertical: height * 0.015,
                  ),
                  hintText: 'Enter your postcode',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.streetAddress,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
