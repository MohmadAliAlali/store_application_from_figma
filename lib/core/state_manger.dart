import 'package:shared_preferences/shared_preferences.dart';

class AppState {
  static SharedPreferences? prefs;
  static bool isLoggedIn = false;
  static bool isNotFirstUse = false;




  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs?.getBool('isLoggedIn') ?? false;
    isNotFirstUse = prefs?.getBool('isNotFirstUse') ?? false;
  }

  static Future<void> login() async {
    isLoggedIn = true;
    await prefs?.setBool('isLoggedIn', true);
  }

  static Future<void> logout() async {
    isLoggedIn = false;
    await prefs?.setBool('isLoggedIn', false);
  }
  static Future<void> firstUse() async {
    isNotFirstUse = true;
    await prefs?.setBool('isNotFirstUse', true);
  }
}