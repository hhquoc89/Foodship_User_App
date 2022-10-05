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
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            sharedPreferences!.getString('photoUrl')!)),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                },
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: Text(
                  'Get Order Now',
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
                  'Search',
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
                  'Pending Order',
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
                        builder: (context) => DoneOrdersScreen(),
                      ));
                },
                leading: const Icon(
                  Icons.shopping_basket,
                  color: Colors.black,
                ),
                title: const Text(
                  'Done Order',
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
                  'History',
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
                        builder: (context) => SaveAddressScreen(),
                      ));
                },
                leading: const Icon(
                  Icons.add_location_alt_rounded,
                  color: Colors.black,
                ),
                title: const Text(
                  //add address
                  'Add Table',
                  style: const TextStyle(color: Colors.black),
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
                    'Sign Out',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then((value) {
                      Navigator.push(
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
