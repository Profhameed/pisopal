// {
// "question_id": 20,
// "question":"what is your name?"
// }

import 'dart:convert';

import 'option_model.dart';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  QuestionModel({
     this.questionId,
    required this.question,
    this.options

  });

  int? questionId;
  String question;
  List<OptionModel?>? options;

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        questionId: json["question_id"],
        question: json["question"],

      );

  Map<String, dynamic> toJson() => {
        "question": question,
      };

  @override
  String toString() {
    return 'QuestionModel{questionId: $questionId, question: $question, options: $options}';
  }
}
