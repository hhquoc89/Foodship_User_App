import 'package:flutter/foundation.dart';

class TotalAmount extends ChangeNotifier {
  double _totalAmount = 0;

  double get tAmount => _totalAmount;

  displayTotalAmount(double value) async {
    _totalAmount = value;

    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
