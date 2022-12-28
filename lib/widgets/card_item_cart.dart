import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/mainScreens/item_detail_screen.dart';
import 'package:foodship_user_app/model/cart.dart';
import 'package:foodship_user_app/model/items.dart';

class CardItemCart extends StatefulWidget {
  final dynamic? model;
  BuildContext? context;

  CardItemCart({
    Key? key,
    this.model,
    this.context,
  }) : super(key: key);

  @override
  State<CardItemCart> createState() => _CardItemCartState();
}

class _CardItemCartState extends State<CardItemCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: (() {
                showBottomSheet(
                    context: context,
                    builder: (c) {
                      return ItemDetailsScreen(
                        model: widget.model['itemID'],
                      );
                    });
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .1,
                          child: Text(widget.model['qty'].toString() + 'x',
                              style: const TextStyle(fontSize: 15)),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Text(widget.model!['title'],
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .2,
                          child: Text(
                              oCcy.format(widget.model!['price']).toString() +
                                  'đ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
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
