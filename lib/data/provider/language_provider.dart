import '../../res/import/import.dart';

class LanguageProvider extends ChangeNotifier {
  static LanguageProvider? _instance;

  LanguageProvider() {
    _instance = this;
  }

  static LanguageProvider get instance {
    _instance ??= LanguageProvider();
    return _instance!;
  }

  String _language = 'en';

  String get language => _language;

  set language(String value) {
    _language = value;
    notifyListeners();
  }

  Future<void> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _language = prefs.getString('language') ?? 'en';

    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    language == language;
    _language = prefs.getString('language') ?? 'es';
    notifyListeners();
  }
}
