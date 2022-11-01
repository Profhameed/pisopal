import 'package:get/get.dart';
import 'package:inbestment/pages/1wrapper_page.dart';
import 'package:inbestment/pages/2login_page.dart';
import 'package:inbestment/pages/3signup_page.dart';
import 'package:inbestment/pages/4signup2_page.dart';
import 'package:inbestment/pages/5homepage.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/wrapperPage', page: () => WrapperPage()),
    GetPage(name: '/loginPage', page: () => LoginPage()),
    GetPage(name: '/signUpPage', page: () => SignUpPage()),
    GetPage(name: '/signUp2Page', page: () => SignUp2Page()),
    GetPage(name: '/homePage', page: () => HomePage()),
  ];
}
