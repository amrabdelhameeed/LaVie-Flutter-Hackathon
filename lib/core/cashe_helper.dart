import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> initCasheHelper() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setNumber(
      {required String key, required int number}) async {
    return await sharedPreferences!.setInt(key, number);
  }

  static int getNumber({
    required String key,
  }) {
    return sharedPreferences!.getInt(key) ?? -1;
  }

  static Future<bool> setBoolean(
      {required String key, required bool boolean}) async {
    return await sharedPreferences!.setBool(key, boolean);
  }

  static bool getBoolean({
    required String key,
  }) {
    return sharedPreferences!.getBool(key) ?? false;
  }

  static Future<bool> setStr(
      {required String key, required String text}) async {
    return await sharedPreferences!.setString(key, text);
  }

  static String getStr({
    required String key,
  }) {
    return sharedPreferences!.getString(key) ?? '';
  }

  static List<String> getList({
    required String key,
  }) {
    return sharedPreferences!.getStringList(key) ??
        ['axe', 'rose', 'flower']; // List<String>.empty()
  }

  static Future<bool> setList(
      {required List<String> value, required String key}) async {
    return sharedPreferences!.setStringList(key, value);
  }

  static void clearCashe({required String key}) async {
    await sharedPreferences!.remove(key);
  }
}
