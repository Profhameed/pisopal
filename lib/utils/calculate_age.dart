import 'package:intl/intl.dart';

calculateAge(String ds) {

  DateTime birthDate = stringToDate(ds);
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

DateTime stringToDate(String ds){
 return DateFormat('MM/dd/yyyy').parse(ds);

}