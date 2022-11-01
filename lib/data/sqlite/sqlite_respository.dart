import 'package:inbestment/data/models/option_model.dart';
import 'package:inbestment/data/models/question_model.dart';
import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/models/user_option_model.dart';
import 'package:inbestment/data/repository.dart';

import 'database_helper.dart';

class SqliteRepository extends Repository{
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
  Future<UserModel?> getUserWithToken(String id){
    int tId = int.parse(id);
    return dbHelper.getUserOnId(tId);
  }

  @override
  Future<int> insertOption(OptionModel optionModel) {
    return  dbHelper.insertOption(optionModel);
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
  Future init()async{
    await dbHelper.database;
    print('initialized');
    return Future.value();
  }

}