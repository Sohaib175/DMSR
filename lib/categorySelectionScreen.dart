import 'package:flutter/material.dart';
import 'package:foodiesapp/Cart.dart';
import 'package:foodiesapp/Categories.dart';
import 'package:foodiesapp/about.dart';
import 'package:foodiesapp/login.dart';
import 'package:foodiesapp/odertrack.dart';
import 'package:foodiesapp/palette.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'menu_main.dart';

class categoryScreen extends StatefulWidget {
  const categoryScreen({Key? key}) : super(key: key);

  @override
  State<categoryScreen> createState() => _categoryScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _categoryScreenState extends State<categoryScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Stream<List<Category>> readCategory(category) => FirebaseFirestore.instance
        .collection(category)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList());

    Widget buildcategory(Category category) => GestureDetector(
          onTap: () {
            setcurrentList(category.name);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const MenuMainScreen())));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 10,
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
        );

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Palette.orange,
                Palette.darkGrey,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 20),
                  child: Container(
                    height: screenHeight * 0.06,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Palette.lightGrey,
                  indent: 20,
                  endIndent: 20,
                ),
                // const SizedBox(
                //   height: 50,
                // ),
                // ListTile(
                //   leading: const Icon(
                //     Icons.feedback_outlined,
                //     color: Palette.white,
                //   ),
                //   title: const Text(
                //     "Feedbacks",
                //     style: TextStyle(fontSize: 26, color: Palette.white),
                //   ),
                //   onTap: () {},
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // const Divider(
                //   thickness: 1,
                //   color: Palette.lightGrey,
                //   indent: 10,
                //   endIndent: 100,
                // ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.payment_outlined,
                    color: Palette.white,
                  ),
                  title: const Text(
                    "Payments",
                    style: TextStyle(fontSize: 26, color: Palette.white),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  thickness: 1,
                  color: Palette.lightGrey,
                  indent: 10,
                  endIndent: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.track_changes_outlined,
                    color: Palette.white,
                  ),
                  title: const Text(
                    "Track Order",
                    style: TextStyle(fontSize: 26, color: Palette.white),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const order()));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                  color: Palette.lightGrey,
                  indent: 10,
                  endIndent: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info_outline,
                    color: Palette.white,
                  ),
                  title: const Text(
                    "About",
                    style: TextStyle(fontSize: 26, color: Palette.white),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const about()));
                  },
                ),
                const Divider(
                  thickness: 1,
                  color: Palette.lightGrey,
                  indent: 10,
                  endIndent: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info_outline,
                    color: Palette.white,
                  ),
                  title: const Text(
                    "Close Menu",
                    style: TextStyle(fontSize: 26, color: Palette.white),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const login()));
                  },
                ),
                const Divider(
                  thickness: 1,
                  color: Palette.lightGrey,
                  indent: 10,
                  endIndent: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
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
              title: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Palette.white,
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(
                          Icons.menu_outlined,
                          color: Palette.orange,
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Palette.white,
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Palette.orange,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const cart())));
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
            const Padding(
              padding: EdgeInsets.only(
                top: 50,
              ),
              child: Center(
                child: Text(
                  "Select Category",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Palette.orange,
                  ),
                ),
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
          ],
        ),
      ),
    );
  }
}
