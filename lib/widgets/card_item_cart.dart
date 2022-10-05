import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/model/items.dart';

class CardItemCart extends StatefulWidget {
  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  CardItemCart({
    Key? key,
    this.model,
    this.context,
    this.quanNumber,
  }) : super(key: key);

  @override
  State<CardItemCart> createState() => _CardItemCartState();
}

class _CardItemCartState extends State<CardItemCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(width: 2.0, color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seller : ${sharedPreferences!.getString("name")!}',
            style: const TextStyle(fontFamily: 'Signatra', fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey,
            height: 0.8,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 350,
            child: Row(
              children: [
                Image.network(
                  widget.model!.thumbnailUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 240,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            strutStyle: StrutStyle(fontSize: 12.0),
                            text: TextSpan(
                                text: widget.model!.title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 24,
                                )),
                          ),
                        ),
                      ]),
                      Text('Price: ${widget.model!.price!} đ',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Roboto',
                            fontSize: 16,
                          )),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // InkWell(
                            //   onTap: () {},
                            //   child: Container(
                            //     decoration: const BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       color: Colors.grey,
                            //     ),
                            //     width: 20,
                            //     height: 20,
                            //     child: const Center(
                            //       child: Icon(
                            //         Icons.remove,
                            //         size: 15.0,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('X',
                                style: TextStyle(
                                    fontFamily: 'Signatra', fontSize: 28)),
                            Text(widget.quanNumber.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Signatra', fontSize: 28)),

                            // InkWell(
                            //   onTap: () {},
                            //   child: Container(
                            //     decoration: const BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       color: Colors.grey,
                            //     ),
                            //     width: 20,
                            //     height: 20,
                            //     child: const Center(
                            //       child: Icon(
                            //         Icons.add,
                            //         size: 15.0,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              'Sub-total: ${widget.model!.price! * widget.quanNumber!} đ',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Roboto',
                                fontSize: 16,
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
