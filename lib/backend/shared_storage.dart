import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static const String key = "usertype_key";
  setUserType(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Future<String?> getUserType() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
}
