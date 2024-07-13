import 'dart:ui';

import 'package:flutter/material.dart';

import '../Constants/Colors.dart';

class setDaysBottomSheet extends StatefulWidget {
  final double height;
  final double width;
  final Color primaryColor;

  setDaysBottomSheet({required this.height, required this.width, required this.primaryColor});

  @override
  _setDaysBottomSheetState createState() => _setDaysBottomSheetState();
}

class _setDaysBottomSheetState extends State<setDaysBottomSheet> {
  final List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  final Map<String, bool> dayAvailability = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": false,
  };

  @override
  Widget build(BuildContext context) {
    bool isTap = false; // Define this as per your requirement or state management logic
    return Container(
      color: Colors.white,
      constraints: BoxConstraints(maxHeight: widget.height * 0.9),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          title: Text(
            "Set your custom availability",
            style: TextStyle(
              color: Colors.black,
              fontSize: widget.height * 0.022,
              fontWeight: FontWeight.bold,
            ),
          ),
          leadingWidth: 50,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: widget.height * 0.025,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: widget.height * 0.025, vertical: widget.height * 0.015),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose the days and times that you would like to make your space available to drivers.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: widget.height * 0.02,
                ),
              ),
              SizedBox(height: widget.height * 0.02),
              for (var day in days)
                Container(
                  margin: EdgeInsets.only(top: widget.height * 0.025),
                  width: widget.width,
                  padding: EdgeInsets.all(widget.height * 0.015),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                    border: Border.all(
                      color: isTap ? widget.primaryColor : Colors.white,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isTap ? widget.primaryColor.withOpacity(0.25) : Colors.black.withOpacity(0.25),
                        offset: const Offset(0, 0),
                        blurRadius: 1,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: widget.height * 0.02,
                        ),
                      ),
                      Switch(
                        inactiveThumbColor: white,
                        inactiveTrackColor: black.withOpacity(0.2),
                        trackOutlineColor: MaterialStateProperty.all(black.withOpacity(0.1)),
                        value: dayAvailability[day]!,
                        onChanged: (bool value) {
                          setState(() {
                            dayAvailability[day] = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              SizedBox(height: widget.height * 0.1),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          constraints: BoxConstraints(maxHeight: widget.height * 0.125),
          color: Colors.white,
          child: InkWell(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.all(widget.height * 0.025),
              width: widget.width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: widget.height * 0.025, vertical: widget.height * 0.015),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: widget.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.height * 0.019,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}