// import 'package:inbestment/data/models/option_model.dart';
//
// String? calculateCategory(List<OptionModel?>? optionModels) {
//   int? score = calculateScore(optionModels);
//   // print(a);
//   if (score == null) return null;
//   if (score <= 8) {
//     return "Conservative";
//   } else if (score <= 13) {
//     return "Moderately Conservative";
//   } else if (score <= 17) {
//     return "Moderate or Balanced";
//   } else if (score <= 21) {
//     return "Moderately Aggressive";
//   } else {
//     return "Aggressive";
//   }
// }
//
// int? calculateScore(List<OptionModel?>? optionModels) {
//   if (optionModels == null) return null;
//   // optionModels?.forEach((element) {print(element?.marks);});
//   int? a = optionModels.fold(0, (previousValue, element) => previousValue! + element!.marks);
//   return a;
// }
