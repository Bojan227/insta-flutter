import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesConfig {
  static SharedPreferencesConfig? sharedConfig;
  static SharedPreferences? prefs;

  Future<SharedPreferencesConfig> initSharedPreferences() async {
    prefs ??= await SharedPreferences.getInstance();
    sharedConfig ??= SharedPreferencesConfig();

    return sharedConfig!;
  }

  Future<bool> saveString(String key, String value) =>
      prefs!.setString(key, value);

  String? getString(String key) => prefs!.getString(key);
}
