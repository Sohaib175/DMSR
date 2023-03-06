import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodiesapp/palette.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  File? image;
  String DownloadURL = "";
  final categoryController = TextEditingController();

  Future PickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      final ImageTemporary = File(image.path);
      this.image = ImageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Category",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Palette.orange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image != null
              ? SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.file(
                    image!,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  "assets/default.png",
                  height: 200,
                  width: 200,
                ),
          const SizedBox(
            height: 50,
          ),
          TextButton(
            onPressed: () => PickImage(),
            child: const Text(
              "Pick Display Image",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
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
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: "Category Name"),
                style: TextStyle(
                  fontSize: 40.0,
                  height: 1.0,
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              if (categoryController.text == "") {
                Fluttertoast.showToast(
                    msg: "No Name Entered",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Palette.orange,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (image == null) {
                Fluttertoast.showToast(
                    msg: "No Image Selected",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Palette.orange,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                uploadData();
                Fluttertoast.showToast(
                    msg: "Added new category successfully!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Palette.orange,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              }
            },
            child: SizedBox(
              width: screenWidth * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Upload',
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
    );
  }

  Future uploadData() async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("Categories/" + image!.path.split('/').last);
    await ref.putFile(image!);
    DownloadURL = await ref.getDownloadURL();
    print(DownloadURL);
    FirebaseFirestore.instance
        .collection("Category")
        .doc()
        .set({'name': categoryController.text, 'image': DownloadURL}).onError(
            (e, _) => print("Error writing document: $e"));
  }
}
