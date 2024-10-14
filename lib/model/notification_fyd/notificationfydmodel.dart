import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/_convertor/timestamp_converter.dart';
import 'package:findyourdresse_app/model/_enum/_notification_state.dart';
import 'package:findyourdresse_app/model/booking_model/bookingmodel.dart';
import 'package:findyourdresse_app/model/user_info_model/user_info_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notificationfydmodel.freezed.dart';
part 'notificationfydmodel.g.dart';

@freezed
class NotificationFydModel with _$NotificationFydModel {
  factory NotificationFydModel({
    String? id,
    @TimestampConverter() DateTime? sendAt,
    @TimestampConverter() DateTime? requestAt,
    @Default(false) bool seen,
    @Default(false) bool seenByReceiver,
    @Default(false) bool seenBySender,
    String? receiverId,
    String? senderId,
    BookingModel? booking,
    NotificationState? state,
    UserInfoModel? userInfo,
    String? message,
    String? userMessage,
  }) = _NotificationFydModel;

  factory NotificationFydModel.fromJson(Map<String, dynamic> json) => _$NotificationFydModelFromJson(json);
}
