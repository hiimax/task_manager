import 'package:get/get.dart';

import '../../res/import/import.dart';

// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1)}";
//   }
// }

/// Helper service that abstracts away common HTTP Requests
class ApiServiceImpl implements ApiService {
  @override
  Future handlingError({e, String? title, required context}) async {
    if (e.toString().startsWith('{')) {
      var errMap = e.data as Map;
      List<String> errors = [];
      errMap.forEach((key, value) {
        if (value is List) {
          errors.add("${key.toString()}: ${value[0]}");
        } else {
          errors.add("${key.toString()}: $value");
        }
      });
      String finalStr = errors.reduce((value, element) {
        return value + element;
      });

      showErrorToast(
          message: "\n${finalStr.replaceAll('_', ' ').capitalizeFirst ?? ''}", context: context);
    } else {
      showErrorToast(context: context, message: "${title ?? "Failed"}\n $e");
    }
  }
}
