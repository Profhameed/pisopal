import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/repository.dart';
import 'package:inbestment/shared/auth_manager.dart';
import 'package:inbestment/widgets/dialog_helper.dart';

class SignUpController extends GetxController {
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthManager authManager = Get.find();
  Repository repository = Get.find();

  Future<void> signUp() async {
    UserModel uM = UserModel(
      email: emailController.text,
      mobile: phoneController.text,
      password: passwordController.text,
      gender: "",
      birthday: "",
      monthlyIncome: 0,
      toInvestMonthly: 0,
      yearsToReturn: 0,
    );
    int id = await repository.insertUser(uM);

    UserModel? userModel = await repository.getUserWithToken(id.toString());
    if (userModel == null) {
      DialogHelper.showMyDialog(description: "No such User!");
      return;
    }
    await authManager.loginAndSaveToken(userModel.userId.toString());
    Get.toNamed('homePage', arguments: userModel);
  }
}
