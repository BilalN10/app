// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificationfydmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationFydModel _$$_NotificationFydModelFromJson(
        Map<String, dynamic> json) =>
    _$_NotificationFydModel(
      id: json['id'] as String?,
      sendAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['sendAt'], const TimestampConverter().fromJson),
      requestAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['requestAt'], const TimestampConverter().fromJson),
      seen: json['seen'] as bool? ?? false,
      seenByReceiver: json['seenByReceiver'] as bool? ?? false,
      seenBySender: json['seenBySender'] as bool? ?? false,
      receiverId: json['receiverId'] as String?,
      senderId: json['senderId'] as String?,
      booking: json['booking'] == null
          ? null
          : BookingModel.fromJson(json['booking'] as Map<String, dynamic>),
      state: $enumDecodeNullable(_$NotificationStateEnumMap, json['state']),
      userInfo: json['userInfo'] == null
          ? null
          : UserInfoModel.fromJson(json['userInfo'] as Map<String, dynamic>),
      message: json['message'] as String?,
      userMessage: json['userMessage'] as String?,
    );

Map<String, dynamic> _$$_NotificationFydModelToJson(
        _$_NotificationFydModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sendAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.sendAt, const TimestampConverter().toJson),
      'requestAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.requestAt, const TimestampConverter().toJson),
      'seen': instance.seen,
      'seenByReceiver': instance.seenByReceiver,
      'seenBySender': instance.seenBySender,
      'receiverId': instance.receiverId,
      'senderId': instance.senderId,
      'booking': instance.booking?.toJson(),
      'state': _$NotificationStateEnumMap[instance.state],
      'userInfo': instance.userInfo?.toJson(),
      'message': instance.message,
      'userMessage': instance.userMessage,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$NotificationStateEnumMap = {
  NotificationState.request: 'request',
  NotificationState.propose: 'propose',
  NotificationState.cancel: 'cancel',
  NotificationState.accept: 'accept',
  NotificationState.newRequest: 'newRequest',
  NotificationState.none: 'none',
  NotificationState.validate: 'validate',
  NotificationState.decline: 'decline',
  NotificationState.slotRequest: 'slotRequest',
  NotificationState.offertSlot: 'offertSlot',
  NotificationState.creatorDecline: 'creatorDecline',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
