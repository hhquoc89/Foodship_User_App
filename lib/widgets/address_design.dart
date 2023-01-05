import 'package:flutter/material.dart';
import 'package:foodship_user_app/mainScreens/place_order_screen.dart';
import 'package:foodship_user_app/model/address.dart';
import 'package:foodship_user_app/respository/address_changer.dart';

import 'package:provider/provider.dart';

class AddressDesign extends StatefulWidget {
  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;

  AddressDesign({
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
  });

  @override
  _AddressDesignState createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //select this address
        Provider.of<AddressChanger>(context, listen: false)
            .displayResult(widget.value);
      },
      child: Card(
        color: Colors.cyan.withOpacity(0.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //address info

            Radio(
              groupValue: widget.currentIndex!,
              value: widget.value!,
              activeColor: Colors.amber,
              onChanged: (val) {
                //provider
                Provider.of<AddressChanger>(context, listen: false)
                    .displayResult(val);
              },
            ),
            const Icon(
              Icons.table_bar,
              size: 25,
            ),
            Text(
              widget.model!.name!,
              style: const TextStyle(fontSize: 20),
            ),
            widget.value == Provider.of<AddressChanger>(context).count
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {
                      final String? tableName = widget.model!.name;
                      print(tableName);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => PlacedOrderScreen(
                                    addressName: tableName,
                                    addressID: widget.addressID,
                                    totalAmount: widget.totalAmount,
                                    sellerUID: widget.sellerUID,
                                  )));
                    },
                    child: const Text("Chọn bàn này"),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
