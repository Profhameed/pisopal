import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> saveTokenToPrefs(String token) async {
    SharedPreferences prefs = await _prefs;
    bool gotSaved = await prefs.setString(_PrefsManagerKey.token.toString(), token);
    return gotSaved;
  }

  Future<String?> getTokenFromPrefs() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(_PrefsManagerKey.token.toString());
  }





  Future<bool> removeTokenFromPrefs() async {
    SharedPreferences prefs = await _prefs;
    if (prefs.containsKey(_PrefsManagerKey.token.toString())) {
      return prefs.remove(_PrefsManagerKey.token.toString());
    }
    return true;
  }
}

enum _PrefsManagerKey { token,  }
