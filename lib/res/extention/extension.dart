// ignore: import_of_legacy_library_into_null_safe

import 'package:intl/intl.dart';

extension StringExtension on String {
  /// this is for mobile
  String get mobilesvg => 'assets/svg/$this.svg';

  String get mobilepng => 'assets/images/mobile/$this.png';

  String get mobilegif => 'assets/images/mobile/$this.gif';

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String dateFormat() {
    return DateFormat('dd-MM-yyyy').format(DateTime.parse(this));
  }
}
