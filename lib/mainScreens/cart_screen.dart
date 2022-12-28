import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:foodship_user_app/mainScreens/address_screen.dart';
import 'package:foodship_user_app/model/items.dart';
import 'package:foodship_user_app/respository/assitant_method.dart';
import 'package:foodship_user_app/respository/cart_Item_counter.dart';

import 'package:foodship_user_app/respository/total_amount.dart';

import 'package:foodship_user_app/widgets/card_item_cart.dart';
import 'package:foodship_user_app/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final String? sellerUID;
  CartScreen({Key? key, this.sellerUID}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? separateItemQuantityList;
  num totalAmount = 0;

  @override
  void initState() {
    separateItemQuantityList = separateItemQuantities();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0);
    super.initState();
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
          'Trang thanh toán',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Text('Danh sách các món ăn ', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          // Container(
          //   height: 420,
          //   padding: EdgeInsets.all(8),
          //   decoration: BoxDecoration(
          //     shape: BoxShape.rectangle,
          //     border: Border.all(width: 2.0, color: Colors.grey),
          //     borderRadius: const BorderRadius.all(Radius.circular(5)),
          //   ),
          //   child: StreamBuilder<QuerySnapshot>(
          //       stream: FirebaseFirestore.instance
          //           .collection('items')
          //           .where("itemID", whereIn: separateItemIDs())
          //           .orderBy('publishedDate', descending: true)
          //           .snapshots(),
          //       builder: (context, snapshot) {
          //         return !snapshot.hasData
          //             ? Center(child: circularProgress())
          //             : snapshot.data!.docs == 0
          //                 ? Container()
          //                 : ListView.separated(
          //                     shrinkWrap: true,
          //                     itemBuilder: ((context, index) {
          //                       Items model = Items.fromJson(
          //                           snapshot.data!.docs[index].data()!
          //                               as Map<String, dynamic>);
          //                       if (index == 0) {
          //                         totalAmount = 0;
          //                         totalAmount = totalAmount +
          //                             (model.price! *
          //                                 separateItemQuantityList![index]);
          //                       } else {
          //                         totalAmount = totalAmount +
          //                             (model.price! *
          //                                 separateItemQuantityList![index]);
          //                       }
          //                       if (snapshot.data!.docs.length - 1 == index) {
          //                         WidgetsBinding.instance
          //                             .addPostFrameCallback((timeStamp) {
          //                           Provider.of<TotalAmount>(context,
          //                                   listen: false)
          //                               .displayTotalAmount(
          //                                   totalAmount.toDouble());
          //                         });
          //                       }
          //                       return CardItemCart(
          //                         model: model,
          //                         context: context,
          //                         quanNumber: separateItemQuantityList![index],
          //                       );
          //                     }),
          //                     itemCount: snapshot.hasData
          //                         ? snapshot.data!.docs.length
          //                         : 0,
          //                     separatorBuilder: ((context, index) =>
          //                         const SizedBox(
          //                           height: 10,
          //                         )),
          //                   );
          //       }),
          // ),
          const SizedBox(
            height: 10,
          ),
          Consumer2<TotalAmount, CartItemCounter>(
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
                    : Text(amountProvider.tAmount.toString(),
                        style: TextStyle(fontSize: 20))
              ],
            );
          }),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton.extended(
            heroTag: 'btn1',
            onPressed: () {
              clearCart(context);
              setState(() {});
            },
            label: (const Text('Clear cart', style: TextStyle(fontSize: 16))),
            backgroundColor: Colors.cyan,
            icon: const Icon((Icons.clear_all)),
          ),
          Consumer2<TotalAmount, CartItemCounter>(
            builder: (context, amountProvider, cartProvider, c) {
              return FloatingActionButton.extended(
                heroTag: 'btn2',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => AddressScreen(
                        totalAmount: totalAmount.toDouble(),
                        sellerUID: widget.sellerUID,
                      ),
                    ),
                  );
                },
                label:
                    (const Text('Check out', style: TextStyle(fontSize: 16))),
                backgroundColor: Colors.cyan,
                icon: const Icon((Icons.navigate_next)),
              );
            },
          )
        ],
      ),
    );
  }
}
