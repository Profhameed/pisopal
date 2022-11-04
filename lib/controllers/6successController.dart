import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:inbestment/data/models/option_model.dart';
import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/repository.dart';

class SuccessController extends GetxController {
  SuccessController(this.userModel);

  Repository repository = Get.find();

  // int userId;
  UserModel userModel;
  List<OptionModel?>? optionModels;
  Rx<String?> category = Rx(null);
  ConfettiController controllerTopCenter =
      ConfettiController(duration: const Duration(seconds: 10));

  double get pmt => userModel.toInvestMonthly * 12;

  // double get pmt => 12000;

  double get interest => getInterestPercentage()/100;
  // int get n => 10;
  // double get interest => 2.42 / 100;

  int get n => userModel.yearsToReturn;

  double get fv => pmt * ((pow((1 + interest), n) - 1) / interest) * (1 + interest);

  double get tInvestment => pmt * n;

  double get tInterest => fv - tInvestment;

  double getInterestPercentage() {
    Map<String, double> map = {
      'Conservative': 2.42,
      'Moderately Conservative': 4.06,
      'Moderate': 6.02,
      'Moderately Aggressive': 9.03,
      'Aggressive': 11.12
    };
    return map[calculateCategory()]!;
  }

  @override
  void onReady() async {
    super.onReady();
    optionModels = await repository.getOptionsSelectedByUser(userModel.userId!);
    category.value = calculateCategory();
    // controllerTopCenter.play();
  }

  String? calculateCategory() {
    int? score = calculateScore();
    // print(a);
    if (score == null) return null;
    if (score <= 8) {
      return "Conservative";
    } else if (score <= 13) {
      return "Moderately Conservative";
    } else if (score <= 17) {
      return "Moderate";
    } else if (score <= 21) {
      return "Moderately Aggressive";
    } else {
      return "Aggressive";
    }
  }

  int? calculateScore() {
    if (optionModels == null) return null;
    // optionModels?.forEach((element) {print(element?.marks);});
    int? a = optionModels?.fold(0, (previousValue, element) => previousValue! + element!.marks);
    return a;
  }
}
