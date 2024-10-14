import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class DateDefault implements JsonConverter<DateTime, Timestamp> {
  const DateDefault();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return DateTime.now();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
