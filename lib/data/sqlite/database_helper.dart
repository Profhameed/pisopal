import 'dart:async';

import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/models/user_option_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

import '../models/option_model.dart';
import '../models/question_model.dart';

class DatabaseHelper {
  static const _databaseName = 'MyInvestment.db';
  static const _databaseVersion = 2;

  static const usersTable = 'UsersTable';
  static const questionsTable = 'QuestionsTable';
  static const optionsTable = 'OptionsTable';
  static const userOptionsTable = 'UserOptionsTable';

  static const userId = 'user_id';
  static const questionId = 'question_id';
  static const optionId = 'option_id';
  static const userOptionId = 'user_option_id';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static var lock = Lock();

  // only have a single app-wide reference to the database
  static Database? _database;

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $usersTable (
          $userId INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT,
          mobile TEXT,
          password TEXT,
          gender TEXT,
          birthday TEXT,
          monthly_income REAL,
          to_invest_monthly REAL,
          years_to_return INTEGER,
          user_name TEXT,
          picture TEXT,
          lock INTEGER
        )
        ''');
    await db.execute('''
        CREATE TABLE $questionsTable (
          $questionId INTEGER PRIMARY KEY AUTOINCREMENT,
          question TEXT
        )
        ''');
    await db.execute('''
        CREATE TABLE $optionsTable (
          $optionId INTEGER PRIMARY KEY AUTOINCREMENT,
          $questionId INTEGER,
          option TEXT,
          marks INTEGER
        )
        ''');
    await db.execute('''
        CREATE TABLE $userOptionsTable (
          $userOptionId INTEGER PRIMARY KEY AUTOINCREMENT,
          $userId INTEGER,
          $optionId INTEGER
        )
        ''');
    // await db.insert(
    //     usersTable,
    //     UserModel(
    //             email: "jan@demo.com",
    //             mobile: "03412046310",
    //             password: "123456",
    //             gender: "Male",
    //             birthday: "09/03/1993",
    //             monthlyIncome: 1000,
    //             toInvestMonthly: 399,
    //             yearsToReturn: 20)
    //         .toJson());

    await insertInitialData(db);
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(
      documentsDirectory.path,
      _databaseName,
    );
    // Sqflite.setDebugModeOn(true);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Use this object to prevent concurrent access to data
    await lock.synchronized(() async {
      // lazily instantiate the db the first time it is accessed
      _database ??= await _initDatabase();
    });
    return _database!;
  }

  //helper methods
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final Database db = await database;
    return await db.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertUser(UserModel userModel) async {
    return await insert(usersTable, userModel.toJson());
  }

  Future<int> insertQuestion(QuestionModel questionModel) async {
    return await insert(questionsTable, questionModel.toJson());
  }

  Future<int> insertOption(OptionModel optionModel) async {
    return await insert(optionsTable, optionModel.toJson());
  }

  Future<int> insertUserOption(UserOptionModel userOptionModel) async {
    return await insert(userOptionsTable, userOptionModel.toJson());
  }

  Future<UserModel?> getUser(String email, String password) async {
    final Database db = await database;
    var res = await db
        .query(usersTable, where: "email = ? AND password = ?", whereArgs: [email, password]);
    return res.isNotEmpty ? UserModel.fromJson(res.first) : null;
  }

  Future<UserModel?> getUserOnEmail(String email) async {
    final Database db = await database;
    var res = await db.query(usersTable, where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty ? UserModel.fromJson(res.first) : null;
  }

  Future<UserModel?> getUserOnId(int id) async {
    final Database db = await database;
    var res = await db.query(usersTable, where: "$userId = ?", whereArgs: [id]);
    return res.isNotEmpty ? UserModel.fromJson(res.first) : null;
  }

  Future<OptionModel?> getOption(int opId) async {
    final Database db = await database;
    var res = await db.query(optionsTable, where: "$optionId = ?", whereArgs: [opId]);
    return res.isNotEmpty ? OptionModel.fromJson(res.first) : null;
  }

  Future<List<OptionModel?>?> getOptionsForQuestion(QuestionModel questionModel) async {
    final Database db = await database;
    var res = await db
        .query(optionsTable, where: "$questionId = ?", whereArgs: [questionModel.questionId]);
    if (res.isNotEmpty) {
      List<OptionModel> oMs = [];
      for (Map<String, dynamic> element in res) {
        oMs.add(OptionModel.fromJson(element));
      }
      return oMs;
    }
    return null;
  }

  Future<QuestionModel?> getQuestion(int id) async {
    final Database db = await database;
    var res = await db.query(questionsTable, where: '$questionId = ?', whereArgs: [id]);
    QuestionModel? qM = res.isNotEmpty ? QuestionModel.fromJson(res.first) : null;
    if (qM == null) return null;
    var res2 = await getOptionsForQuestion(qM);
    qM.options = res2;
    return qM;
  }

// Future<QuestionModel?> getQuestionWithOptions(int id) async{
//   final Database db = await database;
//   // var res = await db.rawQuery("select * from $questionsTable A inner join $optionsTable B on {$questionsTable}.$questionId = {$optionsTable}.$questionId");
//
// }
  Future<List<QuestionModel?>?> getAllQuestionsWithOptions() async {
    final Database db = await database;
    var res = await db.query(questionsTable);
    if (res.isNotEmpty) {
      List<QuestionModel> qMs = [];
      for (Map<String, dynamic> element in res) {
        qMs.add(QuestionModel.fromJson(element));
      }
      for (var i in qMs) {
        i.options = await getOptionsForQuestion(i);
      }
      return qMs;
    }
    return null;
  }

  Future<void> insertAllUserOptions(List<UserOptionModel?>? userOptions) async {
    if (userOptions == null) return;
    for (var element in userOptions) {
      await insertUserOption(element!);
    }
  }

  Future<List<UserOptionModel?>?> getUserOptions(int newUserId) async {
    final Database db = await database;
    var res = await db.query(userOptionsTable, where: "$userId = ?", whereArgs: [newUserId]);
    if (res.isNotEmpty) {
      List<UserOptionModel> uOM = [];
      for (var i in res) {
        uOM.add(UserOptionModel.fromJson(i));
      }
      // print(uOM);
      return uOM;
    }
    return null;
  }

  Future<void> lockUser(int uId) async {
    final Database db = await database;
    await db.update(usersTable, {'lock': 1}, where: '$userId = ?', whereArgs: [uId]);
  }

  ///initial
  Future<void> insertQuestionWithOptions(QuestionModel questionModel, Database db) async {
    await db.transaction((txn) async {
      int id = await db.insert(questionsTable, questionModel.toJson());
      if (questionModel.options?.isEmpty ?? false) return;
      for (var option in questionModel.options!) {
        option!.questionId = id;
        await db.insert(optionsTable, option.toJson());
      }
    });
  }

  Future<void> insertInitialData(Database db) async {
    await insertQuestionWithOptions(
      QuestionModel(question: 'How much of your monthly income can you invest?', options: [
        OptionModel(option: "10% or less", marks: 1),
        OptionModel(option: "11% to 20%", marks: 2),
        OptionModel(option: "21 % to 30%", marks: 3),
        OptionModel(option: "More than 30%", marks: 4)
      ]),
      db,
    );
    await insertQuestionWithOptions(
      QuestionModel(
          question: "When will you need your money when you're back in the Philippines?",
          options: [
            OptionModel(option: "Less than a year", marks: 1),
            OptionModel(option: "1 to 2 years", marks: 2),
            OptionModel(option: "3 to 5 years", marks: 3),
            OptionModel(option: "After 5 years", marks: 4)
          ]),
      db,
    );
    await insertQuestionWithOptions(
      QuestionModel(
          question:
              "What level of risk in relation to investment returns are you most comfortable with?",
          options: [
            OptionModel(option: "Mababang kita pero buo ang puhunan.", marks: 1),
            OptionModel(option: "Katamtamang risks na may tuloy-tuloy na kita.", marks: 2),
            OptionModel(
                option:
                    "Moderate risks and short-term losses pero may posibilidad na mataas na kita.",
                marks: 3),
            OptionModel(
                option:
                    "High risks and short-term losses pero may posibilidad na mas mataas na kita over the long term.",
                marks: 4)
          ]),
      db,
    );
    await insertQuestionWithOptions(
      QuestionModel(
          question: "What is the likelihood that you will need to withdraw this investment?",
          options: [
            OptionModel(option: "I need it back within 6 months", marks: 1),
            OptionModel(option: "I need it back in 7 months to 2 years", marks: 2),
            OptionModel(option: "I need it back in 2 to 5 years", marks: 3),
            OptionModel(option: "I need it after 5 years", marks: 4)
          ]),
      db,
    );
    await insertQuestionWithOptions(
      QuestionModel(question: "How much do you know about investments?", options: [
        OptionModel(option: "Minimal. I know savings and time deposits.", marks: 1),
        OptionModel(option: "Low. I know the basics of money markets and bonds.", marks: 2),
        OptionModel(option: "Medium. I know mutual funds and UITFs.", marks: 3),
        OptionModel(option: "High. I know stock trading.", marks: 4)
      ]),
      db,
    );
    await insertQuestionWithOptions(
      QuestionModel(
          question: "When and how often do you plan to cash in on your investments?",
          options: [
            OptionModel(
                option:
                    "I need to draw regular income from my investments and may use a portion of the principal in the short term.",
                marks: 1),
            OptionModel(
                option:
                    "I do not need to draw regular income from my investments nor do I see the immediate need to Use any portion of the principal in the short term.",
                marks: 2),
            OptionModel(
                option:
                    "I have other sources of liquidity and do not see a real need to use funds for the next 5 to 10 years.",
                marks: 3),
            OptionModel(
                option:
                    "I have other sources of liquidity and do not see a real need to use funds for the next 10 years.",
                marks: 4)
          ]),
      db,
    );
    await insertQuestionWithOptions(
      QuestionModel(
          question:
              "If the value of your portfolio decreased by 20% in one year, how would you react?",
          options: [
            OptionModel(
                option:
                    "I will be very concerned and will immediately put my investment back to cash (i.e. in the form of deposits and/or short term government securities).",
                marks: 1),
            OptionModel(
                option:
                    "I will be very concerned and will find safer investment outlets, which are not necessarily cash.",
                marks: 2),
            OptionModel(
                option: "I will be concerned and will review the aggressiveness of my portfolio.",
                marks: 3),
            OptionModel(
                option:
                    "I will NOT be concerned about the short-term function of certain investments in my portfolio.",
                marks: 4)
          ]),
      db,
    );
  }
}
