import 'package:flutter/material.dart';
import 'package:foodship_user_app/global/global.dart';
import 'package:foodship_user_app/mainScreens/item_detail_screen.dart';

import 'package:foodship_user_app/model/items.dart';
import 'package:foodship_user_app/widgets/progress_bar.dart';

class ItemsDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});
  @override
  State<ItemsDesignWidget> createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    String status = widget.model!.status!;
    num price = widget.model!.price!;
    return InkWell(
      onTap: () {
        showBottomSheet(
            context: context,
            builder: (c) {
              return ItemDetailsScreen(
                model: widget.model,
              );
            });
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Divider(
              height: 4,
              thickness: 3,
              color: Colors.grey[300],
            ),
            SizedBox(height: 10),
            Image.network(
              widget.model!.thumbnailUrl!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                    width: 100, height: 100, child: circularProgress());
              },
            ),
            const SizedBox(
              height: 1.0,
            ),
            Text(
              widget.model!.title!,
              style: const TextStyle(
                color: Colors.cyan,
                fontSize: 20,
              ),
            ),
            status == 'available'
                ? const Text(
                    'Còn món',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  )
                : const Text(
                    'Hết món',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 20,
                    ),
                  ),
            Text(
              '${oCcy.format(price)}đ',
              style: const TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
