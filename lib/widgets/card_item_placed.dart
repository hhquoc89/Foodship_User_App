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

class CardItemPlaced extends StatefulWidget {
  final dynamic? model;
  BuildContext? context;
  final Function? refresh;
  CardItemPlaced({
    Key? key,
    this.model,
    this.context,
    this.refresh,
  }) : super(key: key);

  @override
  State<CardItemPlaced> createState() => _CardItemPlacedState();
}

class _CardItemPlacedState extends State<CardItemPlaced> {
  @override
  Widget build(BuildContext context) {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Center(
                      child:
                          Text('${qty}x', style: const TextStyle(fontSize: 15)),
                    ),
                  ),
                  Flexible(
                    flex: 7,
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
              )),
        ],
      ),
    );
  }
}
