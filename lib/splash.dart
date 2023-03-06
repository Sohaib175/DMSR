import 'package:flutter/material.dart';
import 'package:foodiesapp/dealscreen.dart';
import 'package:foodiesapp/login.dart';
import 'package:foodiesapp/palette.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _navigatetologin();
  }

  _navigatetologin() async {
    await Future.delayed(const Duration(milliseconds: 3500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => login()));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Palette.orange, Palette.darkGrey],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.1),
          Center(
            child: Image(
              image: const AssetImage('assets/logo.png'),
              height: screenHeight * 0.1,
            ),
          ),
          Image(
            image: const AssetImage('assets/vegies.png'),
            alignment: Alignment.bottomRight,
            height: screenWidth * 0.5,
          ),
        ],
      ),
    );
  }
}
