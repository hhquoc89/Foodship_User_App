import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/model/order.dart';
import 'package:foodship_user_app/respository/assitant_method.dart';

import 'package:foodship_user_app/widgets/order_card.dart';
import 'package:foodship_user_app/widgets/progress_bar.dart';
import 'package:foodship_user_app/widgets/simple_appbar.dart';

class DoneOrdersScreen extends StatefulWidget {
  @override
  _DoneOrdersScreenState createState() => _DoneOrdersScreenState();
}

class _DoneOrdersScreenState extends State<DoneOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppBar(
          title: "Lịch sử",
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(sharedPreferences!.getString("uid"))
              .collection("orders")
              .where("status", isEqualTo: "ended")
              .orderBy("orderTime", descending: true)
              .snapshots(),
          builder: (c, snapshot) {
            return snapshot.hasData
                ? ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (c, index) {
                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("users")
                            .doc(sharedPreferences!.getString("uid"))
                            .collection("orders")
                            .get(),
                        builder: (c, snap) {
                          Map<String, dynamic> data = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          final orders = Orders.fromJson(data);
                          return snap.hasData
                              ? OrderCardNew(
                                  orders: orders,
                                )
                              : Center(child: circularProgress());
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 10,
                    ),
                  )
                : Center(
                    child: circularProgress(),
                  );
          },
        ),
      ),
    );
  }
}
