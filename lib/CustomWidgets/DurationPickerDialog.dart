import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../Constants/Colors.dart';

class DurationPicker extends StatefulWidget {
  final Duration initialDuration;

  DurationPicker({required this.initialDuration});

  @override
  _DurationPickerState createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  late int selectedDays;
  late int selectedHours;
  late int selectedMinutes;

  @override
  void initState() {
    super.initState();
    selectedDays = widget.initialDuration.inDays;
    selectedHours = widget.initialDuration.inHours % 24;
    selectedMinutes = widget.initialDuration.inMinutes % 60;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text(
        'Select Duration',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: height * 0.025,fontWeight: FontWeight.bold,color: black),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Days',
                  style: TextStyle(fontSize: height * 0.02),
                ),
                NumberPicker(
                  selectedTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.03,
                    color: Colors.black,
                  ),
                  value: selectedDays,
                  minValue: 0,
                  maxValue: 30,
                  onChanged: (value) {
                    setState(() {
                      selectedDays = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hours',
                  style: TextStyle(fontSize: height * 0.02),
                ),
                NumberPicker(
                  selectedTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.03,
                    color: Colors.black,
                  ),
                  value: selectedHours,
                  minValue: 0,
                  maxValue: 23,
                  onChanged: (value) {
                    setState(() {
                      selectedHours = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Minutes',
                  style: TextStyle(fontSize: height * 0.02),
                ),
                NumberPicker(
                  selectedTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.03,
                    color: Colors.black,
                  ),
                  value: selectedMinutes,
                  minValue: 0,
                  maxValue: 59,
                  onChanged: (value) {
                    setState(() {
                      selectedMinutes = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          width: width * 0.3,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              elevation: MaterialStateProperty.all(3),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Back',
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.02,
              ),
            ),
          ),
        ),
        SizedBox(
          width: width * 0.3,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all(BorderSide(color: primaryColor)),
              elevation: MaterialStateProperty.all(3),
            ),
            onPressed: () {
              Navigator.of(context).pop(Duration(
                days: selectedDays,
                hours: selectedHours,
                minutes: selectedMinutes,
              ));
            },
            child: Text(
              'Select',
              style: TextStyle(
                color: primaryColor,
                fontSize: height * 0.02,
              ),
            ),
          ),
        ),
      ],
    );
  }
}