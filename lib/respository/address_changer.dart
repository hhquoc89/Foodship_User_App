import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodship_user_app/model/address.dart';
import 'package:foodship_user_app/model/table.dart';

class AddressChanger extends ChangeNotifier {
  int _counter = 0;
  int get count => _counter;

  displayResult(dynamic newValue) {
    _counter = newValue;
    notifyListeners();
  }
}

initAllAddressTableForUser(String userID) async {
  String nameTable = '';
  final model = Address(
    name: nameTable,
    state: '',
    fullAddress: '',
    phoneNumber: '',
    flatNumber: '',
    city: '',
    lat: 0.0,
    lng: 0.0,
  ).toJson();
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('tables');

  QuerySnapshot querySnapshot = await collectionRef.get();

  final List<dynamic> allData =
      querySnapshot.docs.map((doc) => doc.data()).toList();

  final List<TableModel> tables = [];
  for (final e in allData) {
    tables.add(TableModel.fromJson(e));
  }
  for (int i = 0; i < tables.length; i++) {
    nameTable = tables[i].tableName!;
    final model = Address(
      name: nameTable,
      state: '',
      fullAddress: '',
      phoneNumber: '',
      flatNumber: '',
      city: '',
      lat: 0.0,
      lng: 0.0,
    ).toJson();

    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection("userAddress")
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .update(model);
  }
}
