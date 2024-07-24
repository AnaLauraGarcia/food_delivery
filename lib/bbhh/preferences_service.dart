import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _userIdKey = 'userId';

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
  }

  Future<int?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Obtener el userId de SharedPreferences
    return prefs.getInt('userId');
  }
  Future<void> removeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
  }

  
}
