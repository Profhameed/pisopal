import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/repository.dart';
import 'package:inbestment/shared/auth_manager.dart';
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

  Rx<String?> pic = Rx(null);
  String gender = 'Male';

  Future<void> signUp() async {
    ///check if user already exist
    UserModel? newUserModel = await repository.getUserOnEmail(emailController.text);
    if (newUserModel != null) {
      DialogHelper.showMyDialog(description: "User already exist");
      return;
    }

    ///make and upload user
    UserModel uM = UserModel(
        email: emailController.text,
        mobile: phoneController.text,
        password: passwordController.text,
        gender: gender,
        birthday: dateTimeController.text,
        monthlyIncome: double.parse(monthlyIncomeController.text),
        toInvestMonthly: double.parse(monthlyInvestmentController.text),
        yearsToReturn: int.parse(planYearsController.text),
        userName: nameController.text,
        lock: false,
        picture: pic.value);
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
        print(imgString);
        pic.value = imgString;
        // photo photo1 = photo(0, imgString);
        // dbHelper.save(photo1);
        // refreshImages();
      },
    );
  }
}
