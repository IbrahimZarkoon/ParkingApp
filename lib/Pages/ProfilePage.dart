import 'package:airportparking/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/Colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Account Information',
              style: TextStyle(
                fontSize: height * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              'You can edit your Trinqoo profile information below, Clicking on the reset password button will send a reset link to your email.',
              style: TextStyle(
                color: black,
                fontSize: height * 0.016,

              ),
            ),
            SizedBox(height: height * 0.02),
            TextField(
              decoration: InputDecoration(
                hintText: 'First Name',

                contentPadding: EdgeInsets.symmetric(horizontal: height*0.015),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: height*0.015),
                hintText: 'Last Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: '+1', // Replace with selected country code
                        onChanged: (String? value) {
                          // Handle country code selection
                        },
                        items: <String>['+1', '+44', '+91','+92','+971','+970',] // Replace with your country codes
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: height*0.015),
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            ElevatedButton(
              onPressed: () {
                // Handle reset password action
              },
              child: Text('Reset Password'),
            ),
            SizedBox(height: height * 0.02),
            TextButton(
              onPressed: () {
                // Handle forgot password action
              },
              child: Text('Forgot Password?'),
            ),
            SizedBox(height: height * 0.02),
            Container(
              height: 1,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
