import 'package:flutter/material.dart';
import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/mainScreens/cart_screen.dart';
import 'package:foodship_user_app/mainScreens/done_order_screen.dart';
import 'package:foodship_user_app/mainScreens/home_screen.dart';
import 'package:foodship_user_app/mainScreens/menus_screen.dart';
import 'package:foodship_user_app/mainScreens/order_screen.dart';
import 'package:foodship_user_app/mainScreens/save_address.dart';
import 'package:foodship_user_app/mainScreens/search_screen.dart';

import '../authentication/auth_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = sharedPreferences!.getString('photoUrl')!;
    String userName = sharedPreferences!.getString('name')!;
    return Drawer(
      child: ListView(
        children: [
          // header drawer
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(children: [
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(90)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: url != ''
                        ? CircleAvatar(backgroundImage: NetworkImage(url))
                        : CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Center(
                                child: Text(
                              userName[0],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 40),
                            )),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(sharedPreferences!.getString('name')!,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 25, fontFamily: 'Acme')),
            ]),
          ),
          // body drawer
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(children: [
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenusScreen(),
                      ));
                },
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: Text(
                  'Đặt món',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 1,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ));
                },
                leading: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                title: Text(
                  'Tìm kiếm món ăn',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 1,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdersScreen(),
                      ));
                },
                leading: const Icon(
                  Icons.shopping_basket,
                  color: Colors.black,
                ),
                title: const Text(
                  'Đơn hàng',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 1,
              ),
              const ListTile(
                leading: Icon(
                  Icons.access_time,
                  color: Colors.black,
                ),
                title: Text(
                  'Lịch sử đơn hàng',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 1,
              ),
              ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Đăng xuất',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((c) => const AuthScreen())));
                    });
                  }),
              const Divider(
                height: 10,
                color: Colors.grey,
                thickness: 1,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
