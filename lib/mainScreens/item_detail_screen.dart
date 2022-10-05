import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  num total = 0;
  @override
  void initState() {
    num total = widget.model!.price!;
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
    return Scaffold(
      appBar: MyAppBar(
        sellerUID: widget.model!.sellerUID,
      ),
      body: ListView(
        children: [
          Image.network(
            widget.model!.thumbnailUrl.toString(),
            height: 400,
            fit: BoxFit.cover,
          ),
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
                total = number * widget.model!.price!;
                setState(() {});
              },
              onDecrement: (number) {
                total = number * widget.model!.price!;
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.price!.toString() + " VND",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: InkWell(
              onTap: () {
                int itemCouter = int.parse(counterTextEditingController.text);
                List<String> separateItemIDList = separateItemIDs();
                separateItemIDList.contains(widget.model!.itemID)
                    ? Fluttertoast.showToast(msg: 'Item is already in Cart!')
                    : addItemToCart(widget.model!.itemID, context, itemCouter);
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
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      text: 'Add to cart',
                      children: <TextSpan>[
                        const TextSpan(
                          text: ' \u2022 ',
                        ),
                        TextSpan(
                          text: total.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                        const TextSpan(
                          text: ' VND ',
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
    );
  }
}
