import 'package:get/get.dart';
import 'package:inbestment/data/repository.dart';
import 'package:inbestment/shared/auth_manager.dart';

import '../data/models/user_model.dart';

class HomeController extends GetxController {
  Rx<UserModel?> userModel = Rx(null);
  Repository repository = Get.find();
  AuthManager authManager = Get.find();

  @override
  void onReady() async {
    super.onReady();
    // print(userModel.value);
  }

  void signOut() {
    authManager.logoutAndRemoveToken();
  }
}
