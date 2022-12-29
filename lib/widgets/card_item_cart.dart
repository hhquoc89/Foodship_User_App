import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/mainScreens/item_detail_screen.dart';
import 'package:foodship_user_app/mainScreens/menus_screen.dart';
import 'package:foodship_user_app/model/cart.dart';
import 'package:foodship_user_app/model/items.dart';
import 'package:foodship_user_app/respository/assitant_method.dart';
import 'package:foodship_user_app/widgets/loading_dialog.dart';

class CardItemCart extends StatefulWidget {
  final dynamic? model;
  BuildContext? context;
  final Function? refresh;
  CardItemCart({
    Key? key,
    this.model,
    this.context,
    this.refresh,
  }) : super(key: key);

  @override
  State<CardItemCart> createState() => _CardItemCartState();
}

class _CardItemCartState extends State<CardItemCart> {
  @override
  Widget build(BuildContext context) {
    final itemID = widget.model['itemID'];
    final qty = widget.model['qty'];
    final title = widget.model!['title'];
    final price = widget.model!['price'];

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: (() {
                // showBottomSheet(
                //     context: context,
                //     builder: (c) {
                //       return Text('sadsadsa');
                //     });
                // print(widget.model['itemID']);
                // StreamBuilder<DocumentSnapshot>(
                //   stream: FirebaseFirestore.instance
                //       .collection('items')
                //       .doc(widget.model['itemID'])
                //       .snapshots(),
                //   builder: (BuildContext context,
                //       AsyncSnapshot<DocumentSnapshot> snapshot) {
                //     if (snapshot.hasError) {
                //       return Text("Something went wrong");
                //     }

                //     if (snapshot.hasData && !snapshot.data!.exists) {
                //       return Text("Document does not exist");
                //     }

                //     if (snapshot.connectionState == ConnectionState.done) {
                //       Items model = Items.fromJson(
                //           snapshot.data!.data()! as Map<String, dynamic>);
                //       showBottomSheet(
                //           context: context,
                //           builder: (c) {
                //             return ItemDetailsScreen(
                //               model: model,
                //             );
                //           });
                //     }

                //     return Text("loading");
                //   },
                // );
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 9,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text('${qty}x',
                              style: const TextStyle(fontSize: 15)),
                        ),
                        Flexible(
                          flex: 6,
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text('${oCcy.format(price)}đ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        List<String>? cart =
                            sharedPreferences!.getStringList('userCart');
                        cart!.length == 1
                            ? clearCart(context)
                            : deleteItemInCart(itemID, price, qty, title,
                                context, widget.refresh!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red)),
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 13,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
