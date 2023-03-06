import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodiesapp/Cart.dart';
import 'package:foodiesapp/about.dart';
import 'package:foodiesapp/instruction.dart';
import 'package:foodiesapp/odertrack.dart';
import 'package:foodiesapp/palette.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Item.dart';

class MenuMainScreen extends StatefulWidget {
  const MenuMainScreen({Key? key}) : super(key: key);

  @override
  State<MenuMainScreen> createState() => _MenuMainScreenState();
}

//final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

String currentListname = "";

int getCategoryLength() {
  int size = 0;
  FirebaseFirestore.instance.collection("Category").get().then((snap) => {
        size = snap.size,
      });

  return size;
}

setcurrentList(String name) {
  currentListname = name;
}

class _MenuMainScreenState extends State<MenuMainScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Stream<List<Item>> readItems(category) => FirebaseFirestore.instance
        .collection(category)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

    Future decrementqty(item, StateSetter updateState) async {
      updateState(() {
        item.quantity--;
      });
    }

    Future incrementqty(item, StateSetter updateState) async {
      updateState(() {
        item.quantity++;
      });
    }

    Widget buildSheet(item, context, state) => SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.25,
                child: Image(
                  image: NetworkImage(
                    item.imageURL,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.price.toString() + " Pkr",
                      style: const TextStyle(
                        color: Palette.orange,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        item.disc,
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                child: GestureDetector(
                  onTap: (() {
                    setState(() {
                      copyitem(item);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const instruction()),
                      );
                    });
                  }),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.note_add_outlined,
                        color: Palette.orange,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Add special instrctions. (e.g No Mayo)",
                        style: TextStyle(fontSize: 20, color: Palette.orange),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Palette.orange,
                          ),
                          onPressed: () {
                            if (item.quantity > 0) {
                              decrementqty(item, state);
                            } else {
                              setState(() {
                                Fluttertoast.showToast(
                                    msg: "Quantity Cannot be Negative",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Palette.orange,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              });
                            }
                          },
                        ),
                        Text(
                          item.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Palette.orange,
                          ),
                          onPressed: () {
                            incrementqty(item, state);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      width: screenWidth * 0.4,
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
                          if (item.quantity == 0) {
                            setState(() {
                              Fluttertoast.showToast(
                                  msg: "Atleast 1 item should be added",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Palette.orange,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          } else {
                            setState(() {
                              addtocart(item);
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Item Added to Cart",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Palette.orange,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: screenHeight * 0.03,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );

    // Future<String> _getImage(String filePath) async {
    //   final ref = FirebaseStorage.instance.ref().child(filePath);
    //   var url = await ref.getDownloadURL().toString();

    //   return url;
    // }

    Widget buildItems(Item item) => (item.isAvailable)
        ? Card(
            child: ListTile(
              onTap: () {
                item.quantity = 0;
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, state) {
                        return buildSheet(item, context, state);
                      });
                    });
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
          )
        : SizedBox();

    return Scaffold(
      //key: _scaffoldKey,
      // drawer: Drawer(
      //   child: Container(
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //           begin: Alignment.topRight,
      //           end: Alignment.bottomLeft,
      //           colors: [
      //             Palette.orange,
      //             Palette.darkGrey,
      //           ]),
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.only(left: 20, right: 20),
      //       child: Column(
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.only(top: 50, bottom: 20),
      //             child: Container(
      //               height: screenHeight * 0.06,
      //               decoration: const BoxDecoration(
      //                 image: DecorationImage(
      //                   image: AssetImage('assets/logo.png'),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           const Divider(
      //             thickness: 1,
      //             color: Palette.lightGrey,
      //             indent: 20,
      //             endIndent: 20,
      //           ),
      //           const SizedBox(
      //             height: 50,
      //           ),
      //           ListTile(
      //             leading: const Icon(
      //               Icons.feedback_outlined,
      //               color: Palette.white,
      //             ),
      //             title: const Text(
      //               "Feedbacks",
      //               style: TextStyle(fontSize: 26, color: Palette.white),
      //             ),
      //             onTap: () {},
      //           ),
      //           const SizedBox(
      //             height: 10,
      //           ),
      //           const Divider(
      //             thickness: 1,
      //             color: Palette.lightGrey,
      //             indent: 10,
      //             endIndent: 100,
      //           ),
      //           const SizedBox(
      //             height: 10,
      //           ),
      //           ListTile(
      //             leading: const Icon(
      //               Icons.payment_outlined,
      //               color: Palette.white,
      //             ),
      //             title: const Text(
      //               "Payments",
      //               style: TextStyle(fontSize: 26, color: Palette.white),
      //             ),
      //             onTap: () {},
      //           ),
      //           const Divider(
      //             thickness: 1,
      //             color: Palette.lightGrey,
      //             indent: 10,
      //             endIndent: 100,
      //           ),
      //           const SizedBox(
      //             height: 10,
      //           ),
      //           ListTile(
      //             leading: const Icon(
      //               Icons.track_changes_outlined,
      //               color: Palette.white,
      //             ),
      //             title: const Text(
      //               "Track Order",
      //               style: TextStyle(fontSize: 26, color: Palette.white),
      //             ),
      //             onTap: () {
      //               Navigator.push(context,
      //                   MaterialPageRoute(builder: (context) => const order()));
      //             },
      //           ),
      //           const SizedBox(
      //             height: 10,
      //           ),
      //           const Divider(
      //             thickness: 1,
      //             color: Palette.lightGrey,
      //             indent: 10,
      //             endIndent: 100,
      //           ),
      //           const SizedBox(
      //             height: 10,
      //           ),
      //           ListTile(
      //             leading: const Icon(
      //               Icons.info_outline,
      //               color: Palette.white,
      //             ),
      //             title: const Text(
      //               "About",
      //               style: TextStyle(fontSize: 26, color: Palette.white),
      //             ),
      //             onTap: () {
      //               Navigator.push(context,
      //                   MaterialPageRoute(builder: (context) => const about()));
      //             },
      //           ),
      //           const Divider(
      //             thickness: 1,
      //             color: Palette.lightGrey,
      //             indent: 10,
      //             endIndent: 100,
      //           ),
      //           const SizedBox(
      //             height: 10,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              forceElevated: true,
              toolbarHeight: screenHeight * 0.1,
              leadingWidth: screenWidth,
              backgroundColor: Colors.white,
              floating: true,
              pinned: true,
              expandedHeight: screenHeight * 0.32,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Image(
                  height: screenHeight * 0.05,
                  image: const AssetImage(
                    'assets/logo_orange.png',
                  ),
                ),
                background: Stack(
                  children: [
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.25,
                      child: const Image(
                        image: AssetImage('assets/login_BG.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.25,
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
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
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
                    currentListname,
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
                stream: readItems(currentListname),
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
          ],
        ),
      ),
    );
  }
}
