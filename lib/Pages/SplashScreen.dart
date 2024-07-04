import 'package:airportparking/Pages/DashboardPage.dart';
import 'package:flutter/material.dart';

import '../Constants/Colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 1.75, end: 0.0).animate(_animationController);
    _animationController.forward();
    proceedtoHome();
  }

  proceedtoHome()
  {
    Future.delayed(
        const Duration(milliseconds: 1500),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardPage(tabindex: 0))),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryColor, // Set your desired background color

      body: Stack(
        children: [
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width*0.5
                ),
                child: Image.asset("assets/logos/Logo_White.png",fit: BoxFit.cover,color: white,),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 32.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
