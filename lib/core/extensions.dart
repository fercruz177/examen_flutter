import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'AppColorsTheme.dart';

NumberFormat currencyFormat = NumberFormat("#,###.00", "es_MX");
extension DoubleNumberFormat on double {

  String toCurrencyFormat() {
    return currencyFormat.format(this);
  }
}

extension ThemeDataExtended on ThemeData
{
  AppColorsTheme get appColors => extension<AppColorsTheme>()!;
}