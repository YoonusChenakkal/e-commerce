import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _userKey = 'user_data';

  /// Save user in SharedPreferences
  static Future<void> saveUser(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userKey, userId);
  }

  /// Get user
  static Future<int?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt(_userKey);
    if (userId == null) return null;
    return userId;
  }

  /// Remove user  (logout)
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
