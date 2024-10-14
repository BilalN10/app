import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/_convertor/timestamp_converter.dart';
import 'package:findyourdresse_app/model/_enum/_booking_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../user_info_model/user_info_model.dart';

part 'bookingmodel.freezed.dart';
part 'bookingmodel.g.dart';

@freezed
class BookingModel with _$BookingModel {
  factory BookingModel({
    String? id,
    String? productId,
    String? productName,
    String? creatorId,
    String? requestorId,
    BookingState? state,
    @TimestampConverter() DateTime? bookingDate,
    @Default(false) bool historic,
    UserInfoModel? creatorInfo,
    UserInfoModel? requestorInfo,
    String? userMessage,
    String? robeNumberResearch,
    @TimestampConverter() DateTime? acceptDate,
    @Default([]) List<String>? sizeList,
    @Default([]) List<String>? typeList,
    @ListTimestampConverter() List<DateTime>? slotList,
  }) = _BookingModel;

  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);
}
