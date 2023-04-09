import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inbestment/data/models/facebook_user_model.dart';
import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/repository.dart';
import 'package:inbestment/shared/GoogleSignInApi.dart';
import 'package:inbestment/shared/auth_manager.dart';
import 'package:inbestment/shared/facebookSignInApi.dart';
import 'package:inbestment/widgets/dialog_helper.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Repository repository = Get.find();
  AuthManager authManager = Get.find();

  Future<void> signIn() {
    return _signInWithEmailAndPassword(emailController.text, passwordController.text);
  }

  Future<void> googleSignIn() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignInApi.login();
    if (googleSignInAccount == null) return;
    // print(googleSignInAccount.toString());
// after the googleSignInAccount object has been retrieved
    return _signInWithEmailAndPassword(googleSignInAccount.email, googleSignInAccount.id);
  }

  Future<void> facebookSignIn() async {
    Map<String, dynamic>? info = await FacebookSignInApi.login();
    if (info == null) return;
    FaceBookUserModel faceBookUserModel = FaceBookUserModel.fromJson(info);

    return _signInWithEmailAndPassword(faceBookUserModel.email ?? '', faceBookUserModel.id ?? '');
  }

  Future<void> _signInWithEmailAndPassword(String email, String password) async {
    UserModel? userModel = await repository.getUser(email, password);
    if (userModel == null) {
      DialogHelper.showMyDialog(description: "No such User!");
      return;
    }
    await authManager.loginAndSaveToken(userModel.userId.toString());
    //
    // Get.toNamed('/homePage', arguments: userModel);
    if (userModel.lock == false) {
      Get.offAllNamed('/homePage', arguments: userModel);
    } else if (userModel.lock == true) {
      Get.offAndToNamed('/successPage', arguments: userModel);
    }
  }
}
