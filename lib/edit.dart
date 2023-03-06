import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodiesapp/Cart.dart';
import 'package:foodiesapp/Item.dart';
import 'package:foodiesapp/palette.dart';

class edit extends StatefulWidget {
  const edit({Key? key}) : super(key: key);

  @override
  State<edit> createState() => _editState();
}

final instructController = TextEditingController();
Item item = Item(
    quantity: 0,
    name: "",
    disc: "",
    price: 0,
    imageName: "",
    imageURL: "",
    instruction: "",
    isAvailable: true);

void copyedititem(@required Item incomingItem) {
  item = incomingItem;
  instructController.text = incomingItem.instruction;
}

class _editState extends State<edit> {
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
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    item.disc,
                    style: const TextStyle(fontSize: 20),
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
                    decoration: InputDecoration(
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
                      labelText: "Instruction",
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
                        update(item);
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
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Update',
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
