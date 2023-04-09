import 'package:get/get.dart';
import 'package:inbestment/controllers/4homeController.dart';
import 'package:inbestment/data/models/option_model.dart';
import 'package:inbestment/data/models/question_model.dart';
import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/models/user_option_model.dart';
import 'package:inbestment/data/network/network.dart';
import 'package:inbestment/data/network/user_post_model.dart';
import 'package:inbestment/data/repository.dart';
import 'package:inbestment/shared/auth_manager.dart';

class QuestionsController extends GetxController {
  AuthManager authManager = Get.find();
  Repository repository = Get.find();
  HomeController homeController = Get.find();

  Rx<List<QuestionModel?>?> questions = Rx(null);
  Rx<int> currentQuestion = 0.obs;
  List<UserOptionModel> userOptions = [];

  @override
  Future<void> onReady() async {
    super.onReady();
    questions.value = await repository.getAllQuestions();
  }

  void addUserOption(UserOptionModel userOptionModel) {
    if (userOptions.length - 1 >= currentQuestion.value) {
      userOptions.removeAt(currentQuestion.value);
    }
    userOptions.insert(currentQuestion.value, userOptionModel);
  }

  void persistUserOptions() {
    // repository.addAllUserOptions(userOptions);
  }

  void nextCallBack(optionModel) async {
    if (optionModel == null) return;
    addUserOption(
      UserOptionModel(optionId: optionModel.optionId!, userId: homeController.userModel!.userId!),
    );
    // if last question
    if (currentQuestion.value == questions.value!.length - 1) {
      ///make user post model and upload to network
      UserPostModel userPostModel = await makeUserPostModel(homeController.userModel!, userOptions);
      /// upload to network
      String? success = await Network().postUserPostModel(userPostModel);
      if (success != "pass") return;

      /// persist the user options and go to next screen
      await repository.insertAllUserOptions(userOptions);
      repository.lockUserForQuestions(homeController.userModel!.userId!);
      Get.offAllNamed('/successPage', arguments: homeController.userModel!);
      return;
    }
    currentQuestion.value++;
    // if (kDebugMode) {
    //   print(userOptions.toString());
    // }
  }

  Future<bool> backButtonDispatcher() async {
    if (currentQuestion.value == 0) {
      return true;
    } else {
      currentQuestion.value--;
      return false;
    }
  }

  Future<UserPostModel> makeUserPostModel(
      UserModel userModel, List<UserOptionModel> userOptions) async {
    // if (userOptions == null) return null;
    List<OptionModel> options = [];
    for (var i in userOptions) {
      OptionModel? op = await repository.getOption(i.optionId);
      options.add(op!);
    }
    UserPostModel userPostModel = UserPostModel(
      name: userModel.userName,
      password: userModel.password,
      email: userModel.email,
      mobile: userModel.mobile,
      gender: userModel.gender,
      birthday: userModel.birthday,
      monthlyIncome: userModel.monthlyIncome,
      toInvestMonthly: userModel.toInvestMonthly,
      yearsToReturn: userModel.yearsToReturn,
      picture: userModel.picture,
      question1: options[0].option,
      question2: options[1].option,
      question3: options[2].option,
      question4: options[3].option,
      question5: options[4].option,
      question6: options[5].option,
      question7: options[6].option,
    );

    return userPostModel;
  }
// Future<UserPostModel?> getUserPostModel(UserModel userModel) async {
//   var userOptions = await getUserOptions(userModel.userId!);
//   if (userOptions == null) return null;
//   List<OptionModel> options = [];
//   for (var i in userOptions) {
//     OptionModel? op = await getOption(i!.optionId);
//     options.add(op!);
//   }
//   UserPostModel userPostModel = UserPostModel(
//     name: userModel.userName,
//     password: userModel.password,
//     email: userModel.email,
//     mobile: userModel.mobile,
//     gender: userModel.gender,
//     birthday: userModel.birthday,
//     monthlyIncome: userModel.monthlyIncome,
//     toInvestMonthly: userModel.toInvestMonthly,
//     yearsToReturn: userModel.yearsToReturn,
//     picture: userModel.picture,
//     question1: options[0].option,
//     question2: options[1].option,
//     question3: options[2].option,
//     question4: options[3].option,
//     question5: options[4].option,
//     question6: options[5].option,
//     question7: options[6].option,
//   );
//
//   return userPostModel;
// }
}
