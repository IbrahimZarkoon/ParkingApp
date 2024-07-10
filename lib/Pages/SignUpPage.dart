import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isObscured = true;
  bool _isExpanded = false;

  bool _emailSubscription = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  bool circularProg = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _zipCodeController.dispose();
  }

  String error = '';

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Center(child: Image.asset('assets/logos/Logo_White.png',color: primaryColor,width: width/2,),),
                  // Replace with your logo asset path
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Center(
                    child: Text(
                      'BECOME A MEMBER',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: black,
                          fontSize: MediaQuery.sizeOf(context).height * 0.03,
                          fontFamily: "OpenSans_SemiBold",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                  Center(
                    child: Text(
                      'Become a Member - you\'ll enjoy exclusive deals, offers, invites and rewards.',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: black,
                          fontSize: MediaQuery.sizeOf(context).height * 0.016,
                          fontFamily: "OpenSans_SemiBold"),
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.06),

                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email *',
                      labelStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                        fontFamily: "OpenSans",
                        color: black,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height * 0.015,
                          vertical: MediaQuery.of(context).size.height * 0.015),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Create a password *',
                      labelStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                        fontFamily: "OpenSans",
                        color: black,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height * 0.015,
                          vertical: MediaQuery.of(context).size.height * 0.015),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _isObscured ? Icons.visibility : Icons.visibility_off,
                            color: _isObscured
                                ? Colors.black.withOpacity(0.8)
                                : primaryColor),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    obscureText: _isObscured,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),

                  Text(
                    "Minimum 8 characters",
                    style: TextStyle(
                        color: black.withOpacity(0.6),
                        fontFamily: "OpenSans",
                        fontSize: MediaQuery.sizeOf(context).height * 0.013),
                    textAlign: TextAlign.start,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),


                  TextFormField(
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.018,
                      fontFamily: "OpenSans",
                      color: black,
                    ),

                    controller: _dobController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Date of Birth *',
                      suffixIcon: const Icon(Icons.calendar_today),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height * 0.015,
                          vertical: MediaQuery.of(context).size.height * 0.015),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode()); // to prevent opening default keyboard
                      _selectDate(context, _dobController);
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),

                  Text(
                    "LakesAmerica wants to give you a special treat on your birthday",
                    style: TextStyle(
                        color: black.withOpacity(0.6),
                        fontFamily: "OpenSans",
                        fontSize: MediaQuery.sizeOf(context).height * 0.013),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone *',
                      labelStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                        fontFamily: "OpenSans",
                        color: black,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height * 0.015,
                          vertical: MediaQuery.of(context).size.height * 0.015),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  //Add More Container
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: black.withOpacity(0.2))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ExpansionPanelList(
                        elevation: 0,
                        animationDuration: const Duration(milliseconds: 500),
                        expandedHeaderPadding: EdgeInsets.zero,
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        expandIconColor: secondaryColor,
                        children: [
                          ExpansionPanel(
                            backgroundColor: white,
                            headerBuilder: (BuildContext context, bool isExpanded) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                child: ListTile(
                                  iconColor: secondaryColor,
                                  title: Text(
                                    'Add more',
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height *
                                          0.018,
                                      fontFamily: "OpenSans_SemiBold",
                                      fontWeight: FontWeight.bold,
                                      color: secondaryColor,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                            },
                            body: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                  MediaQuery.of(context).size.height * 0.025),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.03),
                                  TextField(
                                    controller: _firstNameController,
                                    decoration: InputDecoration(
                                      labelText: 'First Name',
                                      labelStyle: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                        fontFamily: "OpenSans",
                                        color: black.withOpacity(0.7),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                        vertical:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.03),
                                  TextField(
                                    controller: _lastNameController,
                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                      labelStyle: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                        fontFamily: "OpenSans",
                                        color: black.withOpacity(0.7),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                        vertical:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.03),
                                  TextField(
                                    controller: _genderController,
                                    decoration: InputDecoration(
                                      labelText: 'Gender',
                                      labelStyle: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                        fontFamily: "OpenSans",
                                        color: black.withOpacity(0.7),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                        vertical:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.03),
                                  TextField(
                                    controller: _zipCodeController,
                                    decoration: InputDecoration(
                                      labelText: 'Zip Code',
                                      labelStyle: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                        fontFamily: "OpenSans",
                                        color: black.withOpacity(0.7),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                        vertical:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: black.withOpacity(0.4),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.005),
                                  Text(
                                    "Enter your zip code. E.g. 10710",
                                    style: TextStyle(
                                        color: secondaryColor,
                                        fontFamily: "OpenSans",
                                        fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.013),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.03),
                                ],
                              ),
                            ),
                            isExpanded: _isExpanded,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _emailSubscription = !_emailSubscription;
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: primaryColor,
                          value: _emailSubscription,
                          onChanged: (bool? value) {
                            setState(() {
                              _emailSubscription = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            "Yes, email me my member rewards, special invites, trend alerts and more.",
                            style: TextStyle(
                                color: black,
                                fontFamily: "OpenSans_SemiBold",
                                fontSize:
                                MediaQuery.sizeOf(context).height * 0.0145),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),

                  Text(
                    "Your inbox is about to get a lot more stylish! Get excited for exclusive deals, trend, alerts, first access to our new collections, and more. Plus, don't miss out on all your Member rewards, birthday offer and special invites to events!",
                    style: TextStyle(
                        color: black,
                        fontFamily: "OpenSans_SemiBold",
                        fontSize: MediaQuery.sizeOf(context).height * 0.0145),
                    textAlign: TextAlign.start,
                  ),

                  //Sign Up
                  InkWell(
                    onTap: () async{

                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.015),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height * 0.02,
                          vertical: MediaQuery.of(context).size.height * 0.0125),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: black, width: 1),
                          color: black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: const Offset(0, 0),
                              blurRadius: 1.5,
                            )
                          ]),
                      child: Text(
                        "Become a member",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.018,
                            fontFamily: "OpenSans_SemiBold",
                            color: Colors.white),
                      ),
                    ),
                  ),

                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black), // Default text style
                      children: <TextSpan>[
                        TextSpan(
                          text:
                          'By clicking \'Become a member\', I agree to the Lakes America Membership ',
                          style: TextStyle(
                              color: black.withOpacity(0.6),
                              fontSize: MediaQuery.sizeOf(context).height * 0.0135,
                              fontFamily: "OpenSans_SemiBold"),
                        ),
                        TextSpan(
                          text: 'Terms and conditions.\n',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: black.withOpacity(0.6),
                              fontSize: MediaQuery.sizeOf(context).height * 0.0135,
                              fontFamily: "OpenSans_SemiBold"),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle the tap, possibly navigating to a new Widget that explains the policy in detail
                              print('Terms and conditions. tapped');
                            },
                        ),
                        TextSpan(
                          text:
                          'To give you the full membership experience, we will process your personal data in accordance with the Lakes America\'s ',
                          style: TextStyle(
                              color: black.withOpacity(0.6),
                              fontSize: MediaQuery.sizeOf(context).height * 0.0135,
                              fontFamily: "OpenSans_SemiBold"),
                        ),
                        TextSpan(
                          text: 'Privacy Notice.',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: black.withOpacity(0.6),
                              fontSize: MediaQuery.sizeOf(context).height * 0.0135,
                              fontFamily: "OpenSans_SemiBold"),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle the tap, possibly navigating to a new Widget that explains the policy in detail
                              print('Privacy Notice tapped');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
                top: 0,left: 0,right: 0,bottom: 0,
                child: circularProg? Center(child: CircularProgressIndicator(color: primaryColor,),) : const SizedBox())
          ]
      ),
    );
  }
}
