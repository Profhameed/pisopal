import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbestment/data/models/facebook_user_model.dart';
import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/repository.dart';
import 'package:inbestment/shared/GoogleSignInApi.dart';
import 'package:inbestment/shared/auth_manager.dart';
import 'package:inbestment/shared/facebookSignInApi.dart';
import 'package:inbestment/utils/currencyformatter.dart';
import 'package:inbestment/utils/pic_enc_dec.dart';
import 'package:inbestment/widgets/dialog_helper.dart';

class SignUpController extends GetxController {
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthManager authManager = Get.find();
  Repository repository = Get.find();

  TextEditingController dateTimeController = TextEditingController();
  DateTime dateTime = DateTime.now();

  TextEditingController monthlyIncomeController = TextEditingController();

  TextEditingController monthlyInvestmentController = TextEditingController();

  TextEditingController planYearsController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  SignUpType? signUpType;
  GoogleSignInAccount? googleSignInAccount;
  FaceBookUserModel? faceBookUserModel;

  Rx<String?> pic = Rx(null);
  String gender = 'Male';

  Future<void> signUp() async {
    // print(monthlyIncomeController.text);
    // print(monthlyIncomeController.text.currencyToNoComma());
    // return;
    ///check if user already exist
    UserModel? newUserModel = await repository.getUserOnEmail(emailController.text);
    if (newUserModel != null) {
      DialogHelper.showMyDialog(description: "User already exist");
      return;
    }

    ///make and upload user
    UserModel? uM;
    if (signUpType == SignUpType.regular) {
      uM = UserModel(
          email: emailController.text,
          mobile: phoneController.text,
          password: passwordController.text,
          gender: gender,
          birthday: dateTimeController.text,
          monthlyIncome: double.parse(monthlyIncomeController.text.currencyToNoComma()),
          toInvestMonthly: double.parse(monthlyInvestmentController.text.currencyToNoComma()),
          yearsToReturn: int.parse(planYearsController.text),
          userName: nameController.text,
          lock: false,
          picture: pic.value);
    } else if (signUpType == SignUpType.google) {
      uM = UserModel(
          email: googleSignInAccount!.email,
          password: googleSignInAccount!.id,
          userName: googleSignInAccount!.displayName ?? '',
          mobile: phoneController.text,
          gender: gender,
          birthday: dateTimeController.text,
          monthlyIncome: double.parse(monthlyIncomeController.text.currencyToNoComma()),
          toInvestMonthly: double.parse(monthlyInvestmentController.text.currencyToNoComma()),
          yearsToReturn: int.parse(planYearsController.text),
          lock: false,
          picture: await PicUtility.networkImageToBase64(googleSignInAccount!.photoUrl));
    } else if (signUpType == SignUpType.facebook) {
      uM = UserModel(
          email: faceBookUserModel!.email!,
          password: faceBookUserModel!.id!,
          userName: faceBookUserModel!.name!,
          mobile: phoneController.text,
          gender: gender,
          birthday: dateTimeController.text,
          monthlyIncome: double.parse(monthlyIncomeController.text.currencyToNoComma()),
          toInvestMonthly: double.parse(monthlyInvestmentController.text.currencyToNoComma()),
          yearsToReturn: int.parse(planYearsController.text),
          lock: false,
          picture: await PicUtility.networkImageToBase64(faceBookUserModel!.picture!));
    }

    if (uM == null) return;
    int id = await repository.insertUser(uM);

    ///check if the user has been uploaded and get it
    UserModel? userModel = await repository.getUserWithToken(id.toString());
    if (userModel == null) {
      DialogHelper.showMyDialog(description: "No Such User!");
      return;
    }

    ///login and goto next page
    await authManager.loginAndSaveToken(userModel.userId.toString());
    Get.offAllNamed('/homePage', arguments: userModel);
  }

  void pickImage() {
    ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 100, maxWidth: 100, imageQuality: 50)
        .then(
      (imgFile) async {
        if (imgFile == null) return;
        String imgString = PicUtility.base64String(await imgFile.readAsBytes());
        // print(imgString);
        pic.value = imgString;
        // photo photo1 = photo(0, imgString);
        // dbHelper.save(photo1);
        // refreshImages();
      },
    );
  }

  Future<void> googleSignUpStepOne() async {
    GoogleSignInAccount? gSignInAccount = await GoogleSignInApi.login();
    if (gSignInAccount == null) return;
    // print(googleSignInAccount.toString());
// after the googleSignInAccount object has been retrieved
    googleSignInAccount = gSignInAccount;
    Get.toNamed('/signUp2Page');
  }

  Future<void> facebookSignUpStepOne() async {
    Map<String, dynamic>? info = await FacebookSignInApi.login();
    if (info == null) return;
    try {
      faceBookUserModel = FaceBookUserModel.fromJson(info);
    } on Exception catch (e) {
      print(e);
      return;
    }
    Get.toNamed('/signUp2Page');
  }
}

enum SignUpType { regular, google, facebook, apple }
