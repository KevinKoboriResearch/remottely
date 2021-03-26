import 'package:intl/intl.dart';

class ProductFunctions {
  String doubleValueToCurrency(double doubleValue) {
    if (doubleValue > 999.99) {
      return NumberFormat.compact().format(doubleValue);
    } else {
      return NumberFormat.currency(
              customPattern: '###,###.##', locale: 'nl_NL')
          .format(doubleValue);
    }
  }
}
