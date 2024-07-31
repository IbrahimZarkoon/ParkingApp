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

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin{

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
    _tabController = TabController(length: 4, vsync: this,initialIndex: widget.tabindex);
  }


  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: Scaffold(
        endDrawer: Drawer(
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          shadowColor: Colors.black.withOpacity(0.5),
          child:  const Drawer(
          ),

        ),

        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: (widget.tabindex == 0 || widget.tabindex == 3)? const SizedBox() : AppBar(
            backgroundColor: primaryColor,
            leading: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Image.asset("assets/logos/Logo_White.png")),
            leadingWidth: 100,
          )
        ),

        body:RepaintBoundary(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: userTabs)),

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 1.5,
                    spreadRadius: 0,
                    offset: const Offset(0,-1)
                )
              ]
          ),
          child: SlidingClippedNavBar(
            backgroundColor: Colors.white,
            onButtonPressed: (index) {
              setState(() {
                widget.tabindex = index;
              });
              _tabController.animateTo(index,
                  duration: const Duration(milliseconds: 200), curve: Curves.easeOutQuad);
            },
            iconSize: height*0.03,
            activeColor: primaryColor,
            fontSize: height*0.02,
            fontStyle: FontStyle.normal,
            selectedIndex: widget.tabindex,
            inactiveColor: Color(0xffb7bcbd),
            barItems: [
              BarItem(
                icon: widget.tabindex == 0 ? Icons.local_parking : Icons.local_parking_outlined,
                title: 'Parking',
              ),
              BarItem(
                icon: widget.tabindex == 1 ? Icons.car_rental : Icons.car_rental_outlined,
                title: 'Rent Out',
              ),
              BarItem(
                icon: widget.tabindex == 2 ? Icons.receipt_long : Icons.receipt_long_outlined,
                title: 'Bookings',
              ),
              BarItem(
                icon: widget.tabindex == 3 ? Icons.person_2 : Icons.person_2_outlined,
                title: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

}
