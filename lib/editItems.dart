import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodiesapp/Item.dart';
import 'package:foodiesapp/edit.dart';
import 'package:foodiesapp/manageItems.dart';
import 'package:foodiesapp/palette.dart';
import 'package:image_picker/image_picker.dart';

class EditItems extends StatefulWidget {
  const EditItems({Key? key}) : super(key: key);

  @override
  State<EditItems> createState() => _EditItemsState();
}

String imageurl = "";
String DownloadURL = "";
String name = "";
String price = "";
String desc = "";
final itemController = TextEditingController();
final priceController = TextEditingController();
final descriptionController = TextEditingController();

setDetails(Item item) {
  imageurl = item.imageURL;
  name = item.name.toString();
  price = item.price.toString();
  desc = item.disc.toString();
  // itemController.text = name;
  // priceController.text = price;
  // descriptionController.text = desc;
}

class _EditItemsState extends State<EditItems> {
  File? image;

  String DownloadURL = "";
  final itemController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

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
          "Update Item",
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
              : Image.network(
                  imageurl,
                  height: 200,
                  width: 200,
                ),
          const SizedBox(
            height: 30,
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: itemController..text = name,
                    decoration: const InputDecoration(labelText: "Item Name"),
                    style: const TextStyle(
                      fontSize: 20.0,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: priceController..text = price,
                    decoration: const InputDecoration(labelText: "Item Price"),
                    style: const TextStyle(
                      fontSize: 20.0,
                      height: 1.0,
                    ),
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
            child: TextField(
              controller: descriptionController..text = desc,
              decoration: const InputDecoration(labelText: "Item Discription"),
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
              if (image == null && imageurl == "") {
                Fluttertoast.showToast(
                    msg: "No Image Selected",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Palette.orange,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (itemController.text == "") {
                Fluttertoast.showToast(
                    msg: "No Name Entered",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Palette.orange,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (priceController.text == "") {
                Fluttertoast.showToast(
                    msg: "No Price Entered",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Palette.orange,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (descriptionController.text == "") {
                Fluttertoast.showToast(
                    msg: "No Description Entered",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Palette.orange,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                updateData();
                Fluttertoast.showToast(
                    msg: "Updated Item successfully!",
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

  Future<void> updateData() async {
    var collection = FirebaseFirestore.instance
        .collection(categoryname)
        .where('name', isEqualTo: name);
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.update({
        'name': itemController.text,
        'price': int.parse(priceController.text),
        'description': descriptionController.text
      });
    }
  }
}
