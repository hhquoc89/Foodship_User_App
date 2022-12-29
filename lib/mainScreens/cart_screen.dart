import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodship_user_app/global/global.dart';

import 'package:foodship_user_app/mainScreens/address_screen.dart';
import 'package:foodship_user_app/model/cart.dart';
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
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(sharedPreferences!.getStringList('userCart'));
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
        actions: [
          InkWell(
            onTap: () => setState(() {}),
            child: Icon(Icons.replay_outlined),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            return CardItemCart(
                              model: cart,
                              context: context,
                              refresh: () {
                                setState(() {});
                              },
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
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton.extended(
                    heroTag: 'btn1',
                    onPressed: () {
                      clearCart(context);
                      setState(() {});
                    },
                    label: (const Text('Xóa đơn hàng ',
                        style: TextStyle(fontSize: 16))),
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
                        label: (const Text('Chọn bàn',
                            style: TextStyle(fontSize: 16))),
                        backgroundColor: Colors.cyan,
                        icon: const Icon((Icons.navigate_next)),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
