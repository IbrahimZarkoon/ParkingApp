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
        obscureText: isPassword ? _isObscured : false,
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
          border: InputBorder.none,
          suffixIcon: suffixIcon != null
              ? IconButton(
            icon: Icon(suffixIcon, color: _isObscured ? Colors.black.withOpacity(0.8) : Colors.black),
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
                Center(child: Image.asset('assets/logos/Logo_White.png', color: primaryColor, width: width / 2,)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(
                  child: Text(
                    'BECOME A MEMBER',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.sizeOf(context).height * 0.03,
                      fontFamily: "OpenSans_SemiBold",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                Center(
                  child: Text(
                    'Become a Member - you\'ll enjoy exclusive deals, offers, invites and rewards.',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.sizeOf(context).height * 0.016,
                      fontFamily: "OpenSans_SemiBold",
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.06),

                customTextField(
                  hintText: 'Email *',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                customTextField(
                  hintText: 'Create a password *',
                  controller: _passwordController,
                  isPassword: true,
                  suffixIcon: _isObscured ? Icons.visibility : Icons.visibility_off,
                  onTapSuffixIcon: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                Text(
                  "Minimum 8 characters",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontFamily: "OpenSans",
                    fontSize: MediaQuery.sizeOf(context).height * 0.013,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                customTextField(
                  hintText: 'Date of Birth *',
                  controller: _dobController,
                  suffixIcon: Icons.calendar_today,
                  onTapSuffixIcon: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDate(context, _dobController);
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                Text(
                  "Trinqoo wants to give you a special treat on your birthday",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontFamily: "OpenSans",
                    fontSize: MediaQuery.sizeOf(context).height * 0.013,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                customTextField(
                  hintText: 'Phone *',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color:_isExpanded? primaryColor : Colors.black.withOpacity(0.2)),
                  ),
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
                      expandIconColor: _isExpanded ? primaryColor : Colors.black,
                      children: [
                        ExpansionPanel(
                          backgroundColor: Colors.white,
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                              child: ListTile(
                                iconColor: _isExpanded ? primaryColor : Colors.black,
                                style: ListTileStyle.list,
                                title: Text(
                                  'Add more',
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.018,
                                    fontFamily: "OpenSans_SemiBold",
                                    fontWeight: FontWeight.bold,
                                    color: _isExpanded ? primaryColor : Colors.black,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          },
                          body: Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.025),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                customTextField(
                                  hintText: 'First Name',
                                  controller: _firstNameController,
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                customTextField(
                                  hintText: 'Last Name',
                                  controller: _lastNameController,
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                customTextField(
                                  hintText: 'Gender',
                                  controller: _genderController,
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                customTextField(
                                  hintText: 'Zip code',
                                  controller: _zipCodeController,
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                              ],
                            ),
                          ),
                          isExpanded: _isExpanded,
                          canTapOnHeader: true,
                        ),
                      ],
                    )
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                      "Become a member",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.019,
                        fontWeight: FontWeight.bold,
                      ),
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
                        'By clicking \'Become a member\', I agree to the Trinqoo Membership ',
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
                        'To give you the full membership experience, we will process your personal data in accordance with the Trinqoo\'s ',
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
        ],
      ),
    );
  }
}
