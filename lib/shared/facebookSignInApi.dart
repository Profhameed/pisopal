import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInApi {
  static Future<Map<String, dynamic>?> login() async {
    await logOut();
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      print(userData);
      return userData;
    } else {
      print(result.status);
      print(result.message);
      return null;
    }
  }

  //

  static Future logOut() async {
    await FacebookAuth.instance.logOut();
  }
}
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
// class FacebookSignInApi {
//   Map<String, dynamic>? _userData;
//   AccessToken? _accessToken;
//   bool _checking = true;
//
//   @override
//   void initState() {
//     super.initSate();
//     _checkIfIsLogged();
//   }
//
//   _checkIfIsLogged() async {
//     final accessToken = FacebookAuth.instance.accessToken;
//     setState(() {
//       _checking = false;
//     });
//     if (accessToken != null) {
//       print(accessToken.toJson());
//       final userData = await FacebookAuth.instance.getUserData();
//       _accessToken = _accessToken;
//       setState(() {
//         _userData = userData;
//       });
//     } else {
//       _login();
//     }
//   }
//
//   login() async {
//     final LoginResult result = await FacebookAuth.instance.login();
//     if (result.status == LoginStatus.success) {
//       _accessToken = result.accessToken;
//       final userData = await FacebookAuth.instance.getUserData();
//     } else {
//       print(result.status);
//       print(result.message);
//     }
//     setState(() {
//       _checking = false;
//     });
//   }
//
//   //
//
//   signOut() {}
//
//   logOut() async {
//     await FacebookAuth.instance.logOut();
//     _accessToken = null;
//     _userData = null;
//     setState(() {});
//   }
// }
