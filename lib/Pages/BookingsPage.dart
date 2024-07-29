import 'package:airportparking/CustomWidgets/BookingsBottomModal.dart';
import 'package:airportparking/CustomWidgets/ParkingSpaceCarousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Constants/Colors.dart';
import '../CustomWidgets/SingleParkingSpaceModal.dart';
import '../Modals/ParkingSpaceClass.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage>
    with SingleTickerProviderStateMixin {
  String selectedOption = 'My Bookings';
  late TabController _tabController;
  late PageController _pageController;

  List<ParkingSpace> parkingSpacesList = [
    ParkingSpace("1", "City Center Lot", "456 Center St, Cityville",
        const LatLng(24.8722059, 67.0545099), 150, 0, 18.00, [
      "https://img.freepik.com/free-photo/hallway-garage_23-2149397542.jpg",
      "https://img.freepik.com/free-photo/horizontal-picture-car-parking-underground-garage-interior-with-neon-lights-autocars-parked-buildings-urban-constructions-space-transportation-vehicle-night-city-concept_343059-3077.jpg"
    ]),
    ParkingSpace("2", "Eastside Parking", "789 East St, Cityville",
        const LatLng(24.8732059, 67.0555099), 100, 4.00, 0, [
      "https://img.freepik.com/free-photo/blank-spaces-parking-lot_1127-36.jpg",
      "https://img.freepik.com/free-photo/structure-indoor-automobile-basement-large_1127-2362.jpg"
    ]),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: [
          myBookingsCon(),
          receivedBookingsCon(),
        ],
        onPageChanged: (int index) {
          setState(() {
            selectedOption = index == 0 ? 'My Bookings' : 'Received Bookings';
          });
        },
      ),
    );
  }

  Widget myBookingsCon() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                  color: black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 3))
            ]),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: height * 0.025, vertical: height * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "My Bookings",
                        style: TextStyle(
                          color: black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: ()
                        {
                          _pageController.animateToPage(
                            1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          "Received Bookings",
                          style: TextStyle(
                            color: black.withOpacity(0.6),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: 'In Progress'),
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Past'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: [
                inProgressTab(),
                upComingTab(),
                pastBookings(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget receivedBookingsCon() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                  color: black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 3))
            ]),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: height * 0.025, vertical: height * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: ()
                        {
                          _pageController.animateToPage(
                            0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          "My Bookings",
                          style: TextStyle(
                            color: black.withOpacity(0.6),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Received Bookings",
                        style: TextStyle(
                          color: black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: 'In Progress'),
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Past'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: [
                inProgressTab(),
                upComingTab(),
                pastBookings(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget inProgressTab() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: parkingSpacesList.length,
      padding: EdgeInsets.symmetric(vertical: height * 0.025),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, index) {
        return parkingSpaceCon(context, parkingSpacesList[index]);
      },
    );

    // return Center(child: Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //
    //     Image(image: AssetImage("assets/images/searchBookings.png"),width: height*0.2,height: height*0.2,fit: BoxFit.cover,),
    //
    //     Text('No Bookings found',
    //       style: TextStyle(
    //           color: black.withOpacity(0.5),
    //           fontWeight: FontWeight.bold,
    //           fontSize: height*0.022
    //       ),),
    //     Text('In progress bookings will appear here',
    //       style: TextStyle(
    //           color: black.withOpacity(0.5),
    //           fontWeight: FontWeight.normal,
    //           fontSize: height*0.016
    //       ),),
    //
    //   ],
    // ));
  }

  Widget upComingTab() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/images/searchBookings.png"),
          width: height * 0.2,
          height: height * 0.2,
          fit: BoxFit.cover,
        ),
        Text(
          'No Bookings found',
          style: TextStyle(
              color: black.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: height * 0.022),
        ),
        Text(
          'Up coming bookings will appear here',
          style: TextStyle(
              color: black.withOpacity(0.5),
              fontWeight: FontWeight.normal,
              fontSize: height * 0.016),
        ),
      ],
    ));
  }

  Widget pastBookings() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/images/searchBookings.png"),
          width: height * 0.2,
          height: height * 0.2,
          fit: BoxFit.cover,
        ),
        Text(
          'No Bookings found',
          style: TextStyle(
              color: black.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: height * 0.022),
        ),
        Text(
          'Past bookings will appear here',
          style: TextStyle(
              color: black.withOpacity(0.5),
              fontWeight: FontWeight.normal,
              fontSize: height * 0.016),
        ),
      ],
    ));
  }

  Widget _buildRoundedButton(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = text;
        });
        _pageController.animateToPage(
          text == 'My Bookings' ? 0 : 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Text(
        text,
        style: TextStyle(
          color: selectedOption == text ? black : black.withOpacity(0.6),
          fontSize: selectedOption == text ? 20 : 16,
          fontWeight:
              selectedOption == text ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget parkingSpaceCon(BuildContext context, ParkingSpace parkingSpace) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            context: context,
            constraints: BoxConstraints(
              maxHeight: height * 0.9,
              minHeight: height * 0.7,
              maxWidth: width,
            ),
            backgroundColor: white,
            elevation: 0,
            builder: (BuildContext context) {
              return BookingsBottomModal(
                parkingSpace: parkingSpace,
              );
            });
      },
      child: Container(
        margin: EdgeInsets.only(
            left: height * 0.025,
            right: height * 0.025,
            bottom: height * 0.025),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(1, 1),
                  spreadRadius: 1,
                  blurRadius: 5)
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: height * 0.015, vertical: height * 0.015),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: Image.network(
                    // Replace with your image loading mechanism
                    '${parkingSpace.images?[0]}',
                    fit: BoxFit.cover,
                    width: height * 0.125,
                    height: height * 0.1,
                  ),
                ),
              ),
              SizedBox(
                width: height * 0.015,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${parkingSpace.title}",
                          style: TextStyle(
                            fontSize: height * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${parkingSpace.address}",
                          style: TextStyle(
                            fontSize: height * 0.016,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.car_detailed,
                          size: height * 0.0225,
                        ),
                        SizedBox(
                          width: height * 0.005,
                        ),
                        Text(
                          'AB-3344',
                          style: TextStyle(
                            fontSize: height * 0.016,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          width: height * 0.015,
                        ),
                        Icon(
                          CupertinoIcons.money_dollar_circle,
                          size: height * 0.0225,
                        ),
                        SizedBox(
                          width: height * 0.005,
                        ),
                        if (parkingSpace.hourlyRate! > 0)
                          Text(
                            '\$${parkingSpace.hourlyRate}/hr',
                            style: TextStyle(
                              fontSize: height * 0.016,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        if (parkingSpace.dailyRate! > 0)
                          Text(
                            '\$${parkingSpace.dailyRate}/day',
                            style: TextStyle(
                              fontSize: height * 0.016,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
