import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/model/items.dart';
import 'package:foodship_user_app/respository/assitant_method.dart';
import 'package:foodship_user_app/widgets/appbar.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();
  num total = 1;
  @override
  void initState() {
    counterTextEditingController.addListener(() {});

    super.initState();
  }

  @override
  void dispose() {
    counterTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.model!.thumbnailUrl!;
    num price = widget.model!.price!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
            color: Colors.transparent),
        height: MediaQuery.of(context).size.height * 0.95,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  child: Image.network(
                    url,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: const Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: NumberInputPrefabbed.roundedButtons(
                    separateIcons: false,
                    incIcon: Icons.add,
                    incIconColor: Colors.cyan,
                    incDecBgColor: Colors.transparent,
                    decIcon: Icons.remove,
                    decIconColor: Colors.cyan,
                    controller: counterTextEditingController,
                    min: 1,
                    max: 15,
                    initialValue: 1,
                    buttonArrangement: ButtonArrangement.incRightDecLeft,
                    onIncrement: (number) {
                      setState(() {
                        total = number * price;
                      });
                    },
                    onDecrement: (number) {
                      setState(() {
                        total = number * price;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.model!.title.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.model!.shortInfo!,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    oCcy.format(price).toString() + " VND",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  int itemCouter = int.parse(counterTextEditingController.text);
                  List<String> separateItemIDList = separateItemIDs();
                  separateItemIDList.contains(widget.model!.itemID)
                      ? Fluttertoast.showToast(msg: 'Item is already in Cart!')
                      : addItemToCart(
                          widget.model!.itemID, context, itemCouter);
                },
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.cyan,
                      Colors.amber,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  )),
                  width: MediaQuery.of(context).size.width - 13,
                  height: 50,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                        text: 'Thêm',
                        children: <TextSpan>[
                          const TextSpan(
                            text: ' \u2022 ',
                          ),
                          TextSpan(
                            text: oCcy.format(total).toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          const TextSpan(
                            text: ' VND',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
