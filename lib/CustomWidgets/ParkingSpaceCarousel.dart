import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Modals/ParkingSpaceClass.dart';

class ParkingSpacesCarousel extends StatefulWidget {
  final List<ParkingSpace> parkingSpacesList;
  final GoogleMapController gmController;
  final Function(LatLng) onCarouselChange;
  final Function(int) createMarkers;
  final PageController pageController;

  const ParkingSpacesCarousel({
    super.key,
    required this.parkingSpacesList,
    required this.gmController,
    required this.onCarouselChange,
    required this.pageController, required this.createMarkers,
  });

  @override
  State<ParkingSpacesCarousel> createState() => _ParkingSpacesCarouselState();
}

class _ParkingSpacesCarouselState extends State<ParkingSpacesCarousel> {



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return PageView.builder(
      controller: widget.pageController,
      onPageChanged: (index) {
        LatLng target = widget.parkingSpacesList[index].latlng!;
        widget.onCarouselChange(target);
        widget.createMarkers(index);
      },
      itemCount: widget.parkingSpacesList.length,
      itemBuilder: (context, index) {
        final parkingSpace = widget.parkingSpacesList[index];
        return parkingSpaceCon(parkingSpace);
      },
    );
  }
  
  Widget parkingSpaceCon(ParkingSpace parkingSpace)
  {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: height*0.015,vertical: height*0.015),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(1,1),
                spreadRadius: 1,
                blurRadius: 5
            )
          ]
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: height*0.015,vertical: height*0.015),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${parkingSpace.title}",
                        style: TextStyle(
                          fontSize: height*0.022,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("${parkingSpace.address}",
                        style: TextStyle(
                          fontSize: height*0.016,
                          fontWeight: FontWeight.normal,
                        ),),
                    ],
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [


                      Icon(CupertinoIcons.car_detailed,size: height*0.0225,),
                      SizedBox(width: height*0.005,),


                      Text('${parkingSpace.capacity}',style: TextStyle(
                        fontSize: height*0.018,
                        fontWeight: FontWeight.normal,
                      ),),

                      SizedBox(width: height*0.015,),


                      Icon(CupertinoIcons.money_dollar_circle,size: height*0.0225,),
                      SizedBox(width: height*0.005,),

                      if(parkingSpace.hourlyRate! > 0) Text('\$${parkingSpace.hourlyRate}/hr',style: TextStyle(
                        fontSize: height*0.018,
                        fontWeight: FontWeight.normal,
                      ),),

                      if(parkingSpace.dailyRate! > 0) Text('\$${parkingSpace.dailyRate}/day',style: TextStyle(
                        fontSize: height*0.018,
                        fontWeight: FontWeight.normal,
                      ),),


                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: height*0.015,),

            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all( Radius.circular(12),),
                child: Image.network(
                  // Replace with your image loading mechanism
                  '${parkingSpace.images?[0]}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}