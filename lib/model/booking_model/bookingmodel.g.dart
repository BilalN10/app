// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookingmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookingModel _$$_BookingModelFromJson(Map<String, dynamic> json) =>
    _$_BookingModel(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      creatorId: json['creatorId'] as String?,
      requestorId: json['requestorId'] as String?,
      state: $enumDecodeNullable(_$BookingStateEnumMap, json['state']),
      bookingDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['bookingDate'], const TimestampConverter().fromJson),
      historic: json['historic'] as bool? ?? false,
      creatorInfo: json['creatorInfo'] == null
          ? null
          : UserInfoModel.fromJson(json['creatorInfo'] as Map<String, dynamic>),
      requestorInfo: json['requestorInfo'] == null
          ? null
          : UserInfoModel.fromJson(
              json['requestorInfo'] as Map<String, dynamic>),
      userMessage: json['userMessage'] as String?,
      robeNumberResearch: json['robeNumberResearch'] as String?,
      acceptDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['acceptDate'], const TimestampConverter().fromJson),
      sizeList: (json['sizeList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      typeList: (json['typeList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      slotList: _$JsonConverterFromJson<List<dynamic>, List<DateTime>>(
          json['slotList'], const ListTimestampConverter().fromJson),
    );

Map<String, dynamic> _$$_BookingModelToJson(_$_BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'creatorId': instance.creatorId,
      'requestorId': instance.requestorId,
      'state': _$BookingStateEnumMap[instance.state],
      'bookingDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.bookingDate, const TimestampConverter().toJson),
      'historic': instance.historic,
      'creatorInfo': instance.creatorInfo?.toJson(),
      'requestorInfo': instance.requestorInfo?.toJson(),
      'userMessage': instance.userMessage,
      'robeNumberResearch': instance.robeNumberResearch,
      'acceptDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.acceptDate, const TimestampConverter().toJson),
      'sizeList': instance.sizeList,
      'typeList': instance.typeList,
      'slotList': _$JsonConverterToJson<List<dynamic>, List<DateTime>>(
          instance.slotList, const ListTimestampConverter().toJson),
    };

const _$BookingStateEnumMap = {
  BookingState.pending: 'pending',
  BookingState.creatorDecline: 'creatorDecline',
  BookingState.validate: 'validate',
  BookingState.decline: 'decline',
  BookingState.cancel: 'cancel',
  BookingState.cancelByCreator: 'cancelByCreator',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
