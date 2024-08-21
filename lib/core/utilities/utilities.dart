import 'package:intl/intl.dart';

class Utilities {
  String converToDDMMYYY(int date) {
    return DateFormat("dd-MM-yyyy")
        .format(DateTime.fromMillisecondsSinceEpoch(date));
  }

  static equalIgnoreCase(String s1, String s2) {
    return s1.toLowerCase() == s2.toLowerCase();
  }

  static equals(String s1, String s2) {
    return s1 == s2;
  }

  NumberFormat numberFormat() {
    return NumberFormat("##.##", "en_US");
  }
}
