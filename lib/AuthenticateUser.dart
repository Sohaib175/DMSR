import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:foodiesapp/User.dart';
import 'package:foodiesapp/adminHome.dart';

import 'chefHome.dart';

class AuthenticateUser extends StatefulWidget {
  const AuthenticateUser({Key? key}) : super(key: key);

  @override
  State<AuthenticateUser> createState() => _AuthenticateUserState();
}

class _AuthenticateUserState extends State<AuthenticateUser> {
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
    return FutureBuilder<Usermodal?>(
        future: readUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text("Something went wrong reading users"));
          } else if (snapshot.hasData) {
            final user = snapshot.data;
            if (user!.role == "admin") {
              return adminHome();
            } else {
              return chefHome(
                  // role: "chef",
                  // ID: userID,
                  );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
