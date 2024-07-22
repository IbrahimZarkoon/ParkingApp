import 'package:airportparking/Pages/SignUpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import 'ForgotPasswordPage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isObscured = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool circularProg = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(height * 0.025),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logos/Logo_White.png',
                    color: primaryColor,
                    width: width / 2,
                  ),
                  SizedBox(height: height * 0.04),
                  Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: height * 0.03,
                      fontFamily: "OpenSans_Bold",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'Become a Member - you\'ll enjoy exclusive deals, offers, invites and rewards.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: height * 0.018,
                      fontFamily: "OpenSans_SemiBold",
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: height * 0.06),

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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),

                        ),
                        enabledBorder: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(height: height * 0.03),

                  // Password TextField
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
                      controller: _passwordController,
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
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: height * 0.018,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),

                        ),
                        enabledBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured ? Icons.visibility : Icons.visibility_off,
                            color: _isObscured ? Colors.black.withOpacity(0.8) : primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isObscured,
                    ),
                  ),
                  SizedBox(height: height * 0.03),

                  // Forgot Password Link
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                      );
                    },
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: black,
                        fontSize: height * 0.018,
                        decoration: TextDecoration.underline,
                        fontFamily: "OpenSans_SemiBold"
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  // Sign In Button
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
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.019,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // Become a Member Button
                  InkWell(
                    onTap: () {
                      // Navigate to membership registration page

                      Navigator.push(context, CupertinoPageRoute(builder: (_) => SignUpPage()));
                    },
                    child: Container(
                      width: width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: height * 0.025, vertical: height * 0.015),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                        border: Border.all(color: primaryColor, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.25),
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Text(
                        "Become a member",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: height * 0.019,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Loading Indicator
            if (circularProg)
              Positioned.fill(
                child: Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
