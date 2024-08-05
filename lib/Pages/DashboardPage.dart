import 'dart:ui';

import 'package:airportparking/Pages/BookingsPage.dart';
import 'package:airportparking/Pages/LocationPage.dart';
import 'package:airportparking/Pages/RentOutPage.dart';
import 'package:airportparking/Pages/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../Constants/Colors.dart';
import 'ProfilePage.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key, required this.tabindex}) : super(key: key);

  int tabindex;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  final userTabs = [
    const LocationPage(),
    RentOutPage(),
    BookingsPage(),
    ProfilePage(),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: widget.tabindex);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;



    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: (widget.tabindex == 0 || widget.tabindex == 3)
                ? const SizedBox()
                : AppBar(
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: height*0.015),
                  child: Image.asset("assets/logos/Logo_White.png", width: height*0.125,),
                ),
              ],
            ),),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Center(
                  child: Container(
                    height: height*0.25,
                    width: width*0.25,
                    child: Image.asset("assets/logos/Logo_White.png",),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  // Handle the navigation
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Handle the navigation
                },
              ),
              // Add more ListTiles here
            ],
          ),
        ),
        body: Stack(children: [
          RepaintBoundary(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: userTabs)),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(0),
                topLeft: Radius.circular(0),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      border: Border(
                          top: BorderSide(
                              color: black.withOpacity(0.05), width: 0.5))),
                  child: SlidingClippedNavBar.colorful(
                    backgroundColor: Colors.transparent,
                    onButtonPressed: (index) {
                      setState(() {
                        widget.tabindex = index;
                      });
                      _tabController.animateTo(index,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutQuad);
                    },
                    iconSize: height * 0.03,
                    fontSize: height * 0.02,
                    fontStyle: FontStyle.normal,
                    selectedIndex: widget.tabindex,
                    barItems: [
                      BarItem(
                        icon: widget.tabindex == 0
                            ? Icons.local_parking
                            : Icons.local_parking_outlined,
                        activeColor: primaryColor,
                        inactiveColor: widget.tabindex == 0
                            ? Colors.transparent
                            : Color(0xff9a9e9f),
                        title: 'Parking',
                      ),
                      BarItem(
                        icon: widget.tabindex == 1
                            ? Icons.car_rental
                            : Icons.car_rental_outlined,
                        activeColor: primaryColor,
                        inactiveColor: widget.tabindex == 1
                            ? Colors.transparent
                            : Color(0xff9a9e9f),
                        title: 'Rent Out',
                      ),
                      BarItem(
                        icon: widget.tabindex == 2
                            ? Icons.receipt_long
                            : Icons.receipt_long_outlined,
                        activeColor: primaryColor,
                        inactiveColor: widget.tabindex == 2
                            ? Colors.transparent
                            : Color(0xff9a9e9f),
                        title: 'Bookings',
                      ),
                      BarItem(
                        icon: widget.tabindex == 3
                            ? Icons.person_2
                            : Icons.person_2_outlined,
                        activeColor: primaryColor,
                        inactiveColor: widget.tabindex == 3
                            ? Colors.transparent
                            : Color(0xff9a9e9f),
                        title: 'Profile',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
