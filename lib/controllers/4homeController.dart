import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:inbestment/data/repository.dart';
import 'package:inbestment/shared/auth_manager.dart';

import '../data/models/user_model.dart';

class HomeController extends GetxController {
  HomeController(this.userModel);

  final UserModel? userModel;

  Repository repository = Get.find();
  AuthManager authManager = Get.find();

  ConfettiController controllerTopCenter =
      ConfettiController(duration: const Duration(seconds: 10));

  @override
  void onReady() async {
    super.onReady();
    // print(userModel.value);
    controllerTopCenter.play();
  }

  void signOut() {
    authManager.logoutAndRemoveToken();
  }
}
