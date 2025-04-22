import 'package:shared_preferences/shared_preferences.dart';

class UserDataStorage {
  //region Singleton
  static final UserDataStorage _singleton = UserDataStorage._internal();

  factory UserDataStorage() {
    return _singleton;
  }

  UserDataStorage._internal();
  //endregion

  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _tokenKey = 'token';

  Future<void> saveLoginState({required bool isLoggedIn, String? token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
    if (token != null) {
      await prefs.setString(_tokenKey, token);
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_tokenKey);
  }
}
