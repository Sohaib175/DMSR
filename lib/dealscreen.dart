import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodiesapp/categorySelectionScreen.dart';

class dealscreen extends StatefulWidget {
  dealscreen({Key? key}) : super(key: key);

  @override
  State<dealscreen> createState() => _dealscreenState();

  List<String> photos = [
    "assets/deal1.jpg",
    "assets/deal2.jpg",
    "assets/deal3.jpg",
    "assets/deal4.jpg",
    "assets/deal5.jpg"
  ];
  // dealscreen(this.photos);
}

class _dealscreenState extends State<dealscreen> {
  int _pos = 0;

  @override
  void initState() {
    rotateImage();
    super.initState();
  }

  rotateImage() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 5000), () {});
      if (mounted) {
        setState(() {
          _pos = (_pos + 1) % widget.photos.length;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: GestureDetector(
      onTap: (() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => categoryScreen()));
      }),
      child: Stack(
        children: [
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Image.asset(
              widget.photos[_pos],
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          ),
        ],
      ),
    ));
  }

  void dispose() {
    super.dispose();
  }
}
