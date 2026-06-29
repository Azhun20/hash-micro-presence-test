// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) {
  return _AttendanceModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceModel {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_id')
  String get locationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_name')
  String get locationName => throw _privateConstructorUsedError;
  @JsonKey(name: 'distance_meters')
  double get distanceMeters => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_lat')
  double get userLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_lng')
  double get userLng => throw _privateConstructorUsedError;
  @JsonKey(name: 'accuracy_meters')
  double? get accuracyMeters => throw _privateConstructorUsedError;
  @JsonKey(name: 'note')
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(name: 'timestamp')
  String get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceModelCopyWith<AttendanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceModelCopyWith<$Res> {
  factory $AttendanceModelCopyWith(
          AttendanceModel value, $Res Function(AttendanceModel) then) =
      _$AttendanceModelCopyWithImpl<$Res, AttendanceModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'location_id') String locationId,
      @JsonKey(name: 'location_name') String locationName,
      @JsonKey(name: 'distance_meters') double distanceMeters,
      @JsonKey(name: 'user_lat') double userLat,
      @JsonKey(name: 'user_lng') double userLng,
      @JsonKey(name: 'accuracy_meters') double? accuracyMeters,
      @JsonKey(name: 'note') String? note,
      @JsonKey(name: 'timestamp') String timestamp});
}

/// @nodoc
class _$AttendanceModelCopyWithImpl<$Res, $Val extends AttendanceModel>
    implements $AttendanceModelCopyWith<$Res> {
  _$AttendanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? locationId = null,
    Object? locationName = null,
    Object? distanceMeters = null,
    Object? userLat = null,
    Object? userLng = null,
    Object? accuracyMeters = freezed,
    Object? note = freezed,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: null == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String,
      locationName: null == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      userLat: null == userLat
          ? _value.userLat
          : userLat // ignore: cast_nullable_to_non_nullable
              as double,
      userLng: null == userLng
          ? _value.userLng
          : userLng // ignore: cast_nullable_to_non_nullable
              as double,
      accuracyMeters: freezed == accuracyMeters
          ? _value.accuracyMeters
          : accuracyMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceModelImplCopyWith<$Res>
    implements $AttendanceModelCopyWith<$Res> {
  factory _$$AttendanceModelImplCopyWith(_$AttendanceModelImpl value,
          $Res Function(_$AttendanceModelImpl) then) =
      __$$AttendanceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'location_id') String locationId,
      @JsonKey(name: 'location_name') String locationName,
      @JsonKey(name: 'distance_meters') double distanceMeters,
      @JsonKey(name: 'user_lat') double userLat,
      @JsonKey(name: 'user_lng') double userLng,
      @JsonKey(name: 'accuracy_meters') double? accuracyMeters,
      @JsonKey(name: 'note') String? note,
      @JsonKey(name: 'timestamp') String timestamp});
}

/// @nodoc
class __$$AttendanceModelImplCopyWithImpl<$Res>
    extends _$AttendanceModelCopyWithImpl<$Res, _$AttendanceModelImpl>
    implements _$$AttendanceModelImplCopyWith<$Res> {
  __$$AttendanceModelImplCopyWithImpl(
      _$AttendanceModelImpl _value, $Res Function(_$AttendanceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? locationId = null,
    Object? locationName = null,
    Object? distanceMeters = null,
    Object? userLat = null,
    Object? userLng = null,
    Object? accuracyMeters = freezed,
    Object? note = freezed,
    Object? timestamp = null,
  }) {
    return _then(_$AttendanceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: null == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String,
      locationName: null == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      userLat: null == userLat
          ? _value.userLat
          : userLat // ignore: cast_nullable_to_non_nullable
              as double,
      userLng: null == userLng
          ? _value.userLng
          : userLng // ignore: cast_nullable_to_non_nullable
              as double,
      accuracyMeters: freezed == accuracyMeters
          ? _value.accuracyMeters
          : accuracyMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceModelImpl extends _AttendanceModel {
  const _$AttendanceModelImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'location_id') required this.locationId,
      @JsonKey(name: 'location_name') required this.locationName,
      @JsonKey(name: 'distance_meters') required this.distanceMeters,
      @JsonKey(name: 'user_lat') required this.userLat,
      @JsonKey(name: 'user_lng') required this.userLng,
      @JsonKey(name: 'accuracy_meters') this.accuracyMeters,
      @JsonKey(name: 'note') this.note,
      @JsonKey(name: 'timestamp') required this.timestamp})
      : super._();

  factory _$AttendanceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'location_id')
  final String locationId;
  @override
  @JsonKey(name: 'location_name')
  final String locationName;
  @override
  @JsonKey(name: 'distance_meters')
  final double distanceMeters;
  @override
  @JsonKey(name: 'user_lat')
  final double userLat;
  @override
  @JsonKey(name: 'user_lng')
  final double userLng;
  @override
  @JsonKey(name: 'accuracy_meters')
  final double? accuracyMeters;
  @override
  @JsonKey(name: 'note')
  final String? note;
  @override
  @JsonKey(name: 'timestamp')
  final String timestamp;

  @override
  String toString() {
    return 'AttendanceModel(id: $id, locationId: $locationId, locationName: $locationName, distanceMeters: $distanceMeters, userLat: $userLat, userLng: $userLng, accuracyMeters: $accuracyMeters, note: $note, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.userLat, userLat) || other.userLat == userLat) &&
            (identical(other.userLng, userLng) || other.userLng == userLng) &&
            (identical(other.accuracyMeters, accuracyMeters) ||
                other.accuracyMeters == accuracyMeters) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, locationId, locationName,
      distanceMeters, userLat, userLng, accuracyMeters, note, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceModelImplCopyWith<_$AttendanceModelImpl> get copyWith =>
      __$$AttendanceModelImplCopyWithImpl<_$AttendanceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceModelImplToJson(
      this,
    );
  }
}

abstract class _AttendanceModel extends AttendanceModel {
  const factory _AttendanceModel(
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'location_id') required final String locationId,
      @JsonKey(name: 'location_name') required final String locationName,
      @JsonKey(name: 'distance_meters') required final double distanceMeters,
      @JsonKey(name: 'user_lat') required final double userLat,
      @JsonKey(name: 'user_lng') required final double userLng,
      @JsonKey(name: 'accuracy_meters') final double? accuracyMeters,
      @JsonKey(name: 'note') final String? note,
      @JsonKey(name: 'timestamp')
      required final String timestamp}) = _$AttendanceModelImpl;
  const _AttendanceModel._() : super._();

  factory _AttendanceModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'location_id')
  String get locationId;
  @override
  @JsonKey(name: 'location_name')
  String get locationName;
  @override
  @JsonKey(name: 'distance_meters')
  double get distanceMeters;
  @override
  @JsonKey(name: 'user_lat')
  double get userLat;
  @override
  @JsonKey(name: 'user_lng')
  double get userLng;
  @override
  @JsonKey(name: 'accuracy_meters')
  double? get accuracyMeters;
  @override
  @JsonKey(name: 'note')
  String? get note;
  @override
  @JsonKey(name: 'timestamp')
  String get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceModelImplCopyWith<_$AttendanceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
