import 'package:get/get.dart';
import 'package:inbestment/pages/1wrapper_page.dart';
import 'package:inbestment/pages/2login_page.dart';
import 'package:inbestment/pages/3signup_page.dart';
import 'package:inbestment/pages/4signup2_page.dart';
import 'package:inbestment/pages/5homepage.dart';
import 'package:inbestment/pages/6question_page.dart';
import 'package:inbestment/pages/7success_page.dart';
import 'package:inbestment/pages/8success_page2.dart';
import 'package:inbestment/pages/9dashboard_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/wrapperPage', page: () => WrapperPage()),
    GetPage(name: '/loginPage', page: () => LoginPage()),
    GetPage(name: '/signUpPage', page: () => SignUpPage()),
    GetPage(name: '/signUp2Page', page: () => SignUp2Page()),
    GetPage(name: '/homePage', page: () => HomePage()),
    GetPage(name: '/questionPage', page: () => QuestionPage()),
    GetPage(name: '/successPage', page: () => SuccessPage()),
    GetPage(name: '/successPage2', page: () => SuccessPage2()),
    GetPage(name: '/dashboardPage', page: () => DashboardPage()),
  ];
}
