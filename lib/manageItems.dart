import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:foodiesapp/Item.dart';
import 'package:foodiesapp/addItems.dart';
import 'package:foodiesapp/editItems.dart';
import 'package:foodiesapp/palette.dart';

class ManageItems extends StatefulWidget {
  const ManageItems({Key? key}) : super(key: key);

  @override
  State<ManageItems> createState() => _ManageItemsState();
}

String categoryname = "";

setcategoryname(String name) {
  categoryname = name;
}

class _ManageItemsState extends State<ManageItems> {
  Stream<List<Item>> readItems(category) => FirebaseFirestore.instance
      .collection(category)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget buildItems(Item item) => FocusedMenuHolder(
          onPressed: () {},
          menuItems: [
            FocusedMenuItem(
              backgroundColor: Palette.white,
              title: const Text(
                "Edit",
                style: TextStyle(fontSize: 20, color: Palette.orange),
              ),
              trailingIcon: const Icon(
                Icons.edit,
                color: Palette.orange,
              ),
              onPressed: () {
                setDetails(item);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditItems()));
              },
            ),
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
                      style: TextStyle(fontSize: 30, color: Palette.orange),
                    ),
                    content: const Text(
                      "Item Will be Deleted From the List.\nAre you sure you want to delete it?",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 20, color: Palette.orange),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text(
                          "Delete",
                          style: TextStyle(fontSize: 20, color: Palette.orange),
                        ),
                        onPressed: () {
                          deleteitem(item);
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
              },
            ),
          ],
          child: Card(
            child: ListTile(
              onTap: () {
                // item.quantity = 0;
                // showModalBottomSheet(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return StatefulBuilder(builder: (context, state) {
                //         return buildSheet(item, context, state);
                //       });
                //     });
              },
              isThreeLine: true,
              leading: Container(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.1,
                  child: Image.network(
                    item.imageURL,
                    fit: BoxFit.cover,
                  )),
              title: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                item.disc,
                overflow: TextOverflow.fade,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                item.price.toString() + " Pkr",
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
        title: const Text(
          "Manage Items",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Palette.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categoryname,
                  style: const TextStyle(
                    color: Palette.orange,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          StreamBuilder<List<Item>>(
              stream: readItems(categoryname),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('OOps! Something went wrong ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final items = snapshot.data!;
                  return Expanded(
                    child: ListView(
                      children: items.map(buildItems).toList(),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: FloatingActionButton(
                onPressed: () {
                  setcategory(categoryname);
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => AddItems())));
                },
                child: const Icon(
                  Icons.add_outlined,
                  size: 50,
                ),
                backgroundColor: Palette.orange,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> deleteitem(Item item) async {
    {
      var desertRef = FirebaseStorage.instance
          .ref()
          .child(categoryname + "/" + item.imageName);
      await desertRef.delete();
    }

    {
      var collection = FirebaseFirestore.instance
          .collection(categoryname)
          .where('name', isEqualTo: item.name);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    }
  }
}
