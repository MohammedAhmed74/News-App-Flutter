import 'package:shared_preferences/shared_preferences.dart';

class cacheHelper {
  static late SharedPreferences sharedPre;
  static init() async {
    sharedPre = await SharedPreferences.getInstance();
  }

  static setBool({required String key, required bool value}) {
    sharedPre.setBool(key, value);
  }

  static bool? getBool({required String key}) {
    return sharedPre.getBool(key);
  }
}
