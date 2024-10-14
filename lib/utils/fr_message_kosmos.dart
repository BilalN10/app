import 'package:timeago/timeago.dart';

class FrShortMessagesKosmos implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => "";
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => "A l’instant";
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '1 h';
  @override
  String hours(int hours) => '$hours h';
  @override
  String aDay(int hours) => '1 j';
  @override
  String days(int days) => '$days j';
  @override
  String aboutAMonth(int days) => '1 m';
  @override
  String months(int months) => '$months m';
  @override
  String aboutAYear(int year) => '1 an';
  @override
  String years(int years) => '$years ans';
  @override
  String wordSeparator() => ' ';
}
