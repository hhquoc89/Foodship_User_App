import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/mainScreens/cart_screen.dart';
import 'package:foodship_user_app/respository/cart_Item_counter.dart';
import 'package:foodship_user_app/widgets/error_dialog.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  final String? sellerUID;
  MyAppBar({this.bottom, this.sellerUID});

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  List<String>? cart = sharedPreferences!.getStringList('userCart');

  @override
  Widget build(BuildContext context) {
    print(cart);
    return AppBar(
      flexibleSpace: Container(
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
      ),
      title: Text(
        sharedPreferences!.getString("name")!,
        style: const TextStyle(fontFamily: 'Signatra', fontSize: 30),
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
      actions: [
        Center(
          child: Stack(
            children: [
              IconButton(
                  onPressed: cart != []
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CartScreen(sellerUID: widget.sellerUID),
                              ));
                        }
                      : () {
                          showDialog(
                              context: context,
                              builder: (c) {
                                return ErrorDialog(
                                  message: "Vui lòng chọn món",
                                );
                              });
                        },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.greenAccent,
                  )),
              Positioned(
                  right: 4,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.brightness_1,
                        size: 20,
                        color: Colors.green,
                      ),
                      Center(
                        child: Consumer<CartItemCounter>(
                            builder: (context, counter, c) {
                          return Text(
                            counter.count.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          );
                        }),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
