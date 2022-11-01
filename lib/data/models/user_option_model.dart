import 'dart:convert';

// {
// "user_option_id":10,
// "user_id":20,
// "option_id":40
// }
UserOptionModel userOptionModelFromJson(String str) => UserOptionModel.fromJson(json.decode(str));

String userOptionModelToJson(UserOptionModel data) => json.encode(data.toJson());

class UserOptionModel {
  UserOptionModel({
    required this.userOptionId,
    required this.userId,
    required this.optionId,
  });

  int userOptionId;
  int userId;
  int optionId;

  factory UserOptionModel.fromJson(Map<String, dynamic> json) => UserOptionModel(
        userOptionId: json["user_option_id"],
        userId: json["user_id"],
        optionId: json["option_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "option_id": optionId,
      };
}
