import 'dart:math';

import 'package:tiptap_tour/core/utils/currency_formatter.dart';

extension NumberExtensions on double {
  String toCurrency({String currency = 'BDT'}) {
    return CurrencyFormatter.format(this, currency: currency);
  }

  double roundToDecimal(int places) {
    final mod = pow(10, places);
    return (this * mod).roundToDouble() / mod;
  }
}
