import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/repository.dart';
import 'package:inbestment/shared/auth_manager.dart';
import 'package:inbestment/widgets/dialog_helper.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Repository repository = Get.find();
  AuthManager authManager = Get.find();

  Future<void> signIn() async {
    UserModel? userModel = await repository.getUser(emailController.text, passwordController.text);
    if (userModel == null) {
      DialogHelper.showMyDialog(description: "No such User!");
      return;
    }
    await authManager.loginAndSaveToken(userModel.userId.toString());
    //
    // Get.toNamed('/homePage', arguments: userModel);
    if(userModel.lock == false) {
      Get.offAllNamed('/homePage', arguments: userModel);
    }else if(userModel.lock == true){
      Get.offAndToNamed('/successPage',arguments: userModel);
    }
  }
}
