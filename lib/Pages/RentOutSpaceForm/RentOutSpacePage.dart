import 'package:airportparking/Constants/Colors.dart';
import 'package:airportparking/Pages/RentOutSpaceForm/ElectricChargersTab.dart';
import 'package:airportparking/Pages/RentOutSpaceForm/SpaceAvailabilityTab.dart';
import 'package:airportparking/Pages/RentOutSpaceForm/SpaceLocationTab.dart';
import 'package:airportparking/Pages/RentOutSpaceForm/SpacePricingTab.dart';
import 'package:airportparking/Pages/RentOutSpaceForm/SpaceTypeTab.dart';
import 'package:airportparking/Pages/RentOutSpaceForm/SummaryTab.dart';
import 'package:airportparking/Pages/RentOutSpaceForm/ZipCodeTab.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RentOutSpacePage extends StatefulWidget {
  const RentOutSpacePage({super.key});

  @override
  State<RentOutSpacePage> createState() => _RentOutSpacePageState();
}

class _RentOutSpacePageState extends State<RentOutSpacePage> {
  int _selectedTab = 0;
  final PageController _pageController = PageController();

  final tabs = [
    ZipCodeTab(),
    SpaceTypeTab(),
    ElectricChargersTab(),
    SpaceAvailabilityTab(),
    SpaceLocationTab(),
    SpacePricingTab(),
    SummaryTab(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Rent out your space",
        style: TextStyle(
          color: black,
          fontFamily: "OpenSans_SemiBold",
          fontSize: height*0.02,
          fontWeight: FontWeight.bold
        ),),
        elevation: 0.5,
        leading: (_selectedTab > 0)
            ? InkWell(
          onTap: () {
            setState(() {
              if (_selectedTab > 0) {
                _selectedTab -= 1;
                _pageController.previousPage(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            child: Text(
              "Back",
              style: TextStyle(color: primaryColor, fontSize: 16),
            ),
          ),
        )
            : const SizedBox(),
        leadingWidth: 100,
        actions: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              child: Text(
                "Exit",
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: StepProgressIndicator(
              totalSteps: tabs.length,
              currentStep: _selectedTab + 1, // Adjusted for zero-based index
              size: 10,
              selectedColor: primaryColor,
              unselectedColor: Colors.black.withOpacity(0.2),
              roundedEdges: const Radius.circular(10),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        children: tabs,
        physics: NeverScrollableScrollPhysics(), // Disable manual swiping
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.015,
        ),
        constraints: BoxConstraints(maxHeight: height * 0.09),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black.withOpacity(0.15), width: 0.5),
          ),
        ),
        child: InkWell(
          onTap: () async {
            if (_selectedTab < tabs.length - 1) {
              _selectedTab++;
              _pageController.nextPage(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }

            setState(() {});
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: height * 0.025),
            width: width,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              _selectedTab == tabs.length - 1 ? "Submit for review" : "Continue",
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.02,
                fontFamily: "OpenSans_SemiBold",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

