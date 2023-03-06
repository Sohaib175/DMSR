import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodiesapp/Item.dart';
import 'package:foodiesapp/Order.dart';
import 'package:foodiesapp/Table.dart';
import 'package:foodiesapp/palette.dart';

class order extends StatefulWidget {
  const order({Key? key}) : super(key: key);

  @override
  State<order> createState() => _orderState();
}

List<Item> orderitems = [];

void addorder(Item incomingItem) {
  orderitems.add(incomingItem);
}

class _orderState extends State<order> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Stream<List<Order>> readOrder() => FirebaseFirestore.instance
        .collection("Orders")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());

    Widget buildOrder(Order order) => (order.id == Tableinfo.orderid)
        ? Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Text(
                      "Table Number : " + order.table.toString(),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Text(
                      "Order Id : " + order.id,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Text(
                      "Total Amount : " + order.total.toString(),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Text(
                      "Status  : " + order.status,
                      style: const TextStyle(
                        color: Palette.orange,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.orange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Order Tracking",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Palette.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<Order>>(
              stream: readOrder(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('OOps! Something went wrong ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final Order = snapshot.data!;
                  return Expanded(
                    child: ListView(
                      children: Order.map(buildOrder).toList(),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
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
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "CheckOut ",
                    style: TextStyle(fontSize: 30),
                  ),
                  Icon(
                    Icons.payment_rounded,
                    size: 35,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
