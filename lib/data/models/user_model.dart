// {
// "id":22,
// "email":"email",
// "mobile":"002020",
// "password":"sldls",
// "gender":"male",
// "birthday":"birthday",
// "monthly_income":3030.80,
// "to_invest_monthly":39393.9,
// "years_to_return":202
// }

class UserModel {
  UserModel(
      {this.userId,
      required this.email,
      required this.mobile,
      required this.password,
      required this.gender,
      required this.birthday,
      required this.monthlyIncome,
      required this.toInvestMonthly,
      required this.yearsToReturn,
      required this.userName,
       this.picture,
      required this.lock});

  int? userId;
  String email;
  String mobile;
  String password;
  String gender;
  String birthday;
  double monthlyIncome;
  double toInvestMonthly;
  int yearsToReturn;
  String userName;
  String? picture;
  bool lock;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        email: json["email"],
        mobile: json["mobile"],
        password: json["password"],
        gender: json["gender"],
        birthday: json["birthday"],
        monthlyIncome: json["monthly_income"].toDouble(),
        toInvestMonthly: json["to_invest_monthly"].toDouble(),
        yearsToReturn: json["years_to_return"],
        userName: json['user_name'],
        picture: json['picture'],
        lock: json['lock'] == 0 ? false : true,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "mobile": mobile,
        "password": password,
        "gender": gender,
        "birthday": birthday,
        "monthly_income": monthlyIncome,
        "to_invest_monthly": toInvestMonthly,
        "years_to_return": yearsToReturn,
        "user_name":userName,
        "lock":lock == false?0:1,
        if (picture !=null) "picture":picture,
      };

  @override
  String toString() {
    return 'UserModel{userId: $userId, email: $email, mobile: $mobile, password: $password, gender: $gender, birthday: $birthday, monthlyIncome: $monthlyIncome, toInvestMonthly: $toInvestMonthly, yearsToReturn: $yearsToReturn, userName: $userName, picture: $picture, lock: $lock}';
  }
}
