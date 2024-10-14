// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notificationfydmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationFydModel _$NotificationFydModelFromJson(Map<String, dynamic> json) {
  return _NotificationFydModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationFydModel {
  String? get id => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get sendAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get requestAt => throw _privateConstructorUsedError;
  bool get seen => throw _privateConstructorUsedError;
  bool get seenByReceiver => throw _privateConstructorUsedError;
  bool get seenBySender => throw _privateConstructorUsedError;
  String? get receiverId => throw _privateConstructorUsedError;
  String? get senderId => throw _privateConstructorUsedError;
  BookingModel? get booking => throw _privateConstructorUsedError;
  NotificationState? get state => throw _privateConstructorUsedError;
  UserInfoModel? get userInfo => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get userMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationFydModelCopyWith<NotificationFydModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationFydModelCopyWith<$Res> {
  factory $NotificationFydModelCopyWith(NotificationFydModel value,
          $Res Function(NotificationFydModel) then) =
      _$NotificationFydModelCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      @TimestampConverter() DateTime? sendAt,
      @TimestampConverter() DateTime? requestAt,
      bool seen,
      bool seenByReceiver,
      bool seenBySender,
      String? receiverId,
      String? senderId,
      BookingModel? booking,
      NotificationState? state,
      UserInfoModel? userInfo,
      String? message,
      String? userMessage});

  $BookingModelCopyWith<$Res>? get booking;
  $UserInfoModelCopyWith<$Res>? get userInfo;
}

/// @nodoc
class _$NotificationFydModelCopyWithImpl<$Res>
    implements $NotificationFydModelCopyWith<$Res> {
  _$NotificationFydModelCopyWithImpl(this._value, this._then);

  final NotificationFydModel _value;
  // ignore: unused_field
  final $Res Function(NotificationFydModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? sendAt = freezed,
    Object? requestAt = freezed,
    Object? seen = freezed,
    Object? seenByReceiver = freezed,
    Object? seenBySender = freezed,
    Object? receiverId = freezed,
    Object? senderId = freezed,
    Object? booking = freezed,
    Object? state = freezed,
    Object? userInfo = freezed,
    Object? message = freezed,
    Object? userMessage = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      sendAt: sendAt == freezed
          ? _value.sendAt
          : sendAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requestAt: requestAt == freezed
          ? _value.requestAt
          : requestAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      seen: seen == freezed
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      seenByReceiver: seenByReceiver == freezed
          ? _value.seenByReceiver
          : seenByReceiver // ignore: cast_nullable_to_non_nullable
              as bool,
      seenBySender: seenBySender == freezed
          ? _value.seenBySender
          : seenBySender // ignore: cast_nullable_to_non_nullable
              as bool,
      receiverId: receiverId == freezed
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: senderId == freezed
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
      booking: booking == freezed
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as BookingModel?,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as NotificationState?,
      userInfo: userInfo == freezed
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserInfoModel?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      userMessage: userMessage == freezed
          ? _value.userMessage
          : userMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $BookingModelCopyWith<$Res>? get booking {
    if (_value.booking == null) {
      return null;
    }

    return $BookingModelCopyWith<$Res>(_value.booking!, (value) {
      return _then(_value.copyWith(booking: value));
    });
  }

  @override
  $UserInfoModelCopyWith<$Res>? get userInfo {
    if (_value.userInfo == null) {
      return null;
    }

    return $UserInfoModelCopyWith<$Res>(_value.userInfo!, (value) {
      return _then(_value.copyWith(userInfo: value));
    });
  }
}

/// @nodoc
abstract class _$$_NotificationFydModelCopyWith<$Res>
    implements $NotificationFydModelCopyWith<$Res> {
  factory _$$_NotificationFydModelCopyWith(_$_NotificationFydModel value,
          $Res Function(_$_NotificationFydModel) then) =
      __$$_NotificationFydModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      @TimestampConverter() DateTime? sendAt,
      @TimestampConverter() DateTime? requestAt,
      bool seen,
      bool seenByReceiver,
      bool seenBySender,
      String? receiverId,
      String? senderId,
      BookingModel? booking,
      NotificationState? state,
      UserInfoModel? userInfo,
      String? message,
      String? userMessage});

  @override
  $BookingModelCopyWith<$Res>? get booking;
  @override
  $UserInfoModelCopyWith<$Res>? get userInfo;
}

/// @nodoc
class __$$_NotificationFydModelCopyWithImpl<$Res>
    extends _$NotificationFydModelCopyWithImpl<$Res>
    implements _$$_NotificationFydModelCopyWith<$Res> {
  __$$_NotificationFydModelCopyWithImpl(_$_NotificationFydModel _value,
      $Res Function(_$_NotificationFydModel) _then)
      : super(_value, (v) => _then(v as _$_NotificationFydModel));

  @override
  _$_NotificationFydModel get _value => super._value as _$_NotificationFydModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? sendAt = freezed,
    Object? requestAt = freezed,
    Object? seen = freezed,
    Object? seenByReceiver = freezed,
    Object? seenBySender = freezed,
    Object? receiverId = freezed,
    Object? senderId = freezed,
    Object? booking = freezed,
    Object? state = freezed,
    Object? userInfo = freezed,
    Object? message = freezed,
    Object? userMessage = freezed,
  }) {
    return _then(_$_NotificationFydModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      sendAt: sendAt == freezed
          ? _value.sendAt
          : sendAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requestAt: requestAt == freezed
          ? _value.requestAt
          : requestAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      seen: seen == freezed
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      seenByReceiver: seenByReceiver == freezed
          ? _value.seenByReceiver
          : seenByReceiver // ignore: cast_nullable_to_non_nullable
              as bool,
      seenBySender: seenBySender == freezed
          ? _value.seenBySender
          : seenBySender // ignore: cast_nullable_to_non_nullable
              as bool,
      receiverId: receiverId == freezed
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: senderId == freezed
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
      booking: booking == freezed
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as BookingModel?,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as NotificationState?,
      userInfo: userInfo == freezed
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserInfoModel?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      userMessage: userMessage == freezed
          ? _value.userMessage
          : userMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationFydModel implements _NotificationFydModel {
  _$_NotificationFydModel(
      {this.id,
      @TimestampConverter() this.sendAt,
      @TimestampConverter() this.requestAt,
      this.seen = false,
      this.seenByReceiver = false,
      this.seenBySender = false,
      this.receiverId,
      this.senderId,
      this.booking,
      this.state,
      this.userInfo,
      this.message,
      this.userMessage});

  factory _$_NotificationFydModel.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationFydModelFromJson(json);

  @override
  final String? id;
  @override
  @TimestampConverter()
  final DateTime? sendAt;
  @override
  @TimestampConverter()
  final DateTime? requestAt;
  @override
  @JsonKey()
  final bool seen;
  @override
  @JsonKey()
  final bool seenByReceiver;
  @override
  @JsonKey()
  final bool seenBySender;
  @override
  final String? receiverId;
  @override
  final String? senderId;
  @override
  final BookingModel? booking;
  @override
  final NotificationState? state;
  @override
  final UserInfoModel? userInfo;
  @override
  final String? message;
  @override
  final String? userMessage;

  @override
  String toString() {
    return 'NotificationFydModel(id: $id, sendAt: $sendAt, requestAt: $requestAt, seen: $seen, seenByReceiver: $seenByReceiver, seenBySender: $seenBySender, receiverId: $receiverId, senderId: $senderId, booking: $booking, state: $state, userInfo: $userInfo, message: $message, userMessage: $userMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotificationFydModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.sendAt, sendAt) &&
            const DeepCollectionEquality().equals(other.requestAt, requestAt) &&
            const DeepCollectionEquality().equals(other.seen, seen) &&
            const DeepCollectionEquality()
                .equals(other.seenByReceiver, seenByReceiver) &&
            const DeepCollectionEquality()
                .equals(other.seenBySender, seenBySender) &&
            const DeepCollectionEquality()
                .equals(other.receiverId, receiverId) &&
            const DeepCollectionEquality().equals(other.senderId, senderId) &&
            const DeepCollectionEquality().equals(other.booking, booking) &&
            const DeepCollectionEquality().equals(other.state, state) &&
            const DeepCollectionEquality().equals(other.userInfo, userInfo) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.userMessage, userMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(sendAt),
      const DeepCollectionEquality().hash(requestAt),
      const DeepCollectionEquality().hash(seen),
      const DeepCollectionEquality().hash(seenByReceiver),
      const DeepCollectionEquality().hash(seenBySender),
      const DeepCollectionEquality().hash(receiverId),
      const DeepCollectionEquality().hash(senderId),
      const DeepCollectionEquality().hash(booking),
      const DeepCollectionEquality().hash(state),
      const DeepCollectionEquality().hash(userInfo),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(userMessage));

  @JsonKey(ignore: true)
  @override
  _$$_NotificationFydModelCopyWith<_$_NotificationFydModel> get copyWith =>
      __$$_NotificationFydModelCopyWithImpl<_$_NotificationFydModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationFydModelToJson(
      this,
    );
  }
}

abstract class _NotificationFydModel implements NotificationFydModel {
  factory _NotificationFydModel(
      {final String? id,
      @TimestampConverter() final DateTime? sendAt,
      @TimestampConverter() final DateTime? requestAt,
      final bool seen,
      final bool seenByReceiver,
      final bool seenBySender,
      final String? receiverId,
      final String? senderId,
      final BookingModel? booking,
      final NotificationState? state,
      final UserInfoModel? userInfo,
      final String? message,
      final String? userMessage}) = _$_NotificationFydModel;

  factory _NotificationFydModel.fromJson(Map<String, dynamic> json) =
      _$_NotificationFydModel.fromJson;

  @override
  String? get id;
  @override
  @TimestampConverter()
  DateTime? get sendAt;
  @override
  @TimestampConverter()
  DateTime? get requestAt;
  @override
  bool get seen;
  @override
  bool get seenByReceiver;
  @override
  bool get seenBySender;
  @override
  String? get receiverId;
  @override
  String? get senderId;
  @override
  BookingModel? get booking;
  @override
  NotificationState? get state;
  @override
  UserInfoModel? get userInfo;
  @override
  String? get message;
  @override
  String? get userMessage;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationFydModelCopyWith<_$_NotificationFydModel> get copyWith =>
      throw _privateConstructorUsedError;
}
