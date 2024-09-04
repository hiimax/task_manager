import '../../res/import/import.dart';

class MyException implements Exception {
  final String message;

  MyException(this.message);

  factory MyException.from(Exception e) {
    if (e is SocketException) {
      return MyException('No internet connection');
    } else if (e is HttpException) {
      return MyException('Failed to load data');
    } else if (e is FormatException) {
      return MyException('Invalid JSON data');
    } else if (e is TimeoutException) {
      return MyException('Request timed out');
    } else {
      return MyException('An unknown error occurred');
    }
  }

  @override
  String toString() {
    return 'MyException $message';
  }
}
