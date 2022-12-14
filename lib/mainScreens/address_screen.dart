import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/mainScreens/save_address.dart';
import 'package:foodship_user_app/model/address.dart';
import 'package:foodship_user_app/respository/address_changer.dart';
import 'package:foodship_user_app/widgets/address_design.dart';
import 'package:foodship_user_app/widgets/progress_bar.dart';
import 'package:foodship_user_app/widgets/simple_appbar.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  final double? totalAmount;
  final String? sellerUID;

  AddressScreen({this.totalAmount, this.sellerUID});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Chọn bàn ăn",
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   label: const Text("Add New Address"),
      //   backgroundColor: Colors.cyan,
      //   icon: const Icon(
      //     Icons.add_location,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     //save address to user collection
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (c) => SaveAddressScreen()));
      //   },
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Danh sách bàn ăn:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Consumer<AddressChanger>(builder: (context, address, c) {
            return Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(sharedPreferences!.getString("uid"))
                    .collection("userAddress")
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: circularProgress(),
                        )
                      : snapshot.data!.docs.length == 0
                          ? Container()
                          : GridView.builder(
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return AddressDesign(
                                  currentIndex: address.count,
                                  value: index,
                                  addressID: snapshot.data!.docs[index].id,
                                  totalAmount: widget.totalAmount,
                                  sellerUID: widget.sellerUID,
                                  model: Address.fromJson(
                                      snapshot.data!.docs[index].data()!
                                          as Map<String, dynamic>),
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0,
                              ),
                            );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
