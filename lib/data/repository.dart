import 'package:get/get.dart';
import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/models/user_option_model.dart';

import 'models/option_model.dart';
import 'models/question_model.dart';

abstract class Repository extends GetxService {
  Future<int> insertUser(UserModel userModel);

  Future<int> insertQuestion(QuestionModel questionModel);

  Future<int> insertOption(OptionModel optionModel);

  Future<int> insertUserOption(UserOptionModel userOptionModel);

  Future<UserModel?> getUser(String email, String password);

  Future<List<OptionModel?>?> getOptionsForQuestion(QuestionModel questionModel);

  Future<QuestionModel?> getQuestion(int id);

  Future<UserModel?> getUserWithToken(String id);

  Future init();
}
