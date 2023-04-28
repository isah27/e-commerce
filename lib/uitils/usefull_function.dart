import 'package:intl/intl.dart';

class UsefulFunction {
  static String currencyConverter({required var price}) {
    final currencyFormatter = NumberFormat("#,##0.00", "en_US");
    return currencyFormatter.format(price);
  }
}
