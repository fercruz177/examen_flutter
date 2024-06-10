import 'package:intl/intl.dart';

NumberFormat currencyFormat = NumberFormat("#,###.00", "es_MX");
extension DoubleNumberFormat on double {

  String toCurrencyFormat() {
    return currencyFormat.format(this);
  }
}