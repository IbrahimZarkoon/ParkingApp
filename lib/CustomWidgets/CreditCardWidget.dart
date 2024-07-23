import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Constants/Colors.dart';

class CreditCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String bankName;
  final Color cardColor;
  final String logoPath;

  CreditCardWidget({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.bankName,
    required this.cardColor,
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: height*0.025,right: height*0.025,bottom: height*0.025),
      margin: EdgeInsets.symmetric(vertical: height*0.005),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/SS_1.png"),fit: BoxFit.contain,alignment: Alignment.bottomLeft,repeat: ImageRepeat.repeatY
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            blurRadius: 1.5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Flexible(
                child: Text(
                  bankName,
                  style:  TextStyle(
                    color: Colors.white,
                    fontSize: height*0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Image.asset(
                logoPath,
                height: height*0.07,
                width: height*0.07,
              ),


            ],
          ),

          SizedBox(height: height*0.05,),

          Padding(
            padding: EdgeInsets.only(left: height*0.075),
            child: Text(
              cardNumber,
              style:  TextStyle(
                color: Colors.white,
                fontSize: height*0.022,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),

          Spacer(),

          SizedBox(height: height*0.015),

          Padding(
            padding: EdgeInsets.only(right: height*0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Holder',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: height*0.016,
                      ),
                    ),
                    Text(
                      cardHolderName,
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: height*0.016,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiry Date',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: height*0.015,
                      ),
                    ),
                    Text(
                      expiryDate,
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: height*0.016,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}