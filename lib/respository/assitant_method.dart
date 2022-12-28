import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/model/cart.dart';
import 'package:foodship_user_app/respository/cart_Item_counter.dart';
import 'package:provider/provider.dart';

separateOrderItemIDs(orderIDs) {
  List<String> separateItemIDsList = [], defaultItemList = [];
  int i = 0;

  defaultItemList = List<String>.from(orderIDs);

  for (i; i < defaultItemList.length; i++) {
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    //56557657
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    separateItemIDsList.add(getItemId);
  }

  return separateItemIDsList;
}

separateItemIDs() {
  List<String> separateItemIDsList = [], defaultItemList = [];

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for (int i = 0; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(':');

    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    separateItemIDsList.add(getItemId);
  }
  return separateItemIDsList;
}

addItemToCart(
    String? itemID, int price, int qty, String? title, BuildContext context) {
  List<String>? listItemLocal = sharedPreferences!.getStringList('userCart');
  List<dynamic> listItemFB = [];
  Map<String, dynamic> itemMap = {
    "itemID": itemID,
    "price": price,
    "qty": qty,
    "title": title,
    "status": 'none',
  };
  String encodedMap = json.encode(itemMap);
  listItemLocal!.add(encodedMap);
  for (int i = 0; i < listItemLocal.length; i++) {
    final itemFB = json.decode(listItemLocal[i]);
    listItemFB.add(itemFB);
  }

  FirebaseFirestore.instance
      .collection('users')
      .doc(firebaseAuth.currentUser!.uid)
      .update({
    "userCart": listItemFB,
  }).then((value) {
    Fluttertoast.showToast(msg: 'Đã thêm ' + title!);
    sharedPreferences!.setStringList('userCart', listItemLocal);

    Provider.of<CartItemCounter>(context, listen: false)
        .displayCartListItemsNumber();
  });
}

separateOrderItemQuantities(orderIDs) {
  List<String> separateItemQuantityList = [];
  List<String> defaultItemList = [];
  int i = 1;

  defaultItemList = List<String>.from(orderIDs);

  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();

    List<String> listItemCharacters = item.split(":").toList();

    var quanNumber = int.parse(listItemCharacters[1].toString());

    separateItemQuantityList.add(quanNumber.toString());
  }

  return separateItemQuantityList;
}

clearCart(context) {
  sharedPreferences!.setStringList('userCart', []);
  List<String>? emptyList = sharedPreferences!.getStringList('userCart');

  FirebaseFirestore.instance
      .collection('users')
      .doc(firebaseAuth.currentUser!.uid)
      .update({'userCart': emptyList}).then((value) => {
            sharedPreferences!.setStringList('userCart', emptyList!),
            Provider.of<CartItemCounter>(context, listen: false)
                .displayCartListItemsNumber(),
            Fluttertoast.showToast(msg: "Xóa đơn hàng thành công")
          });
}
