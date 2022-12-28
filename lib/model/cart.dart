import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String? itemID;
  int? price;
  int? qty;
  String? status;
  String? title;

  Cart({this.itemID, this.price, this.qty, this.status, this.title});

  Cart.fromJson(Map<String, dynamic> json) {
    itemID = json['itemID'];
    price = json['price'];
    qty = json['qty'];
    status = json['status'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['itemID'] = this.itemID;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['status'] = this.status;
    data['title'] = this.title;
    return data;
  }

  factory Cart.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Cart(
      itemID: data?['itemID'],
      price: data?['price'],
      qty: data?['qty'],
      status: data?['status'],
      title: data?['title'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (itemID != null) "itemID": itemID,
      if (price != null) "price": price,
      if (qty != null) "country": qty,
      if (status != null) "capital": status,
      if (title != null) "population": title,
    };
  }
}
