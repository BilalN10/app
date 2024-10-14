// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bookingmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) {
  return _BookingModel.fromJson(json);
}

/// @nodoc
mixin _$BookingModel {
  String? get id => throw _privateConstructorUsedError;
  String? get productId => throw _privateConstructorUsedError;
  String? get productName => throw _privateConstructorUsedError;
  String? get creatorId => throw _privateConstructorUsedError;
  String? get requestorId => throw _privateConstructorUsedError;
  BookingState? get state => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get bookingDate => throw _privateConstructorUsedError;
  bool get historic => throw _privateConstructorUsedError;
  UserInfoModel? get creatorInfo => throw _privateConstructorUsedError;
  UserInfoModel? get requestorInfo => throw _privateConstructorUsedError;
  String? get userMessage => throw _privateConstructorUsedError;
  String? get robeNumberResearch => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get acceptDate => throw _privateConstructorUsedError;
  List<String>? get sizeList => throw _privateConstructorUsedError;
  List<String>? get typeList => throw _privateConstructorUsedError;
  @ListTimestampConverter()
  List<DateTime>? get slotList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingModelCopyWith<BookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingModelCopyWith<$Res> {
  factory $BookingModelCopyWith(
          BookingModel value, $Res Function(BookingModel) then) =
      _$BookingModelCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? productId,
      String? productName,
      String? creatorId,
      String? requestorId,
      BookingState? state,
      @TimestampConverter() DateTime? bookingDate,
      bool historic,
      UserInfoModel? creatorInfo,
      UserInfoModel? requestorInfo,
      String? userMessage,
      String? robeNumberResearch,
      @TimestampConverter() DateTime? acceptDate,
      List<String>? sizeList,
      List<String>? typeList,
      @ListTimestampConverter() List<DateTime>? slotList});

  $UserInfoModelCopyWith<$Res>? get creatorInfo;
  $UserInfoModelCopyWith<$Res>? get requestorInfo;
}

/// @nodoc
class _$BookingModelCopyWithImpl<$Res> implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._value, this._then);

  final BookingModel _value;
  // ignore: unused_field
  final $Res Function(BookingModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? productId = freezed,
    Object? productName = freezed,
    Object? creatorId = freezed,
    Object? requestorId = freezed,
    Object? state = freezed,
    Object? bookingDate = freezed,
    Object? historic = freezed,
    Object? creatorInfo = freezed,
    Object? requestorInfo = freezed,
    Object? userMessage = freezed,
    Object? robeNumberResearch = freezed,
    Object? acceptDate = freezed,
    Object? sizeList = freezed,
    Object? typeList = freezed,
    Object? slotList = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: productName == freezed
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorId: creatorId == freezed
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String?,
      requestorId: requestorId == freezed
          ? _value.requestorId
          : requestorId // ignore: cast_nullable_to_non_nullable
              as String?,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as BookingState?,
      bookingDate: bookingDate == freezed
          ? _value.bookingDate
          : bookingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      historic: historic == freezed
          ? _value.historic
          : historic // ignore: cast_nullable_to_non_nullable
              as bool,
      creatorInfo: creatorInfo == freezed
          ? _value.creatorInfo
          : creatorInfo // ignore: cast_nullable_to_non_nullable
              as UserInfoModel?,
      requestorInfo: requestorInfo == freezed
          ? _value.requestorInfo
          : requestorInfo // ignore: cast_nullable_to_non_nullable
              as UserInfoModel?,
      userMessage: userMessage == freezed
          ? _value.userMessage
          : userMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      robeNumberResearch: robeNumberResearch == freezed
          ? _value.robeNumberResearch
          : robeNumberResearch // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptDate: acceptDate == freezed
          ? _value.acceptDate
          : acceptDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sizeList: sizeList == freezed
          ? _value.sizeList
          : sizeList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      typeList: typeList == freezed
          ? _value.typeList
          : typeList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      slotList: slotList == freezed
          ? _value.slotList
          : slotList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ));
  }

  @override
  $UserInfoModelCopyWith<$Res>? get creatorInfo {
    if (_value.creatorInfo == null) {
      return null;
    }

    return $UserInfoModelCopyWith<$Res>(_value.creatorInfo!, (value) {
      return _then(_value.copyWith(creatorInfo: value));
    });
  }

  @override
  $UserInfoModelCopyWith<$Res>? get requestorInfo {
    if (_value.requestorInfo == null) {
      return null;
    }

    return $UserInfoModelCopyWith<$Res>(_value.requestorInfo!, (value) {
      return _then(_value.copyWith(requestorInfo: value));
    });
  }
}

/// @nodoc
abstract class _$$_BookingModelCopyWith<$Res>
    implements $BookingModelCopyWith<$Res> {
  factory _$$_BookingModelCopyWith(
          _$_BookingModel value, $Res Function(_$_BookingModel) then) =
      __$$_BookingModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? productId,
      String? productName,
      String? creatorId,
      String? requestorId,
      BookingState? state,
      @TimestampConverter() DateTime? bookingDate,
      bool historic,
      UserInfoModel? creatorInfo,
      UserInfoModel? requestorInfo,
      String? userMessage,
      String? robeNumberResearch,
      @TimestampConverter() DateTime? acceptDate,
      List<String>? sizeList,
      List<String>? typeList,
      @ListTimestampConverter() List<DateTime>? slotList});

  @override
  $UserInfoModelCopyWith<$Res>? get creatorInfo;
  @override
  $UserInfoModelCopyWith<$Res>? get requestorInfo;
}

/// @nodoc
class __$$_BookingModelCopyWithImpl<$Res>
    extends _$BookingModelCopyWithImpl<$Res>
    implements _$$_BookingModelCopyWith<$Res> {
  __$$_BookingModelCopyWithImpl(
      _$_BookingModel _value, $Res Function(_$_BookingModel) _then)
      : super(_value, (v) => _then(v as _$_BookingModel));

  @override
  _$_BookingModel get _value => super._value as _$_BookingModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? productId = freezed,
    Object? productName = freezed,
    Object? creatorId = freezed,
    Object? requestorId = freezed,
    Object? state = freezed,
    Object? bookingDate = freezed,
    Object? historic = freezed,
    Object? creatorInfo = freezed,
    Object? requestorInfo = freezed,
    Object? userMessage = freezed,
    Object? robeNumberResearch = freezed,
    Object? acceptDate = freezed,
    Object? sizeList = freezed,
    Object? typeList = freezed,
    Object? slotList = freezed,
  }) {
    return _then(_$_BookingModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: productName == freezed
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorId: creatorId == freezed
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String?,
      requestorId: requestorId == freezed
          ? _value.requestorId
          : requestorId // ignore: cast_nullable_to_non_nullable
              as String?,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as BookingState?,
      bookingDate: bookingDate == freezed
          ? _value.bookingDate
          : bookingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      historic: historic == freezed
          ? _value.historic
          : historic // ignore: cast_nullable_to_non_nullable
              as bool,
      creatorInfo: creatorInfo == freezed
          ? _value.creatorInfo
          : creatorInfo // ignore: cast_nullable_to_non_nullable
              as UserInfoModel?,
      requestorInfo: requestorInfo == freezed
          ? _value.requestorInfo
          : requestorInfo // ignore: cast_nullable_to_non_nullable
              as UserInfoModel?,
      userMessage: userMessage == freezed
          ? _value.userMessage
          : userMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      robeNumberResearch: robeNumberResearch == freezed
          ? _value.robeNumberResearch
          : robeNumberResearch // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptDate: acceptDate == freezed
          ? _value.acceptDate
          : acceptDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sizeList: sizeList == freezed
          ? _value._sizeList
          : sizeList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      typeList: typeList == freezed
          ? _value._typeList
          : typeList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      slotList: slotList == freezed
          ? _value._slotList
          : slotList // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BookingModel implements _BookingModel {
  _$_BookingModel(
      {this.id,
      this.productId,
      this.productName,
      this.creatorId,
      this.requestorId,
      this.state,
      @TimestampConverter() this.bookingDate,
      this.historic = false,
      this.creatorInfo,
      this.requestorInfo,
      this.userMessage,
      this.robeNumberResearch,
      @TimestampConverter() this.acceptDate,
      final List<String>? sizeList = const [],
      final List<String>? typeList = const [],
      @ListTimestampConverter() final List<DateTime>? slotList})
      : _sizeList = sizeList,
        _typeList = typeList,
        _slotList = slotList;

  factory _$_BookingModel.fromJson(Map<String, dynamic> json) =>
      _$$_BookingModelFromJson(json);

  @override
  final String? id;
  @override
  final String? productId;
  @override
  final String? productName;
  @override
  final String? creatorId;
  @override
  final String? requestorId;
  @override
  final BookingState? state;
  @override
  @TimestampConverter()
  final DateTime? bookingDate;
  @override
  @JsonKey()
  final bool historic;
  @override
  final UserInfoModel? creatorInfo;
  @override
  final UserInfoModel? requestorInfo;
  @override
  final String? userMessage;
  @override
  final String? robeNumberResearch;
  @override
  @TimestampConverter()
  final DateTime? acceptDate;
  final List<String>? _sizeList;
  @override
  @JsonKey()
  List<String>? get sizeList {
    final value = _sizeList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _typeList;
  @override
  @JsonKey()
  List<String>? get typeList {
    final value = _typeList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<DateTime>? _slotList;
  @override
  @ListTimestampConverter()
  List<DateTime>? get slotList {
    final value = _slotList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BookingModel(id: $id, productId: $productId, productName: $productName, creatorId: $creatorId, requestorId: $requestorId, state: $state, bookingDate: $bookingDate, historic: $historic, creatorInfo: $creatorInfo, requestorInfo: $requestorInfo, userMessage: $userMessage, robeNumberResearch: $robeNumberResearch, acceptDate: $acceptDate, sizeList: $sizeList, typeList: $typeList, slotList: $slotList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BookingModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.productId, productId) &&
            const DeepCollectionEquality()
                .equals(other.productName, productName) &&
            const DeepCollectionEquality().equals(other.creatorId, creatorId) &&
            const DeepCollectionEquality()
                .equals(other.requestorId, requestorId) &&
            const DeepCollectionEquality().equals(other.state, state) &&
            const DeepCollectionEquality()
                .equals(other.bookingDate, bookingDate) &&
            const DeepCollectionEquality().equals(other.historic, historic) &&
            const DeepCollectionEquality()
                .equals(other.creatorInfo, creatorInfo) &&
            const DeepCollectionEquality()
                .equals(other.requestorInfo, requestorInfo) &&
            const DeepCollectionEquality()
                .equals(other.userMessage, userMessage) &&
            const DeepCollectionEquality()
                .equals(other.robeNumberResearch, robeNumberResearch) &&
            const DeepCollectionEquality()
                .equals(other.acceptDate, acceptDate) &&
            const DeepCollectionEquality().equals(other._sizeList, _sizeList) &&
            const DeepCollectionEquality().equals(other._typeList, _typeList) &&
            const DeepCollectionEquality().equals(other._slotList, _slotList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(productId),
      const DeepCollectionEquality().hash(productName),
      const DeepCollectionEquality().hash(creatorId),
      const DeepCollectionEquality().hash(requestorId),
      const DeepCollectionEquality().hash(state),
      const DeepCollectionEquality().hash(bookingDate),
      const DeepCollectionEquality().hash(historic),
      const DeepCollectionEquality().hash(creatorInfo),
      const DeepCollectionEquality().hash(requestorInfo),
      const DeepCollectionEquality().hash(userMessage),
      const DeepCollectionEquality().hash(robeNumberResearch),
      const DeepCollectionEquality().hash(acceptDate),
      const DeepCollectionEquality().hash(_sizeList),
      const DeepCollectionEquality().hash(_typeList),
      const DeepCollectionEquality().hash(_slotList));

  @JsonKey(ignore: true)
  @override
  _$$_BookingModelCopyWith<_$_BookingModel> get copyWith =>
      __$$_BookingModelCopyWithImpl<_$_BookingModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookingModelToJson(
      this,
    );
  }
}

abstract class _BookingModel implements BookingModel {
  factory _BookingModel(
          {final String? id,
          final String? productId,
          final String? productName,
          final String? creatorId,
          final String? requestorId,
          final BookingState? state,
          @TimestampConverter() final DateTime? bookingDate,
          final bool historic,
          final UserInfoModel? creatorInfo,
          final UserInfoModel? requestorInfo,
          final String? userMessage,
          final String? robeNumberResearch,
          @TimestampConverter() final DateTime? acceptDate,
          final List<String>? sizeList,
          final List<String>? typeList,
          @ListTimestampConverter() final List<DateTime>? slotList}) =
      _$_BookingModel;

  factory _BookingModel.fromJson(Map<String, dynamic> json) =
      _$_BookingModel.fromJson;

  @override
  String? get id;
  @override
  String? get productId;
  @override
  String? get productName;
  @override
  String? get creatorId;
  @override
  String? get requestorId;
  @override
  BookingState? get state;
  @override
  @TimestampConverter()
  DateTime? get bookingDate;
  @override
  bool get historic;
  @override
  UserInfoModel? get creatorInfo;
  @override
  UserInfoModel? get requestorInfo;
  @override
  String? get userMessage;
  @override
  String? get robeNumberResearch;
  @override
  @TimestampConverter()
  DateTime? get acceptDate;
  @override
  List<String>? get sizeList;
  @override
  List<String>? get typeList;
  @override
  @ListTimestampConverter()
  List<DateTime>? get slotList;
  @override
  @JsonKey(ignore: true)
  _$$_BookingModelCopyWith<_$_BookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}
