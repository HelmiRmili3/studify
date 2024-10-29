import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

class SharedPreferencesRepository {
  final String userKey;
  SharedPreferencesRepository({
    required this.userKey,
  });

  // Initialize SharedPreferences
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveUser(User user) async {
    final prefs = await _prefs;
    String userJson = jsonEncode(user.toMap());
    await prefs.setString(userKey, userJson);
  }

  Future<User?> getUser() async {
    final prefs = await _prefs;
    String? userJson = prefs.getString(userKey);

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromMap(userMap);
    }
    return null;
  }

  Future<void> deleteUser() async {
    final prefs = await _prefs;
    await prefs.remove(userKey);
  }

  Future<bool> isUserStored() async {
    final prefs = await _prefs;
    return prefs.containsKey(userKey);
  }
}
