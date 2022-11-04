class UserPostModel {
  String name;
  String password;
  String email;
  String mobile;
  String gender;
  String birthday;
  double monthlyIncome;
  double toInvestMonthly;
  int yearsToReturn;
  String question1;
  String question2;
  String question3;
  String question4;
  String question5;
  String question6;
  String question7;
  String? picture;

  UserPostModel(
      {required this.name,
      required this.password,
      required this.email,
      required this.mobile,
      required this.gender,
      required this.birthday,
      required this.monthlyIncome,
      required this.toInvestMonthly,
      required this.yearsToReturn,
      required this.question1,
      required this.question2,
      required this.question3,
      required this.question4,
      required this.question5,
      required this.question6,
      required this.question7,
      this.picture});

  Map<String, String> toMap() {
    return {
      'name': name,
      'password': password,
      'email': email,
      'mobile': mobile,
      'gender': gender,
      'birth_day': birthday,
      'monthly_income': monthlyIncome.toString(),
      'to_invest_monthly': toInvestMonthly.toString(),
      'years_to_return': yearsToReturn.toString(),
      'question_1': question1,
      'question_2': question2,
      'question_3': question3,
      'question_4': question4,
      'question_5': question5,
      'question_6': question6,
      'question_7': question7,
      if (picture != null) 'picture': picture!
    };
  }

  @override
  String toString() {
    return 'UserPostModel{name: $name, password: $password, email: $email, mobile: $mobile, gender: $gender, birthday: $birthday, monthlyIncome: $monthlyIncome, toInvestMonthly: $toInvestMonthly, yearsToReturn: $yearsToReturn, question1: $question1, question2: $question2, question3: $question3, question4: $question4, question5: $question5, question6: $question6, question7: $question7, picture: $picture}';
  }
}
