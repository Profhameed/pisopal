import 'package:inbestment/data/models/option_model.dart';
import 'package:inbestment/data/models/question_model.dart';
import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/models/user_option_model.dart';
import 'package:inbestment/data/repository.dart';

import 'database_helper.dart';

class SqliteRepository extends Repository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<OptionModel?>?> getOptionsForQuestion(QuestionModel questionModel) {
    return dbHelper.getOptionsForQuestion(questionModel);
  }

  @override
  Future<QuestionModel?> getQuestion(int id) {
    return dbHelper.getQuestion(id);
  }

  @override
  Future<UserModel?> getUser(String email, String password) {
    return dbHelper.getUser(email, password);
  }

  @override
  Future<UserModel?> getUserWithToken(String id) {
    int tId = int.parse(id);
    return dbHelper.getUserOnId(tId);
  }

  @override
  Future<int> insertOption(OptionModel optionModel) {
    return dbHelper.insertOption(optionModel);
  }

  @override
  Future<int> insertQuestion(QuestionModel questionModel) {
    return dbHelper.insertQuestion(questionModel);
  }

  @override
  Future<int> insertUser(UserModel userModel) {
    return dbHelper.insertUser(userModel);
  }

  @override
  Future<int> insertUserOption(UserOptionModel userOptionModel) {
    return dbHelper.insertUserOption(userOptionModel);
  }

  @override
  Future<List<QuestionModel?>?> getAllQuestions() {
    return dbHelper.getAllQuestionsWithOptions();
  }

  @override
  Future<void> insertAllUserOptions(List<UserOptionModel?>? userOptions) {
    return dbHelper.insertAllUserOptions(userOptions);
  }

  @override
  Future<List<UserOptionModel?>?> getUserOptions(int userId) {
    return dbHelper.getUserOptions(userId);
  }

  @override
  Future<OptionModel?> getOption(int optionId) {
    return dbHelper.getOption(optionId);
  }

  @override
  Future init() async {
    await dbHelper.database;
    // print('initialized');
    return Future.value();
  }

  @override
  Future<List<OptionModel?>?> getOptionsSelectedByUser(int userId) async {
    List<UserOptionModel?>? userOptions = await getUserOptions(userId);
    // print(userOptions);
    if (userOptions == null) return null;
    List<OptionModel> oMS = [];
    for (var i in userOptions) {
      OptionModel? oM = await getOption(i!.optionId);
      oMS.add(oM!);
    }
    // print(oMS);
    return oMS;
  }

  @override
  Future<UserModel?> getUserOnEmail(String email) {
    return dbHelper.getUserOnEmail(email);
  }

  @override
  Future<void> lockUserForQuestions(int userId) {
    return dbHelper.lockUser(userId);
  }
// @override
// Future<UserPostModel?> getUserPostModel(UserModel userModel){
//   return dbHelper.getUserPostModel(userModel);
// }

}
