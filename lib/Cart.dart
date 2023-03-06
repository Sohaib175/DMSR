import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:foodiesapp/Item.dart';
import 'package:foodiesapp/Table.dart';
import 'package:foodiesapp/edit.dart';
import 'package:foodiesapp/palette.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

List<Item> cartitems = [];

void addtocart(Item incomingItem) {
  bool isPresent = false;
  int num1;
  int num2;

  for (int i = 0; i < cartitems.length; i++) {
    if (cartitems[i].name == incomingItem.name) {
      num1 = cartitems[i].quantity!;
      num2 = incomingItem.quantity!;
      cartitems[i].quantity = num1 + num2;
      isPresent = true;
    }
  }

  if (!isPresent) {
    cartitems.add(incomingItem);
  }
}

int getTotal() {
  var sum = 0;
  for (int i = 0; i < cartitems.length; i++) {
    sum = sum + (cartitems[i].price! * cartitems[i].quantity!);
  }

  return sum;
}

void update(Item updtItem) {
  item = updtItem;
}

class _cartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget buildcartItems(Item item) => FocusedMenuHolder(
          blurBackgroundColor: Palette.black.withOpacity(0.01),
          openWithTap: false,
          onPressed: () {},
          menuItems: [
            FocusedMenuItem(
                title: const Text(
                  "Edit",
                  style: TextStyle(fontSize: 20),
                ),
                trailingIcon: const Icon(Icons.edit),
                onPressed: () {
                  copyedititem(item);
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const edit()));
                  });
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
                  setState(() {
                    cartitems.remove(item);
                    Fluttertoast.showToast(
                        msg: "Item Removed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Palette.orange,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                }),
          ],
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.13,
                        width: (screenWidth * 0.48) - 20,
                        child: Image.network(
                          item.imageURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.1,
                        width: (screenWidth * 0.5) - 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.price.toString() + " Pkr",
                          style: const TextStyle(
                            color: Palette.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quanitity : ' + item.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (item.instruction == "") ...[
                          const Flexible(
                            child: Text(
                              "Instructions : " + "None",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          )
                        ] else ...[
                          Flexible(
                            child: Text(
                              "Instructions : " + item.instruction,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.orange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Cart Items",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Palette.white,
              ),
            ),
            Icon(
              Icons.shopping_cart_outlined,
              size: screenHeight * 0.05,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (cartitems.isEmpty) ...[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No Items in cart!",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Palette.orange),
                    ),
                    Icon(
                      Icons.clear_outlined,
                      size: screenHeight * 0.05,
                      color: Palette.orange,
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: ListView.builder(
                itemCount: cartitems.length,
                itemBuilder: (context, index) =>
                    buildcartItems(cartitems[index]),
              ),
            ),
            Center(
              child: Text(
                "Total Amount : " + getTotal().toString() + " Pkr",
                style: TextStyle(fontSize: 30, color: Palette.orange),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  primary: Colors.white,
                  backgroundColor: Palette.orange,
                ),
                onPressed: () {
                  setState(() {
                    setState(() {
                      Tableinfo.orderid = "Order_" +
                          DateTime.now().millisecondsSinceEpoch.toString();

                      {
                        FirebaseFirestore.instance
                            .collection("Orders")
                            .doc(Tableinfo.orderid)
                            .set({
                          'id': Tableinfo.orderid,
                          'status': "pending",
                          'paymentstatus': "pending",
                          'table': Tableinfo.Table_Number,
                          'total': getTotal(),
                          'isWillingtoPay': false,
                        });
                      }
                      {
                        for (int i = 0; i < cartitems.length; i++) {
                          FirebaseFirestore.instance
                              .collection("Orders")
                              .doc(Tableinfo.orderid)
                              .collection("Items")
                              .doc()
                              .set({
                            'description': cartitems[i].disc,
                            'imageURL': cartitems[i].imageURL,
                            'imageName': cartitems[i].imageName,
                            'instruction': cartitems[i].instruction,
                            'isAvailable': cartitems[i].isAvailable,
                            'name': cartitems[i].name,
                            'price': cartitems[i].price,
                            'quantitiy': cartitems[i].quantity
                          });
                        }
                      }
                      cartitems = [];
                      Fluttertoast.showToast(
                          msg: "Order Confirmed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Palette.orange,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Confirm Order",
                      style: TextStyle(fontSize: 30),
                    ),
                    Icon(
                      Icons.emoji_emotions_outlined,
                      size: 35,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
