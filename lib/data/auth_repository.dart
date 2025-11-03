import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  AuthRepository(this._prefs);

  final SharedPreferences _prefs;
  static const _keyLoggedIn = 'auth_logged_in';

  Future<bool> isLoggedIn() async {
    try {
      return _prefs.getBool(_keyLoggedIn) ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> login({required String email, required String password}) async {
    await _prefs.setBool(_keyLoggedIn, true);
  }

  Future<void> register({required String email, required String password}) async {
    // In a real app you would store user securely. Here we just mark logged in.
    await _prefs.setBool(_keyLoggedIn, true);
  }

  Future<void> logout() async {
    await _prefs.remove(_keyLoggedIn);
  }
}
