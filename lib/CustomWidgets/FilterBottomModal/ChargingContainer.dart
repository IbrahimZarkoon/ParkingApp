import 'package:flutter/material.dart';

class ToggleContainerWithImage extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final Color black;
  final Color primaryColor;

  ToggleContainerWithImage({
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.black,
    required this.primaryColor,
  });

  @override
  _ToggleContainerWithImageState createState() => _ToggleContainerWithImageState();
}

class _ToggleContainerWithImageState extends State<ToggleContainerWithImage> {
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
          maxWidth: widget.width * 0.225,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isToggled ? widget.primaryColor.withOpacity(0.2) : widget.black.withOpacity(0.15),
            width:isToggled ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: widget.height * 0.015,
          vertical: widget.height * 0.01,
        ),
        child: Image.asset(
          widget.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}