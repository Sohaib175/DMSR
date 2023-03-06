import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodiesapp/Cart.dart';
import 'package:foodiesapp/Item.dart';
import 'package:foodiesapp/palette.dart';

class instruction extends StatefulWidget {
  const instruction({Key? key}) : super(key: key);

  @override
  State<instruction> createState() => _instructionState();
}

Item item = Item(
    quantity: 0,
    name: "",
    disc: "",
    price: 0,
    imageName: "",
    imageURL: "",
    instruction: "",
    isAvailable: true);

void copyitem(@required Item incomingItem) {
  item = incomingItem;
}

class _instructionState extends State<instruction> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final instructController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Card(
          elevation: 20,
          child: SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.5,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    item.disc,
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Palette.orange,
                        ),
                        onPressed: () {
                          if (item.quantity! > 0) {
                            setState(() {
                              item.quantity = item.quantity! - 1;
                            });
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
                          setState(() {
                            item.quantity = item.quantity! + 1;
                          });
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: instructController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.orange),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.orange),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      hintText: "Add your Instructions",
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Colors.white,
                      backgroundColor: Palette.orange,
                    ),
                    onPressed: () {
                      setState(() {
                        item.instruction = instructController.text;
                      });

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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
