import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:foodiesapp/Categories.dart';
import 'package:foodiesapp/addCategory.dart';
import 'package:foodiesapp/manageItems.dart';
import 'package:foodiesapp/palette.dart';

class manage_category extends StatefulWidget {
  const manage_category({Key? key}) : super(key: key);

  @override
  State<manage_category> createState() => _manage_categoryState();
}

Future<void> deleteCategory(Category category) async {
  {
    var desertRef = FirebaseStorage.instance.refFromURL(category.image);
    await desertRef.delete();
  }

  {
    var collection = FirebaseFirestore.instance.collection(category.name);
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  {
    var collection = FirebaseFirestore.instance
        .collection("Category")
        .where('name', isEqualTo: category.name);
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}

class _manage_categoryState extends State<manage_category> {
  Stream<List<Category>> readCategory(category) => FirebaseFirestore.instance
      .collection(category)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList());

  Widget buildcategory(Category category) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 10,
        child: FocusedMenuHolder(
          onPressed: () {},
          menuItems: [
            // FocusedMenuItem(
            //     title: const Text(
            //       "Edit",
            //       style: TextStyle(fontSize: 20),
            //     ),
            //     trailingIcon: const Icon(Icons.edit),
            //     onPressed: () {}),
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
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          "Warning!",
                          style: TextStyle(fontSize: 30, color: Palette.orange),
                        ),
                        content: const Text(
                          "Category will be deleted with all its items.\nAre you sure you want to delete it?",
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
                              deleteCategory(category);
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
                      ),
                    );
                  });
                }),
          ],
          child: GestureDetector(
            onTap: () {
              setcategoryname(category.name);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const ManageItems())));
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          image: NetworkImage(category.image),
                          fit: BoxFit.cover)),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Palette.orange.withOpacity(0.5),
                        Palette.darkGrey.withOpacity(0.5),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      category.name,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Palette.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Categories",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Palette.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: const Text(
              "Categories",
              style: TextStyle(fontSize: 50, color: Palette.orange),
            ),
          ),
          StreamBuilder<List<Category>>(
              stream: readCategory("Category"),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('OOps! Something went wrong ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final category = snapshot.data!;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: category.map(buildcategory).toList(),
                      ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AddCategory())));
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
}
