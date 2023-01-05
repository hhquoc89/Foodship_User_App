import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/mainScreens/home_screen.dart';
import 'package:foodship_user_app/mainScreens/menus_screen.dart';
import 'package:foodship_user_app/respository/assitant_method.dart';
import 'package:foodship_user_app/respository/cart_Item_counter.dart';
import 'package:foodship_user_app/respository/push_notification.dart';
import 'package:foodship_user_app/respository/total_amount.dart';

import 'package:foodship_user_app/widgets/card_item_placed.dart';
import 'package:foodship_user_app/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

class PlacedOrderScreen extends StatefulWidget {
  final String? addressName;
  String? addressID;
  double? totalAmount;
  String? sellerUID;

  PlacedOrderScreen(
      {Key? key,
      this.sellerUID,
      this.totalAmount,
      this.addressID,
      this.addressName})
      : super(key: key);

  @override
  _PlacedOrderScreenState createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {
  final PushNotificationService _pushNotificationService =
      PushNotificationService();
  num totalAmount = 0;

  String orderId = DateTime.now().millisecondsSinceEpoch.toString();
  String orderTime = DateTime.now().toString();
  List<String>? listItemLocal = sharedPreferences!.getStringList('userCart');
  List<String>? newListItemLocal = [];
  List<dynamic> listItemFB = [];

  Map<String, dynamic> itemFB = {
    "itemID": '',
    "price": '',
    "qty": '',
    "title": '',
    "status": 'none',
  };
  String encodedMap = '';
  convertListLocal() {
    for (int i = 0; i < listItemLocal!.length; i++) {
      itemFB = json.decode(listItemLocal![i]);
      listItemFB.add(itemFB);
    }
  }

  sendNoti(String purchaserId) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('shippers')
        .doc(purchaserId)
        .collection('shipperToken')
        .doc('token')
        .get();
    String token = snap['tokenID'];
    DocumentSnapshot snap1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences!.getString('uid'))
        .get();
    String userName = snap1['userName'];
    _pushNotificationService.sendPushMessage(
        token,
        'Có 1 đơn hàng tại ' +
            widget.addressName! +
            ' đặt bởi nhân viên ' +
            userName,
        'Nhà bếp');
  }

  addOrderDetails() {
    convertListLocal();
    writeOrderDetailsForUser({
      "addressName": widget.addressName,
      "addressID": widget.addressID,
      "realEarn": 0,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "ordersList": listItemFB,
      "paymentDetails": "Cash on Delivery",
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": widget.sellerUID,
      "shipperUID": "",
      "status": "normal",
      "orderId": orderId,
    });

    writeOrderDetailsForSeller({
      "addressName": widget.addressName,
      "realEarn": 0,
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "ordersList": listItemFB,
      "paymentDetails": "Cash on Delivery",
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": widget.sellerUID,
      "shipperUID": "",
      "status": "normal",
      "orderId": orderId,
    }).whenComplete(() async {
      sendNoti('w4akVVVYVhWLQg79LGmWgvwSLIJ2');
      clearCart(context);
      setState(() {
        orderId = "";
        Fluttertoast.showToast(msg: "Đã đặt đồ ăn thành công");
      });
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MenusScreen(),
          ));
    });
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  Future writeOrderDetailsForSeller(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.amber,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text(
          'Tổng quan đơn hàng',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tên bàn', style: TextStyle(fontSize: 18)),
                      Text(widget.addressName!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Danh sách các món ăn ',
                      style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 10),
                FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(sharedPreferences!.getString('uid'))
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }
                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Text("Document does not exist");
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        List<dynamic> carts = data['userCart'];

                        return ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            final cart = carts[index];
                            final price = cart['price'];
                            final qty = cart['qty'];

                            if (index == 0) {
                              totalAmount = 0;
                              totalAmount = totalAmount + (price * qty);
                            } else {
                              totalAmount = totalAmount + (price * qty);
                            }

                            if (carts.length - 1 == index) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Provider.of<TotalAmount>(context, listen: false)
                                    .displayTotalAmount(totalAmount.toDouble());
                              });
                            }
                            return CardItemPlaced(
                              model: cart,
                              context: context,
                            );
                          }),
                          itemCount: snapshot.hasData ? carts.length : 0,
                          separatorBuilder: ((context, index) => const SizedBox(
                                height: 10,
                              )),
                        );
                      }
                      return circularProgress();
                    }),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Consumer2<TotalAmount, CartItemCounter>(
                      builder: (context, amountProvider, cartProvider, c) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tổng cộng', style: TextStyle(fontSize: 20)),
                        const SizedBox(
                          width: 10,
                        ),
                        cartProvider.count == 0
                            ? Container()
                            : Text('${oCcy.format(amountProvider.tAmount)}đ',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    );
                  }),
                ),
                Center(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan,
                      ),
                      onPressed: () {
                        addOrderDetails();
                      },
                      icon: Icon(Icons.done),
                      label: const Text("Đặt món ngay")),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
