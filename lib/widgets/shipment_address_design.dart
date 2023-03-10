import 'package:flutter/material.dart';

import 'package:foodship_user_app/model/address.dart';
import 'package:foodship_user_app/splashScreen/splash_screen.dart';

class ShipmentAddressDesign extends StatelessWidget {
  final Address? model;

  ShipmentAddressDesign({this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tên bàn:',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text(model!.name!,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
