import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:foodship_user_app/global/global.dart';

import 'package:foodship_user_app/model/menu.dart';
import 'package:foodship_user_app/model/seller.dart';
import 'package:foodship_user_app/respository/address_changer.dart';
import 'package:foodship_user_app/respository/assitant_method.dart';
import 'package:foodship_user_app/respository/push_notification.dart';
import 'package:foodship_user_app/widgets/appbar.dart';
import 'package:foodship_user_app/widgets/menus_design.dart';

import 'package:foodship_user_app/widgets/my_drawer.dart';

import 'package:foodship_user_app/widgets/text_widget_header.dart';

import '../widgets/progress_bar.dart';

class MenusScreen extends StatefulWidget {
  final Sellers? model;
  MenusScreen({Key? key, this.model}) : super(key: key);

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  final PushNotificationService _pushNotificationService =
      PushNotificationService();

  @override
  void initState() {
    // TODO: implement initState
    clearCart(context);
    _pushNotificationService.requestPermission();
    _pushNotificationService.getToken();
    _pushNotificationService.initInfo();
    initAllAddressTableForUser(sharedPreferences!.getString('uid')!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(sharedPreferences!.getStringList('userCart'));
    return Scaffold(
      appBar: MyAppBar(),
      drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: TextWidgetHeader(title: ' Menu'),
            pinned: true,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('sellers')
                .doc('6E1ZnU332vgoqBTTy2KDoBZzWKT2')
                .collection('menus')
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: GridView.custom(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 4, //3
                          pattern: const [
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2), //1,3
                          ],
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Menus model = Menus.fromJson(
                                snapshot.data!.docs[index].data()!
                                    as Map<String, dynamic>);
                            // design display sellers
                            return MenusDesignWidget(
                              model: model,
                              context: context,
                            );
                          },
                          childCount: snapshot.data!.docs.length,
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
