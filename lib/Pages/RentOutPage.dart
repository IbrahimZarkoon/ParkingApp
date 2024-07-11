import 'package:airportparking/Pages/RentOutSpaceForm/RentOutSpacePage.dart';
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../Constants/Colors.dart';

class RentOutPage extends StatefulWidget {
  const RentOutPage({super.key});

  @override
  State<RentOutPage> createState() => _RentOutPageState();
}

class _RentOutPageState extends State<RentOutPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: height*0.015,horizontal: height*0.015),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            //Earn Container
            earnCon(context),

            imgCon(context),

            SizedBox(height: height*0.035,),

            stepCon(context),
            SizedBox(height: height*0.015,),

            detailsCon(context),

          ],
        ),
      ),
    );
  }

  Widget earnCon(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: height * 0.025, vertical: height * 0.025),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor.withOpacity(0.15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "See how much spaces in your area can earn!",

            textAlign: TextAlign.center,
            style: TextStyle(
              color: black,
              fontSize: height * 0.0325,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.025),

          //Name Con
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: black.withOpacity(0.25),
                      offset: Offset(0,0),
                      blurRadius: 1,
                      spreadRadius: 0
                  )
                ]
            ),
            child: TextField(
              style: TextStyle(
                color: black,
                fontSize: height * 0.019,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: height*0.015,vertical: height*0.015),
                hintText: 'Name',
                hintStyle: TextStyle(
                  color: black.withOpacity(0.5),
                  fontSize: height * 0.018,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                enabledBorder: InputBorder.none
              ),
            ),
          ),
          SizedBox(height: height * 0.025),

          //PostCode Con
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.25),
                  offset: Offset(0,0),
                  blurRadius: 1,
                  spreadRadius: 0
                )
              ]
            ),
            child: TextField(

              style: TextStyle(
                color: black,
                fontSize: height * 0.019,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: height*0.015,vertical: height*0.015),
                hintText: 'Postcode',
                hintStyle: TextStyle(
                  color: black.withOpacity(0.5),
                  fontSize: height * 0.018,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),

                ),
                  enabledBorder: InputBorder.none

              ),
            ),
          ),
          SizedBox(height: height * 0.025),

          //Email Con
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: black.withOpacity(0.25),
                      offset: Offset(0,0),
                      blurRadius: 1,
                      spreadRadius: 0
                  )
                ]
            ),
            child: TextField(
              style: TextStyle(
                color: black,
                fontSize: height * 0.019,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: 'Email address',
                contentPadding: EdgeInsets.symmetric(horizontal: height*0.015,vertical: height*0.015),
                hintStyle: TextStyle(
                  color: black.withOpacity(0.5),
                  fontSize: height * 0.018,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                  enabledBorder: InputBorder.none

              ),
            ),
          ),
          SizedBox(height: height * 0.025),

          //Get a quote Con
          Container(
            width: width,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.015),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: black.withOpacity(0.25),
                      offset: Offset(0,0),
                      blurRadius: 1,
                      spreadRadius: 0
                  )
                ]
            ),
            child: Text("Get a quote",
            style: TextStyle(
              color: white,
              fontSize: height * 0.019,
              fontWeight: FontWeight.bold,
            ),),
          ),
          SizedBox(height: height * 0.025),

          //Rent out your space Con
          InkWell(
            onTap: ()
            {
              Navigator.push(context, CupertinoPageRoute(builder: (_) => RentOutSpacePage()));
            },
            child: Container(
              width: width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.015),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: white,
                  border: Border.all(color: primaryColor,width: 1),
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: primaryColor.withOpacity(0.25),
                  //       offset: Offset(0,0),
                  //       blurRadius: 1,
                  //       spreadRadius: 0
                  //   )
                  // ]
              ),
              child: Text("Rent out your space now",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: height * 0.019,
                  fontWeight: FontWeight.bold,
                ),),
            ),
          ),
        ],
      ),
    );
  }

  Widget stepCon(BuildContext context)
  {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    List<StepperData> stepperData = [

      StepperData(
          title: StepperText(
            "\$4,000 per year",
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height * 0.03,
              color: black,
            ),
          ),
          subtitle: StepperText("being earned by our top hosts each year.",textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: height * 0.018,
            color: black.withOpacity(0.6),
          ),),
        iconWidget: Container(
          width: height*0.025,
          height: height*0.025,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(100),
          ),
        )
      ),
      StepperData(
          title: StepperText("13 million+",textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: height * 0.03,
            color: black,
          ),),

          subtitle: StepperText("drivers trust us to find them parking.",textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: height * 0.018,
            color: black.withOpacity(0.6),
          ),),
          iconWidget: Container(
            width: height*0.025,
            height: height*0.025,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
          )

      ),
      StepperData(
          title: StepperText("\$50 million+",textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: height * 0.03,
            color: black,
          ),),
          subtitle: StepperText(
              "earned by our hosts since we began our journey.",textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: height * 0.018,
            color: black.withOpacity(0.6),
          ),),
          iconWidget: Container(
            width: height*0.025,
            height: height*0.025,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
          )

          ),
      StepperData(
        title: StepperText("45,000+",textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: height * 0.03,
          color: black,
        ),),
        subtitle: StepperText(
            "hosts already earning from their driveway.",textStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: height * 0.018,
          color: black.withOpacity(0.6),
        ),),
          iconWidget:Container(
            width: height*0.025,
            height: height*0.025,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
          )
      ),

    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: 0),
      child: AnotherStepper(
        barThickness: 1,
        verticalGap: height*0.06,
        stepperList: stepperData,
        stepperDirection: Axis.vertical,
        iconWidth: height*0.025,
        iconHeight: height*0.025,
        activeBarColor: primaryColor,
        inActiveBarColor: primaryColor,

      ),
    );
  }

  Widget imgCon(BuildContext context)
  {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.only(top: height*0.025),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          Text("Being a trinqoo host",
          style: TextStyle(
            color: black,
            fontSize: height * 0.0325,
            fontWeight: FontWeight.bold,
          ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text("Turn your driveway into a simple, passive source of income.",
            style: TextStyle(
              color: black.withOpacity(0.6),
              fontSize: height * 0.03,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          Container(
            margin: EdgeInsets.only(top: height*0.025),
            height: height*0.275,
            width: height*0.275,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              image: DecorationImage(
                image: NetworkImage("https://img.freepik.com/free-photo/person-taking-care-electric-car_23-2149362798.jpg?t=st=1720618600~exp=1720622200~hmac=b2a72bef0882b1a24c99a7c107055684de9dd9fb363e62ef7d7dadf9dbafaab7&w=2000"),
                fit: BoxFit.cover
              )
            ),
          )

        ],

      ),
    );
  }

  Widget detailsCon(BuildContext context)
  {

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: height*0.025),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          Text("Why rent out your space with Trinqoo?",
            style: TextStyle(
              color: black,
              fontSize: height * 0.0325,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: height*0.035,),

          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: height*0.025),
                height: height*0.275,
                width: height*0.275,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    image: DecorationImage(
                        image: NetworkImage("https://img.freepik.com/free-photo/front-view-house-with-garden-money-bank-notes_23-2148301724.jpg?t=st=1720616629~exp=1720620229~hmac=560022f1ae0f68d7dbbad0afe707ef43f0b7c47b744b1d2d51fca876e00eca41&w=2000"
                            ""),
                        fit: BoxFit.cover
                    )
                ),
              ),

              SizedBox(height: height*0.015,),

              Text("Earn with us",
                style: TextStyle(
                  color: black,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: height*0.015,),

              Text("Our top hosts make over \$4,000 a year renting their driveways. Why not find out what yours could make you today? The first \$1,000 is completely tax-free.",
                style: TextStyle(
                  color: black.withOpacity(0.6),
                  fontSize: height * 0.018,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          SizedBox(height: height*0.035,),

          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: height*0.025),
                height: height*0.275,
                width: height*0.275,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    image: DecorationImage(
                        image: NetworkImage("https://img.freepik.com/free-photo/caucasian-man-holding-smart-phone-remote-generated-by-ai_188544-16955.jpg?t=st=1720617720~exp=1720621320~hmac=21d60117b93d3860b2ea9e28a318ec4c01a6c6c20076cee27ba86542ff65bd88&w=2000"),
                        fit: BoxFit.cover
                    )
                ),
              ),

              SizedBox(height: height*0.015,),

              Text("You're in control",
                style: TextStyle(
                  color: black,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: height*0.015,),

              Text("Simply choose the days & hours that suit you and set your own price. Then just sit back and watch the bookings roll in, Easy.",
                style: TextStyle(
                  color: black.withOpacity(0.6),
                  fontSize: height * 0.018,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          SizedBox(height: height*0.035,),

          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: height*0.025),
                height: height*0.275,
                width: height*0.275,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    image: DecorationImage(
                        image: NetworkImage("https://img.freepik.com/free-photo/empty-underground-parking-bay_60438-3915.jpg?t=st=1720617770~exp=1720621370~hmac=77f11c2bc557bcce6b000698c123c24ca89a254420b36df79296bc81c9e12a69&w=2000"),
                        fit: BoxFit.cover
                    )
                ),
              ),

              SizedBox(height: height*0.015,),

              Text("More than 13 million drivers",
                style: TextStyle(
                  color: black,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: height*0.015,),

              Text("Our growing community of verified drivers is the largest in the USA, meaning more bookings for you and more cash in your pocket.",
                style: TextStyle(
                  color: black.withOpacity(0.6),
                  fontSize: height * 0.018,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          SizedBox(height: height*0.035,),


        ],
      ),
    );
  }
}
