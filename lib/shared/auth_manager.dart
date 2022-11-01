import 'package:get/get.dart';
import 'package:inbestment/shared/prefs_helper.dart';

class AuthManager extends GetxService {
  final PrefsHelper _prefsHelper = PrefsHelper();
  String? _token;

  String? get token => _token;

  final Rx<bool> _isLogged = false.obs;

  bool get isLogged => _isLogged.value;

  // set setLogStatus(AuthStatus authStatus) => _isLogged.value = authStatus;

  Future<AuthManager> init() async {
    // worker to listen for isLogged, and go to loginPage when isLogged gets false
    ever(_isLogged, (_) {
      if (_isLogged.value == false) {
        Get.offAllNamed('/loginPage');
      }
    });
    await _checkLogin();
    return this;
  }

  Future<void> loginAndSaveToken(String tok) async {
    _isLogged.value = true;
    _token = tok;
    await _prefsHelper.saveTokenToPrefs(tok);
  }

  Future<void> logoutAndRemoveToken() async {
    _isLogged.value = false;
    _token = null;
    await _prefsHelper.removeTokenFromPrefs();
  }

//checks if token is there in prefs
  // used in init() only
  Future<void> _checkLogin() async {
    _token = await _prefsHelper.getTokenFromPrefs();
    if (_token != null) {
      _isLogged.value = true;
    } else {
      _isLogged.value = false;
    }
  }

  void logOut() {
    _isLogged.value = false;
  }
}

// enum AuthStatus {
//   logged,
//   unLogged,
//   unKnown,
// }
