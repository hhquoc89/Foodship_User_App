import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:foodship_user_app/global/global.dart';

import 'package:foodship_user_app/model/menu.dart';
import 'package:foodship_user_app/model/seller.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        drawer: const MyDrawer(),
        body: CustomScrollView(slivers: [
          SliverPersistentHeader(
            delegate:
                TextWidgetHeader(title: widget.model!.sellerName! + ' Menus'),
            pinned: true,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('sellers')
                .doc(widget.model!.sellerUID)
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
        ]));
  }
}