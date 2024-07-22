import 'package:airportparking/CustomWidgets/CustomSnackBar.dart';
import 'package:airportparking/Providers/UserProvider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Constants/Icons.dart';

const String customPlateSVG = '''
<svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1761.55 779.81">
  <defs>
    <style>
      .cls-1 { fill: #ddddd3; }
      .cls-2 { fill: #eaa122; }
      .cls-3 { fill: #231f20; font-family: Arial-BoldMT, Arial; font-size: 132px; font-weight: 700; }
      .cls-4 { fill: #010101; }
    </style>
  </defs>
  <g>
    <rect class="cls-1" width="1761.55" height="779.81" rx="140.51" ry="140.51"/>
    <rect class="cls-2" x="61.96" y="61.96" width="1637.63" height="655.89" rx="78.32" ry="78.32"/>
    <path class="cls-2" d="M1621.04,46.47c51.85,0,94.04,42.19,94.04,94.04v498.79c0,51.85-42.19,94.04-94.04,94.04H140.51c-51.85,0-94.04-42.19-94.04-94.04V140.51c0-51.85,42.19-94.04,94.04-94.04H1621.04Zm0-23.24H140.51c-64.67,0-117.28,52.61-117.28,117.28v498.79c0,64.67,52.61,117.28,117.28,117.28H1621.04c64.67,0,117.28-52.61,117.28-117.28V140.51c0-64.67-52.61-117.28-117.28-117.28h0Z"/>
    <path class="cls-4" d="M949.84,109.38l-4.82-.2-4.35-4.35c1.15-1.45,1.07-3.55-.27-4.89-1.34-1.34-3.44-1.42-4.89-.27l-13.28-13.28,5.74,20.76-47.2,47.47-47.2-47.47,5.74-20.76-13.28,13.28c-1.45-1.15-3.55-1.07-4.89,.27-1.34,1.34-1.42,3.44-.27,4.89l-4.35,4.35-4.82,.2-22.68,22.68s15.66,29.51,38.14,26.1c0,0-2.13-21.35,3.86-43.11l44.55,44.81-51.4,51.7c-1.44,1.44-1.44,3.78,0,5.22,1.44,1.44,3.78,1.44,5.22,0l51.38-51.68,51.38,51.68c1.44,1.44,3.78,1.44,5.22,0,1.44-1.44,1.44-3.78,0-5.22l-51.4-51.7,44.55-44.81c5.98,21.76,3.86,43.11,3.86,43.11,22.48,3.41,38.14-26.1,38.14-26.1l-22.68-22.68Z"/>
    <rect class="cls-4" x="61.96" y="193.29" width="737.3" height="24.57"/>
    <rect class="cls-4" x="962.29" y="193.29" width="737.3" height="24.57"/>
    <path class="cls-4" d="M61.96,634.48v4.82c0,43.38,35.17,78.55,78.55,78.55H1621.04c43.38,0,78.55-35.17,78.55-78.55v-4.82H61.96Z"/>
    <g>
      <polygon class="cls-2" points="710.5 653.51 716.64 665.95 730.36 667.95 720.43 677.63 722.77 691.3 710.5 684.85 698.22 691.3 700.56 677.63 690.63 667.95 704.36 665.95 710.5 653.51"/>
      <polygon class="cls-2" points="1058.53 653.51 1064.67 665.95 1078.4 667.95 1068.47 677.63 1070.81 691.3 1058.53 684.85 1046.26 691.3 1048.6 677.63 1038.67 667.95 1052.4 665.95 1058.53 653.51"/>
    </g>
  </g>
  <text class="cls-3" transform="translate(187.91 462.93)"><tspan x="0" y="0">{{NUMBER_PLATE}}</tspan></text>
</svg>
''';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
  }

  String svgContent = '';

  @override
  void initState() {
    super.initState();
    loadSvg();
  }

  void loadSvg() {
    setState(() {
      svgContent = customPlateSVG.replaceAll('{{NUMBER_PLATE}}', "XYZ-3344");
    });
  }
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var userProv = Provider.of<UserProvider>(context,listen:false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Image.asset("assets/logos/Logo_White.png")),
        leadingWidth: 100,
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        children: [

          //Profile img, Name, Edit Profile Con
          //profileImgNameCon(),

          accountInfoCon(),
          
          shadowLine(),

          //Vehicles Container
          vehiclesCon(),

          shadowLine(),

          paymentsCon(),

          shadowLine(),

          Container(
            width: width,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: height*0.025,left: height*0.025,right: height*0.025),
            padding: EdgeInsets.symmetric(horizontal: height * 0.025, vertical: height * 0.015),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: primaryColor,
              border: Border.all(color: primaryColor,width: 1),

            ),
            child: Text(
              "Log out",
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.019,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(
            width: width,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: height*0.025,right: height*0.025,left: height*0.025),
            padding: EdgeInsets.symmetric(horizontal: height * 0.025, vertical: height * 0.015),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              border: Border.all(color: Colors.red,width: 1),
            ),
            child: Text(
              "Delete my account",
              style: TextStyle(
                color: Colors.red,
                fontSize: height * 0.019,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Member Since Container
          Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * 0.015),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Member Since January 2024",
                  style: TextStyle(
                    color: black.withOpacity(0.6),
                    fontFamily: "OpenSans_SemiBold",
                    fontSize: MediaQuery.sizeOf(context).height * 0.014,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget accountInfoCon()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Account Information",
            style: TextStyle(
                color: black,
                fontSize: height * 0.025,
                fontWeight: FontWeight.w600,
                fontFamily: "OpenSans_SemiBold"
            ),),

          Text("You can edit your Trinqoo profile information below.",
            style: TextStyle(
              color: black,
              fontSize: height * 0.016,
            ),),

          SizedBox(height: height*0.025,),

          customTextField(
            hintText: 'First Name',
            controller: _firstNameController,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: height*0.025,),

          customTextField(
            hintText: 'Last Name',
            controller: _lastNameController,
            keyboardType: TextInputType.name,
          ),

          SizedBox(height: height*0.025,),

          customTextField(
            hintText: 'Phone Number',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: height * 0.005),
          Row(
            children: [

              Icon(CupertinoIcons.xmark_circle,color: Colors.red,size: height*0.015,),
              SizedBox(width: height * 0.005),

              Text(
                "Phone not verified.",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontFamily: "OpenSans_SemiBold",
                  fontSize: height * 0.013,
                ),
                textAlign: TextAlign.start,
              ),

              SizedBox(width: height * 0.005),


              InkWell(
                onTap: ()
                {
                  CustomSnackBar.show(context, "Verication code sent successfully.");
                },
                child: Text(
                  "Resend the verification SMS.",
                  style: TextStyle(
                    color: primaryColor,
                    fontFamily: "OpenSans_SemiBold",
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.014,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),

          SizedBox(height: height*0.015,),

          Container(
            width: width,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: height*0.025),
            padding: EdgeInsets.symmetric(horizontal: height * 0.025, vertical: height * 0.015),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              border: Border.all(color: primaryColor,width: 1),

            ),
            child: Text(
              "Reset Password",
              style: TextStyle(
                color: primaryColor,
                fontSize: height * 0.019,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: height * 0.005),
          Text(
            "Clicking on the reset password button will send a reset link to your email.",
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontFamily: "OpenSans_SemiBold",
              fontSize: height * 0.013,
            ),
            textAlign: TextAlign.start,
          ),

          SizedBox(height: height * 0.015),

          //Vehicle Container
        ],
      ),
    );
  }

  Widget vehiclesCon()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Vehicles",
            style: TextStyle(
                color: black,
                fontSize: height * 0.025,
                fontWeight: FontWeight.w600,
                fontFamily: "OpenSans_SemiBold"
            ),),

          Text("You have no vehicles added. Click below to add your first vehicle.",
            style: TextStyle(
              color: black,
              fontSize: height * 0.016,
            ),),

          SizedBox(height: height*0.025,),

          addContainer("CLICK TO ADD A VEHICLE"),
          //Vehicle Container
          // Container(
          //   width: width,
          //   height: height*0.25,
          //   child: Stack(
          //     children: [
          //       // Car image
          //       Positioned.fill(
          //         child: Image.asset(
          //           "assets/images/Blue_Sedan.png",
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //       // Number plate
          //       Positioned(
          //         top: 10,
          //         left: 10,
          //         child: svgContent.isEmpty
          //             ? CircularProgressIndicator()
          //             : SvgPicture.string(
          //           svgNumberPlate,
          //           width: 200,
          //           height: 50,
          //           fit: BoxFit.contain,
          //           semanticsLabel: 'Number Plate',
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget paymentsCon()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Payment methods",
            style: TextStyle(
                color: black,
                fontSize: height * 0.025,
                fontWeight: FontWeight.w600,
                fontFamily: "OpenSans_SemiBold"
            ),),

          Text("You have no payment methods added. Click below to add your first payment method.",
            style: TextStyle(
              color: black,
              fontSize: height * 0.016,
            ),),

          SizedBox(height: height*0.025,),

          addContainer("CLICK TO ADD A PAYMENT METHOD"),

        ],
      ),
    );
  }

  Widget spacesCon()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: height*0.025,vertical: height*0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Payment methods",
            style: TextStyle(
                color: black,
                fontSize: height * 0.025,
                fontWeight: FontWeight.w600,
                fontFamily: "OpenSans_SemiBold"
            ),),

          Text("You have no payment methods added. Click below to add your first payment method.",
            style: TextStyle(
              color: black,
              fontSize: height * 0.016,
            ),),

          SizedBox(height: height*0.025,),

          addContainer("CLICK TO ADD A PAYMENT METHOD"),

        ],
      ),
    );
  }

  Widget shadowLine()
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height*0.02,
      color: black.withOpacity(0.05),
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

  Widget addContainer(String title)
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DottedBorder(
      color: black.withOpacity(0.4),
      strokeWidth: 1,
      borderType: BorderType.RRect,
      radius: Radius.circular(5),
      dashPattern: [3, 3],
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: height * 0.025, horizontal: height * 0.01),
        decoration: BoxDecoration(
          color: black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: height * 0.025,
              color: black.withOpacity(0.4),
            ),
            SizedBox(width: height * 0.01),
            Text(
              title,
              style: TextStyle(
                color: black.withOpacity(0.4),
                fontWeight: FontWeight.bold,
                fontSize: height * 0.02,
                fontFamily: "OpenSans_SemiBold",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileCon(String title, {IconData? icon,IconData? functionIcon, Function()? onTapFunction})
  {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height*0.02,horizontal: MediaQuery.sizeOf(context).height*0.025),
        margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height*0.0025),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Icon(icon,
              color: black.withOpacity(0.7),size: MediaQuery.sizeOf(context).height*0.03,),

            SizedBox(width: MediaQuery.sizeOf(context).height*0.025,),

            Text(
              title,
              style: TextStyle(
                color: black,
                fontFamily: "OpenSans_SemiBold",
                fontSize: MediaQuery.sizeOf(context).height * 0.017,
              ),
            ),

            const Spacer(),

            Icon(functionIcon,
              color: black.withOpacity(0.7),size: MediaQuery.sizeOf(context).height*0.025,),
          ],
        ),
      ),
    );
  }
}
