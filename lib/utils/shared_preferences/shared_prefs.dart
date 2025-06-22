import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();
  static late SharedPreferences _prefs;

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  final String login = 'log';

  Future<void> isLogin(String value) async {
    await _prefs.setString(login, value);
  }

  String? getLogin() => _prefs.getString(login);

  Future<void> clear() async {
    await _prefs.clear();
  }
}
