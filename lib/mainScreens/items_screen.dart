import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/model/items.dart';
import 'package:foodship_user_app/model/menu.dart';
import 'package:foodship_user_app/widgets/appbar.dart';
import 'package:foodship_user_app/widgets/items_design.dart';
import 'package:foodship_user_app/widgets/sellers_design.dart';
import 'package:foodship_user_app/widgets/my_drawer.dart';
import 'package:foodship_user_app/widgets/text_widget_header.dart';

import '../widgets/progress_bar.dart';

class ItemsScreen extends StatefulWidget {
  final Menus? model;
  const ItemsScreen({this.model});
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
        drawer: const MyDrawer(),
        body: CustomScrollView(slivers: [
          SliverPersistentHeader(
            delegate:
                TextWidgetHeader(title: widget.model!.menuTitle!.toString()),
            pinned: true,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('sellers')
                .doc(widget.model!.sellerUID)
                .collection('menus')
                .doc(widget.model!.menuID)
                .collection('items')
                .orderBy('publishedDate', descending: true)
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
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 2, //3
                          pattern: const [
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 1), //1,3
                          ],
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Items model = Items.fromJson(
                                snapshot.data!.docs[index].data()!
                                    as Map<String, dynamic>);
                            // design display sellers
                            return ItemsDesignWidget(
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
