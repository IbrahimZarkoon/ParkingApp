import 'package:airportparking/Pages/BookingsPage.dart';
import 'package:airportparking/Pages/LocationPage.dart';
import 'package:airportparking/Pages/RentOutPage.dart';
import 'package:airportparking/Pages/SignInPage.dart';
import 'package:flutter/material.dart';

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

        bottomNavigationBar:  Container(
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
          height: kToolbarHeight,
          child: TabBar(
            dividerColor: const Color(0xfff1f1f1),
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            indicator:  BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: white,
                  width: 3.0,
                ),
              ),
            ),
            controller: _tabController,
            indicatorColor: white,
            unselectedLabelColor: Colors.black.withOpacity(0.35),
            labelColor:  primaryColor,
            labelStyle:  TextStyle(
                fontSize: height *0.015
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: height*0.013,
            ),
            onTap: (int index)
            {
              setState(() {
                widget.tabindex = index;
              });
            },
            tabs: [
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 0),
                icon: Icon(widget.tabindex == 0? Icons.local_parking : Icons.local_parking_outlined,size:widget.tabindex == 0? height*0.0275 : height*0.025,),
                child:  Flexible(child: Text("Parking",)),
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 0),
                icon: Icon(widget.tabindex == 1? Icons.car_rental :Icons.car_rental_outlined,size:widget.tabindex == 1? height*0.0275 : height*0.025),
                child: Flexible(child: Text("Rent Out",)),
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 0),
                icon: Icon(widget.tabindex == 2? Icons.receipt_long :Icons.receipt_long_outlined,size:widget.tabindex == 2? height*0.0275 : height*0.025),
                child: Flexible(child: Text("Bookings",)),

              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 0),
                icon: Icon(widget.tabindex == 3? Icons.person_2 :Icons.person_2_outlined,size:widget.tabindex == 3? height*0.0275 : height*0.025),
                child: Flexible(child: Text("Profile",)),

              ),
            ],
          ),
        ),
      ),
    );
  }

}
