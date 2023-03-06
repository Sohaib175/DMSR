import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:foodiesapp/AddUser.dart';
import 'package:foodiesapp/palette.dart';

import 'User.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  State<ListUsers> createState() => _ListUsersState();
}

Stream<List<Usermodal>> readUsers() =>
    FirebaseFirestore.instance.collection("Users").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Usermodal.fromJson(doc.data())).toList());

class _ListUsersState extends State<ListUsers> {
  @override
  Widget build(BuildContext context) {
    Widget buildUsers(Usermodal user) => FocusedMenuHolder(
          menuItems: [
            FocusedMenuItem(
                title: const Text(
                  "Change Role",
                  style: TextStyle(fontSize: 20),
                ),
                trailingIcon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  // changeRole(user);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              "Change Role!",
                              style: TextStyle(
                                  fontSize: 30, color: Palette.orange),
                            ),
                            content: const Text(
                              "Select role for the user",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  "Chef",
                                  style: TextStyle(
                                      fontSize: 20, color: Palette.orange),
                                ),
                                onPressed: () {
                                  user.role = "chef";
                                  changeRole(user, "chef");
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  "Admin",
                                  style: TextStyle(
                                      fontSize: 20, color: Palette.orange),
                                ),
                                onPressed: () {
                                  user.role = "admin";
                                  changeRole(user, "admin");
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ));
                }),
            FocusedMenuItem(
              backgroundColor: Palette.orange,
              title: const Text(
                "Delete",
                style: TextStyle(fontSize: 20, color: Palette.white),
              ),
              trailingIcon: const Icon(
                Icons.delete_forever_outlined,
                color: Palette.white,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text(
                            "Warning!",
                            style:
                                TextStyle(fontSize: 30, color: Palette.orange),
                          ),
                          content: const Text(
                            "User will be permanently Deleted.\nAre you sure you want to delete it?",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 20, color: Palette.orange),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: const Text(
                                "Delete",
                                style: TextStyle(
                                    fontSize: 20, color: Palette.orange),
                              ),
                              onPressed: () {
                                deleteuser(user);
                                Fluttertoast.showToast(
                                    msg: "Successfully Deleted",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Palette.orange,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ));
              },
            ),
          ],
          onPressed: () {},
          child: Card(
            child: ListTile(
              onTap: () {},
              isThreeLine: true,
              title: Text(
                user.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                user.email,
                overflow: TextOverflow.fade,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                user.role,
                style: const TextStyle(
                  color: Palette.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.orange,
        title: const Text(
          "Manage Accounts",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Users List",
                  style: TextStyle(
                    color: Palette.orange,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          StreamBuilder<List<Usermodal>>(
              stream: readUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('OOps! Something went wrong ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return Expanded(
                    child: ListView(
                      children: user.map(buildUsers).toList(),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const AddUser())));
              },
              child: const Icon(
                Icons.add_outlined,
                size: 50,
              ),
              backgroundColor: Palette.orange,
            ),
          )
        ],
      ),
    );
  }

  Future<void> deleteuser(Usermodal user) async {
    {
      FirebaseFirestore.instance.collection("Users").doc(user.email).delete();
    }
  }

  void changeRole(Usermodal user, String role) {
    if (user.email == FirebaseAuth.instance.currentUser!.email) {
      Fluttertoast.showToast(
          msg: "Cannot Change Own Role",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Palette.orange,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(user.email)
          .update({'role': user.role});
    }
  }
}
