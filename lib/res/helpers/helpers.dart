import 'package:intl/intl.dart';

import '../import/import.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

formatCurrency(dynamic value) {
  NumberFormat("#,##0.00", "en_US").format(value);
}

String convertToAgo(DateTime input) {
  Duration diff = DateTime.now().difference(input);
  return '${diff.inDays}';
}

void showErrorToast({required String message, required context}) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.fixed,
    backgroundColor: Colors.transparent,
    content: Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: taskManagerColor7,
          border: Border.all(
            color: taskManagerColor8,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Error!',
                        style: TaskManagerTextStyle.size16.copyWith(
                          color: taskManagerRed,
                          fontWeight: FontWeight.w600,
                        )),
                    const YMargin(4),
                    Text(message,
                        style: TaskManagerTextStyle.size14.copyWith(
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void showSuccessToast({required String message, required context}) {
  final materialBanner = SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.fixed,
    content: Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: taskManagerColor7,
          border: Border.all(
            color: taskManagerColor8,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Success!',
                      style: TaskManagerTextStyle.size16.copyWith(
                        color: taskManagerGreen,
                        fontWeight: FontWeight.w600,
                      )),
                  const YMargin(4),
                  Text(message,
                      style: TaskManagerTextStyle.size14.copyWith(
                        fontWeight: FontWeight.w400,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(materialBanner);
}

String formatCurrencyValue(num value) {
  String formattedValue = value.toStringAsFixed(2);
  List<String> parts = formattedValue.split('.');

  final RegExp regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  parts[0] = parts[0].replaceAllMapped(regex, (Match match) => '${match[1]},');

  return '${parts[0]}.${parts[1]}';
}

String formatSystemDate(String value) {
  // Parse the input date string
  DateTime dateTime = DateTime.parse(value);

  // Format the date
  String formattedDate = DateFormat("MMMM d, y h:mm a").format(dateTime);

  return formattedDate;
}

String formatTimeOfDay(TimeOfDay timeOfDay, context) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  return TimeOfDay.fromDateTime(dateTime).format(context);
}

class ParserService {
  static num parseMoneyToNum(String money) {
    return num.tryParse(money.replaceAll(',', '')) ?? 0;
  }
}

String generateToken(int length) {
  const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random.secure();
  return List.generate(
          length, (index) => characters[random.nextInt(characters.length)])
      .join('');
}
