import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodship_user_app/model/address.dart';

class InformationDetail extends StatelessWidget {
  final Address? model;
  const InformationDetail({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Name: ${model!.name}'),
        )
      ],
    );
  }
}
