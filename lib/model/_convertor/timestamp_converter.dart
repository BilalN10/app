import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

class ListTimestampConverter implements JsonConverter<List<DateTime>, List<dynamic>> {
  const ListTimestampConverter();

  @override
  List<DateTime> fromJson(List<dynamic> timestamp) {
    List<DateTime> list = [];
    for (Timestamp item in timestamp) {
      list.add(item.toDate());
    }
    return list;
  }

  @override
  List<Timestamp> toJson(List<DateTime> date) {
    List<Timestamp> list = [];
    for (var item in date) {
      list.add(Timestamp.fromDate(item));
    }
    return list;
  }
}
