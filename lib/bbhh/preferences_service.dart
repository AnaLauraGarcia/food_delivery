import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _userIdKey = 'userId';
  static const String _cartHistoryKey = 'cartHistoryList';

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  Future<void> removeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
  }

  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> setCartHistoryList(List<String> cartHistory) async {
    final prefs = await getSharedPreferences();
    await prefs.setStringList(_cartHistoryKey, cartHistory);
  }

  Future<List<String>> getCartHistoryList() async {
    final prefs = await getSharedPreferences();
    return prefs.getStringList(_cartHistoryKey) ?? [];
  }
}
