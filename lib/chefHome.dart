import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:foodiesapp/User.dart';
import 'package:foodiesapp/palette.dart';

class chefHome extends StatefulWidget {
  const chefHome({
    // required String? ID,
    // required String role,
    Key? key,
  }) : super(key: key);

  @override
  State<chefHome> createState() => _chefHomeState();
}

defineuser() {}

class _chefHomeState extends State<chefHome> {
  final userID = FirebaseAuth.instance.currentUser?.email;

  Future<Usermodal?> readUser() async {
    final docUser =
        FirebaseFirestore.instance.collection("Users").doc(userID.toString());
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return Usermodal.fromJson(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.orange,
        title: const Text(
          "Chef's Dashboard",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Usermodal?>(
          future: readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text("Something went wrong reading users"));
            } else if (snapshot.hasData) {
              final user = snapshot.data;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 30,
                      ),
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Text(
                      user!.name,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "Role : " + user.role,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (() {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const manage_category()));
                                }),
                                child: Container(
                                  width: screenWidth * 0.2,
                                  height: screenHeight * 0.1,
                                  decoration: BoxDecoration(
                                      color: Palette.orange,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.event_available_outlined,
                                        size: 50,
                                        color: Palette.white,
                                      ),
                                      Text(
                                        "Manage Items Availability",
                                        style: TextStyle(
                                            fontSize: 25, color: Palette.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (() {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const ListUsers()));
                                }),
                                child: Container(
                                  width: screenWidth * 0.2,
                                  height: screenHeight * 0.1,
                                  decoration: BoxDecoration(
                                      color: Palette.orange,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.list_alt_outlined,
                                        size: 50,
                                        color: Palette.white,
                                      ),
                                      Text(
                                        "Manage Orders",
                                        style: TextStyle(
                                            fontSize: 25, color: Palette.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (() {}),
                                child: Container(
                                  width: screenWidth * 0.2,
                                  height: screenHeight * 0.1,
                                  decoration: BoxDecoration(
                                      color: Palette.orange,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.manage_history,
                                        size: 50,
                                        color: Palette.white,
                                      ),
                                      Text(
                                        "View Payment History",
                                        style: TextStyle(
                                            fontSize: 25, color: Palette.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FocusedMenuHolder(
                                openWithTap: true,
                                menuItems: [
                                  FocusedMenuItem(
                                      backgroundColor: Palette.white,
                                      title: const Text(
                                        "Change Password",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Palette.orange),
                                      ),
                                      trailingIcon: const Icon(
                                        Icons.password_outlined,
                                        color: Palette.orange,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text(
                                                "Change Password?",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Palette.orange),
                                              ),
                                              content: TextField(
                                                // controller: passwordController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            "New Password"),
                                                style: const TextStyle(
                                                  fontSize: 20.0,
                                                  height: 1.0,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Palette.orange),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                TextButton(
                                                  child: const Text(
                                                    "Change",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Palette.orange),
                                                  ),
                                                  onPressed: () {
                                                    // if (passwordController
                                                    //         .text ==
                                                    //     "") {
                                                    //   Fluttertoast.showToast(
                                                    //       msg:
                                                    //           "Password Feild Empty",
                                                    //       toastLength: Toast
                                                    //           .LENGTH_SHORT,
                                                    //       gravity: ToastGravity
                                                    //           .BOTTOM,
                                                    //       timeInSecForIosWeb: 1,
                                                    //       backgroundColor:
                                                    //           Palette.orange,
                                                    //       textColor:
                                                    //           Colors.white,
                                                    //       fontSize: 16.0);
                                                    // } else {
                                                    //   _changePassword(
                                                    //       passwordController
                                                    //           .text);
                                                    //   Fluttertoast.showToast(
                                                    //       msg:
                                                    //           "Password Changed",
                                                    //       toastLength: Toast
                                                    //           .LENGTH_SHORT,
                                                    //       gravity: ToastGravity
                                                    //           .BOTTOM,
                                                    //       timeInSecForIosWeb: 1,
                                                    //       backgroundColor:
                                                    //           Palette.orange,
                                                    //       textColor:
                                                    //           Colors.white,
                                                    //       fontSize: 16.0);
                                                    //   Navigator.pop(context);
                                                    // }
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                      }),
                                  FocusedMenuItem(
                                    backgroundColor: Palette.orange,
                                    title: const Text(
                                      "Logout",
                                      style: TextStyle(
                                          fontSize: 20, color: Palette.white),
                                    ),
                                    trailingIcon: const Icon(
                                      Icons.logout_outlined,
                                      color: Palette.white,
                                    ),
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                    },
                                  ),
                                ],
                                onPressed: () {},
                                child: Container(
                                  width: screenWidth * 0.2,
                                  height: screenHeight * 0.1,
                                  decoration: BoxDecoration(
                                      color: Palette.orange,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.settings_outlined,
                                        size: 50,
                                        color: Palette.white,
                                      ),
                                      Text(
                                        "Profile Settings",
                                        style: TextStyle(
                                            fontSize: 25, color: Palette.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
