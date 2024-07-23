import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';

class AddPaymentMethodTab extends StatefulWidget {
  const AddPaymentMethodTab({super.key});

  @override
  State<AddPaymentMethodTab> createState() => _AddPaymentMethodTabState();
}

class _AddPaymentMethodTabState extends State<AddPaymentMethodTab> {
  TextEditingController cardHolderCon = TextEditingController();
  TextEditingController cardNumberCon = TextEditingController();
  TextEditingController cardExpiryCon = TextEditingController();
  TextEditingController cardCVVCon = TextEditingController();
  TextEditingController ZipCodeCon = TextEditingController();



  bool smallVeh = false;
  bool mediumVeh = false;
  bool largeVeh = false;
  bool miniBusVeh = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cardHolderCon.dispose();
    cardNumberCon.dispose();
    cardExpiryCon.dispose();
    cardCVVCon.dispose();
    ZipCodeCon.dispose();
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
        title: Text("Payments",
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

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Icon(Icons.lock,size: height*0.025,color: black,),

                SizedBox(width: height*0.015,),

                Flexible(
                  child: Text("All Payments are Secure and Encrypted",
                    style: TextStyle(
                        color: black,
                        fontSize: height * 0.02,
                        fontFamily: "OpenSans"
                    ),),
                ),
              ],
            ),

            SizedBox(height: height*0.025,),

            Text(
              "By adding your preferred method of payment below you will be able to make bookings more easily via the Trinqoo app.",
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontFamily: "OpenSans",
                fontSize: height * 0.017,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: height * 0.025),

            Text(
              "Cardholder Name",
              style: TextStyle(
                color: black,
                fontFamily: "OpenSans_SemiBold",
                fontWeight: FontWeight.bold,
                fontSize: height * 0.017,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: height * 0.005),
            customTextField(hintText: "Enter Cardholder Name", controller: cardHolderCon),

            SizedBox(height: height * 0.025),

            Text(
              "Card Number",
              style: TextStyle(
                color: black,
                fontFamily: "OpenSans_SemiBold",
                fontWeight: FontWeight.bold,
                fontSize: height * 0.017,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: height * 0.005),
            customTextField(hintText: "4111 1111 1111 1111", controller: cardNumberCon,suffixIcon: Icons.credit_card),

            SizedBox(height: height * 0.025),

            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Expiry",
                        style: TextStyle(
                          color: black,
                          fontFamily: "OpenSans_SemiBold",
                          fontWeight: FontWeight.bold,
                          fontSize: height * 0.017,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: height * 0.005),
                      customTextField(hintText: "10/2026", controller: cardExpiryCon),
                    ],
                  ),
                ),

                SizedBox(width: height*0.025,),

                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "CVV",
                        style: TextStyle(
                          color: black,
                          fontFamily: "OpenSans_SemiBold",
                          fontWeight: FontWeight.bold,
                          fontSize: height * 0.017,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: height * 0.005),
                      customTextField(hintText: "123", controller: cardCVVCon),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.025),

            Text(
              "Billing Zip Code",
              style: TextStyle(
                color: black,
                fontFamily: "OpenSans_SemiBold",
                fontWeight: FontWeight.bold,
                fontSize: height * 0.017,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: height * 0.005),
            customTextField(hintText: "Enter Billing Address Zip Code", controller: ZipCodeCon),


            InkWell(
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
                  "Verify Payment Details & Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.019,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
            fontWeight: FontWeight.normal,
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

}
