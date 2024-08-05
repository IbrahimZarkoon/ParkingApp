import 'package:flutter/material.dart';

import '../../Constants/Colors.dart';

class FilterToggleContainer extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final Color black;
  final Color primaryColor;

  FilterToggleContainer({
    required this.text,
    required this.width,
    required this.height,
    required this.black,
    required this.primaryColor,
  });

  @override
  _FilterToggleContainerState createState() => _FilterToggleContainerState();
}

class _FilterToggleContainerState extends State<FilterToggleContainer> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isToggled = !isToggled;
        });
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: widget.width * 0.3,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isToggled ? Colors.transparent : widget.black.withOpacity(0.15),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
          color: isToggled ? widget.primaryColor.withOpacity(0.2) : Colors.transparent,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: widget.height * 0.015,
          vertical: widget.height * 0.01,
        ),
        child: Text(
          widget.text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isToggled ? widget.primaryColor : widget.black.withOpacity(0.75),
            fontSize: widget.height * 0.018,
            fontFamily: "OpenSans_SemiBold",
          ),
        ),
      ),
    );
  }
}

Widget shadowLine(BuildContext context)
{
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Container(
    width: width,
    height: height*0.02,
    color: black.withOpacity(0.05),
  );
}