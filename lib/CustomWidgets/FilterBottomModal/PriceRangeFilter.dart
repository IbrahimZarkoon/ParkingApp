import 'dart:ui';
import 'package:flutter/material.dart';
import '../../Constants/Colors.dart';

class PriceRangeFilter extends StatefulWidget {
  @override
  _PriceRangeFilterState createState() => _PriceRangeFilterState();
}

class _PriceRangeFilterState extends State<PriceRangeFilter> {
  RangeValues _selectedRange = RangeValues(0, 500);
  double _minPrice = 0.0;
  double _maxPrice = 500.0;

  double _top = 0;

  @override
  void initState() {
    _selectedRange = RangeValues(16, 312);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RangeSlider(
            activeColor: primaryColor,
            inactiveColor: black.withOpacity(0.15),
            values: _selectedRange,
            min: _minPrice,
            max: _maxPrice,
            onChanged: (RangeValues values) {
              setState(() {
                _selectedRange = values;
              });
            },
            labels: RangeLabels(
              "£${_selectedRange.start.toStringAsFixed(2)}",
              "£${_selectedRange.end.toStringAsFixed(2)}",
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_selectedRange.start.toStringAsFixed(2)}',
                style: TextStyle(
                    fontFamily: "OpenSans_SemiBold",
                    fontSize: height * 0.02,
                    color: black),
              ),
              Text(
                '\$${_selectedRange.end.toStringAsFixed(2)}',
                style: TextStyle(
                    fontFamily: "OpenSans_SemiBold",
                    fontSize: height * 0.02,
                    color: black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}