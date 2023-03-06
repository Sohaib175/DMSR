import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodiesapp/AuthenticateUser.dart';
import 'package:foodiesapp/dealscreen.dart';
import 'package:foodiesapp/main.dart';
import 'package:foodiesapp/palette.dart';
import 'package:foodiesapp/Table.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

final tableController = TextEditingController();

class _loginState extends State<login> {
  bool _isObscure = true;
  var toggleboxAlignment = Alignment.centerLeft;
  var toggletxt1Color = Palette.white;
  var toggletxt2Color = Palette.orange;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    Future signIn() async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        print(e);
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    Widget loginWidget() => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Palette.white, Palette.mediumGrey],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight * 0.35,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/login_BG.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Palette.orange.withOpacity(0.4),
                              Palette.darkGrey.withOpacity(0.98),
                            ]),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.06,
                        ),
                        child: Container(
                          height: screenHeight * 0.07,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/logo.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.2,
                  left: screenWidth * 0.1,
                  right: screenWidth * 0.1,
                  child: Container(
                    height: screenHeight * 0.7,
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenWidth * 0.1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Palette.black.withOpacity(0.3),
                          spreadRadius: 8,
                          blurRadius: 10,
                          offset: const Offset(
                              10, 10), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),

                        /*Toggle Button*/

                        const Text(
                          "Staff Login",
                          style: TextStyle(fontSize: 30, color: Palette.orange),
                        ),

                        // Container(
                        //   height: screenHeight * 0.050,
                        //   width: screenWidth * 0.6,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.all(
                        //       Radius.circular(screenHeight * 0.025),
                        //     ),
                        //     border: Border.all(
                        //       width: 2,
                        //       color: Palette.lightGrey,
                        //       style: BorderStyle.solid,
                        //     ),
                        //   ),
                        //   child: Stack(
                        //     alignment: toggleboxAlignment,
                        //     children: [
                        //       Container(
                        //         height: screenHeight * 0.050,
                        //         width: screenWidth * 0.3,
                        //         decoration: BoxDecoration(
                        //           color: Palette.orange,
                        //           borderRadius: BorderRadius.all(
                        //             Radius.circular(screenHeight * 0.025),
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox.expand(
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             GestureDetector(
                        //               onTap: () {
                        //                 if (toggleboxAlignment ==
                        //                     Alignment.centerRight) {
                        //                   _moveToggleBox();
                        //                 }
                        //               },
                        //               child: Container(
                        //                 height: screenHeight * 0.050,
                        //                 width: screenWidth * 0.3,
                        //                 decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(25)),
                        //                 child: Center(
                        //                   child: Text(
                        //                     'Manager',
                        //                     style: TextStyle(
                        //                       fontSize: 20,
                        //                       fontWeight: FontWeight.bold,
                        //                       color: toggletxt1Color,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: () {
                        //                 if (toggleboxAlignment ==
                        //                     Alignment.centerLeft) {
                        //                   _moveToggleBox();
                        //                 }
                        //               },
                        //               child: Container(
                        //                 height: screenHeight * 0.050,
                        //                 width: screenWidth * 0.29,
                        //                 decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(25)),
                        //                 child: Center(
                        //                   child: Text(
                        //                     'Chef',
                        //                     style: TextStyle(
                        //                       fontSize: 20,
                        //                       fontWeight: FontWeight.bold,
                        //                       color: toggletxt2Color,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),

                        /*User Input Feild*/

                        SizedBox(
                          height: screenHeight * 0.050,
                          width: screenWidth * 0.7,
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Palette.orange,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.orange),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.orange),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              hintText: "Email",
                              labelText: "Email",
                              hintStyle: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),

                        /*Password Input Feild*/

                        SizedBox(
                          height: screenHeight * 0.050,
                          width: screenWidth * 0.7,
                          child: TextField(
                            controller: passwordController,
                            //obscureText: _isObscure,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: const InputDecoration(
                              // suffix: IconButton(
                              //   color: Palette.orange,
                              //   icon: Icon(_isObscure
                              //       ? Icons.visibility
                              //       : Icons.visibility_off),
                              //   onPressed: () {
                              //     setState(() {
                              //       _isObscure = !_isObscure;
                              //     });
                              //   },
                              // ),
                              prefixIcon: Icon(
                                Icons.password_outlined,
                                color: Palette.orange,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.orange),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.orange),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              hintText: "Password",
                              labelText: "Password",
                              hintStyle: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),

                        /*Forgot Password*/

                        Padding(
                          padding: EdgeInsets.only(
                            right: screenWidth * 0.08,
                          ),
                          child: GestureDetector(
                            onTap: (() {
                              Fluttertoast.showToast(
                                  msg: "Forgot Password Call Funtion",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Palette.orange,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /*
                    Login Button
                     */

                        SizedBox(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.05,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              primary: Colors.white,
                              backgroundColor: Palette.orange,
                            ),
                            onPressed: () {
                              signIn();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_outlined,
                                  size: screenHeight * 0.03,
                                ),
                              ],
                            ),
                          ),
                        ),

                        /*
                    TEXT
                     */

                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '-OR-',
                                style: TextStyle(
                                  color: Palette.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /*
                    MENU Button
                     */

                        SizedBox(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.05,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              primary: Colors.white,
                              backgroundColor: Palette.orange,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Table Number Required!",
                                    style: TextStyle(
                                        fontSize: 30, color: Palette.orange),
                                  ),
                                  content: TextField(
                                    controller: tableController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: const InputDecoration(
                                        labelText: "Table Number"),
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      height: 1.0,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text(
                                        "Initiate",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Palette.orange),
                                      ),
                                      onPressed: () {
                                        Tableinfo.Table_Number =
                                            int.parse(tableController.text);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => dealscreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Initiate Menu',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.menu_book,
                                  size: screenHeight * 0.03,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return AuthenticateUser();
            } else {
              return loginWidget();
            }
          }),
    );
  }
}
