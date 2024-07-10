import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = true; // Add this line

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () { // Change to 2 or 3 seconds as needed
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leadingWidth: 50,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: black,
              size: MediaQuery.sizeOf(context).height * 0.0325,
            )),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: primaryColor,))  : SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/logos/Logo_White.png',color: primaryColor,width: width/2,),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            Text(
              'Forgot password?',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.03,fontFamily: "OpenSans_Bold"),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.01),
            Text(
              'Please enter the email address you used to create your account, and we\'ll send you a link to reset your password.',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: MediaQuery.sizeOf(context).height*0.018,fontFamily: "OpenSans_SemiBold"),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.06),

            // Email TextField
            Container(
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
                controller: _emailController,
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
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),

            SizedBox(height: MediaQuery.sizeOf(context).height*0.03),

            InkWell(
              onTap: () async {
                // Add your sign in logic here
              },
              child: Container(
                width: width,
                alignment: Alignment.center,
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
                  "Submit",
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
}
