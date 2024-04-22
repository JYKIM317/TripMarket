import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_market/analytics.dart';

class LocalSharedPreferences {
  late String key;

  LocalSharedPreferences({required this.key});

  Future<List<String>?> getStringList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      return prefs.getStringList(key);
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Local shared preferences get StringList exeption',
        log: {'exeption': e.toString()},
      );

      return null;
    }
  }

  Future<void> setStringList({required List<String> value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  Future<void> removeElement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<String?> getString() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      return prefs.getString(key);
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Local shared preferences get String exeption',
        log: {'exeption': e.toString()},
      );

      return null;
    }
  }

  Future<void> setString({required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
