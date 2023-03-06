import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodiesapp/palette.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

String? _role = 'Admin';

class _AddUserState extends State<AddUser> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.orange,
        title: const Text(
          "Add New User",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) =>
                          (value!.isEmpty) ? 'Enter the Name' : null,
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "User Name"),
                      style: const TextStyle(
                        fontSize: 20.0,
                        height: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 75,
                    width: 150,
                    child: DropdownButton<String>(
                      underline: Divider(
                        thickness: 1,
                        height: 1.5,
                        color: Colors.grey[500],
                      ),
                      iconSize: 42,
                      iconEnabledColor: Palette.orange,
                      isExpanded: true,
                      items: <String>['Admin', 'Chef'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style:
                                TextStyle(fontSize: 22, color: Palette.orange),
                          ),
                        );
                      }).toList(),
                      value: _role,
                      //hint: new Text("Select a Role"),
                      onChanged: (value) => setState(() => _role = value),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                validator: (value) =>
                    (value!.isEmpty) ? 'Enter an Email' : null,
                controller: emailController,
                decoration: const InputDecoration(labelText: "User email"),
                style: const TextStyle(
                  fontSize: 20.0,
                  height: 1.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                validator: (value) => (value!.length < 6)
                    ? 'Enter Password with atleast 6 characters'
                    : null,
                controller: passwordController,
                decoration: const InputDecoration(labelText: "User Password"),
                style: const TextStyle(
                  fontSize: 20.0,
                  height: 1.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  uploadData(nameController.text, emailController.text,
                      passwordController.text, _role!);
                  Navigator.pop(context);
                }
              },
              child: SizedBox(
                width: screenWidth * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Upload Info',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.upload_file_outlined,
                      size: screenHeight * 0.03,
                    ),
                  ],
                ),
              ),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                primary: Colors.white,
                backgroundColor: Palette.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadData(
      String Name, String Email, String Password, String role) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    {
      await auth.createUserWithEmailAndPassword(
          email: Email, password: Password);
    }

    {
      await FirebaseFirestore.instance.collection("Users").doc(Email).set({
        'name': Name,
        'email': Email,
        'role': role.toLowerCase()
      }).whenComplete(
        () => Fluttertoast.showToast(
            msg: "Added new User successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Palette.orange,
            textColor: Colors.white,
            fontSize: 16.0),
      );
    }
  }
}
