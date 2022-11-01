// {
// "option_id":20,
// "question_id":239,
// "option":"zghala",
// "marks":3
// }
import 'dart:convert';

OptionModel optionModelFromJson(String str) => OptionModel.fromJson(json.decode(str));

String optionModelToJson(OptionModel data) => json.encode(data.toJson());

class OptionModel {
  OptionModel({
    this.optionId,
    this.questionId,
    required this.option,
    required this.marks,
  });

  int? optionId;
  int? questionId;
  String option;
  int marks;

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
        optionId: json["option_id"],
        questionId: json["question_id"],
        option: json["option"],
        marks: json["marks"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "option": option,
        "marks": marks,
      };

  @override
  String toString() {
    return 'OptionModel{optionId: $optionId, questionId: $questionId, option: $option, marks: $marks}';
  }
}
