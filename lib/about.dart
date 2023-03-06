import 'package:flutter/material.dart';

class about extends StatelessWidget {
  const about({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Card(
          elevation: 20,
          child: SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Image.asset(
                    'assets/logo_orange.png',
                    height: screenHeight * 0.06,
                  ),
                ),
                const Text(
                  "Digital Menu For Smart Restaurant",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Project Menbers",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Ali Ahmer Abbasi(COSC-18111010)",
                  style: TextStyle(fontSize: 22),
                ),
                const Text(
                  "M Sohaib Arshad(COSC-18111022)",
                  style: TextStyle(fontSize: 22),
                ),
                const Text(
                  "Supervisor",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Mr. Saqib Ubaid",
                  style: TextStyle(fontSize: 22),
                ),
                const Text(
                  "Batch(2018-2022)",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
