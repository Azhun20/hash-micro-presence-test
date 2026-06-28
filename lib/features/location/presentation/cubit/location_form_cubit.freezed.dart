// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocationFormState {
  bool get isLoading =>
      throw _privateConstructorUsedError; // loading edit data / capturing GPS
  bool get isSubmitting => throw _privateConstructorUsedError; // saving
  bool get isSaved =>
      throw _privateConstructorUsedError; // triggers pop + success message
  bool get isEditMode => throw _privateConstructorUsedError;
  bool get isPermissionDenied => throw _privateConstructorUsedError;
  String? get editingId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double get radiusMeters => throw _privateConstructorUsedError;
  DateTime? get createdAt =>
      throw _privateConstructorUsedError; // Bumped when GPS recenters the map so the view animates the camera.
  DateTime? get cameraMovedAt => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocationFormStateCopyWith<LocationFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationFormStateCopyWith<$Res> {
  factory $LocationFormStateCopyWith(
          LocationFormState value, $Res Function(LocationFormState) then) =
      _$LocationFormStateCopyWithImpl<$Res, LocationFormState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isSubmitting,
      bool isSaved,
      bool isEditMode,
      bool isPermissionDenied,
      String? editingId,
      String? name,
      String? address,
      double? latitude,
      double? longitude,
      double radiusMeters,
      DateTime? createdAt,
      DateTime? cameraMovedAt,
      String? errorMessage});
}

/// @nodoc
class _$LocationFormStateCopyWithImpl<$Res, $Val extends LocationFormState>
    implements $LocationFormStateCopyWith<$Res> {
  _$LocationFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSubmitting = null,
    Object? isSaved = null,
    Object? isEditMode = null,
    Object? isPermissionDenied = null,
    Object? editingId = freezed,
    Object? name = freezed,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? radiusMeters = null,
    Object? createdAt = freezed,
    Object? cameraMovedAt = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditMode: null == isEditMode
          ? _value.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isPermissionDenied: null == isPermissionDenied
          ? _value.isPermissionDenied
          : isPermissionDenied // ignore: cast_nullable_to_non_nullable
              as bool,
      editingId: freezed == editingId
          ? _value.editingId
          : editingId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      radiusMeters: null == radiusMeters
          ? _value.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cameraMovedAt: freezed == cameraMovedAt
          ? _value.cameraMovedAt
          : cameraMovedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationFormStateImplCopyWith<$Res>
    implements $LocationFormStateCopyWith<$Res> {
  factory _$$LocationFormStateImplCopyWith(_$LocationFormStateImpl value,
          $Res Function(_$LocationFormStateImpl) then) =
      __$$LocationFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isSubmitting,
      bool isSaved,
      bool isEditMode,
      bool isPermissionDenied,
      String? editingId,
      String? name,
      String? address,
      double? latitude,
      double? longitude,
      double radiusMeters,
      DateTime? createdAt,
      DateTime? cameraMovedAt,
      String? errorMessage});
}

/// @nodoc
class __$$LocationFormStateImplCopyWithImpl<$Res>
    extends _$LocationFormStateCopyWithImpl<$Res, _$LocationFormStateImpl>
    implements _$$LocationFormStateImplCopyWith<$Res> {
  __$$LocationFormStateImplCopyWithImpl(_$LocationFormStateImpl _value,
      $Res Function(_$LocationFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSubmitting = null,
    Object? isSaved = null,
    Object? isEditMode = null,
    Object? isPermissionDenied = null,
    Object? editingId = freezed,
    Object? name = freezed,
    Object? address = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? radiusMeters = null,
    Object? createdAt = freezed,
    Object? cameraMovedAt = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$LocationFormStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditMode: null == isEditMode
          ? _value.isEditMode
          : isEditMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isPermissionDenied: null == isPermissionDenied
          ? _value.isPermissionDenied
          : isPermissionDenied // ignore: cast_nullable_to_non_nullable
              as bool,
      editingId: freezed == editingId
          ? _value.editingId
          : editingId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      radiusMeters: null == radiusMeters
          ? _value.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cameraMovedAt: freezed == cameraMovedAt
          ? _value.cameraMovedAt
          : cameraMovedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LocationFormStateImpl implements _LocationFormState {
  const _$LocationFormStateImpl(
      {this.isLoading = false,
      this.isSubmitting = false,
      this.isSaved = false,
      this.isEditMode = false,
      this.isPermissionDenied = false,
      this.editingId,
      this.name,
      this.address,
      this.latitude,
      this.longitude,
      this.radiusMeters = AppConstant.defaultAttendanceRadiusMeters,
      this.createdAt,
      this.cameraMovedAt,
      this.errorMessage});

  @override
  @JsonKey()
  final bool isLoading;
// loading edit data / capturing GPS
  @override
  @JsonKey()
  final bool isSubmitting;
// saving
  @override
  @JsonKey()
  final bool isSaved;
// triggers pop + success message
  @override
  @JsonKey()
  final bool isEditMode;
  @override
  @JsonKey()
  final bool isPermissionDenied;
  @override
  final String? editingId;
  @override
  final String? name;
  @override
  final String? address;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey()
  final double radiusMeters;
  @override
  final DateTime? createdAt;
// Bumped when GPS recenters the map so the view animates the camera.
  @override
  final DateTime? cameraMovedAt;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'LocationFormState(isLoading: $isLoading, isSubmitting: $isSubmitting, isSaved: $isSaved, isEditMode: $isEditMode, isPermissionDenied: $isPermissionDenied, editingId: $editingId, name: $name, address: $address, latitude: $latitude, longitude: $longitude, radiusMeters: $radiusMeters, createdAt: $createdAt, cameraMovedAt: $cameraMovedAt, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationFormStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.isEditMode, isEditMode) ||
                other.isEditMode == isEditMode) &&
            (identical(other.isPermissionDenied, isPermissionDenied) ||
                other.isPermissionDenied == isPermissionDenied) &&
            (identical(other.editingId, editingId) ||
                other.editingId == editingId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.radiusMeters, radiusMeters) ||
                other.radiusMeters == radiusMeters) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.cameraMovedAt, cameraMovedAt) ||
                other.cameraMovedAt == cameraMovedAt) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isSubmitting,
      isSaved,
      isEditMode,
      isPermissionDenied,
      editingId,
      name,
      address,
      latitude,
      longitude,
      radiusMeters,
      createdAt,
      cameraMovedAt,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationFormStateImplCopyWith<_$LocationFormStateImpl> get copyWith =>
      __$$LocationFormStateImplCopyWithImpl<_$LocationFormStateImpl>(
          this, _$identity);
}

abstract class _LocationFormState implements LocationFormState {
  const factory _LocationFormState(
      {final bool isLoading,
      final bool isSubmitting,
      final bool isSaved,
      final bool isEditMode,
      final bool isPermissionDenied,
      final String? editingId,
      final String? name,
      final String? address,
      final double? latitude,
      final double? longitude,
      final double radiusMeters,
      final DateTime? createdAt,
      final DateTime? cameraMovedAt,
      final String? errorMessage}) = _$LocationFormStateImpl;

  @override
  bool get isLoading;
  @override // loading edit data / capturing GPS
  bool get isSubmitting;
  @override // saving
  bool get isSaved;
  @override // triggers pop + success message
  bool get isEditMode;
  @override
  bool get isPermissionDenied;
  @override
  String? get editingId;
  @override
  String? get name;
  @override
  String? get address;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  double get radiusMeters;
  @override
  DateTime? get createdAt;
  @override // Bumped when GPS recenters the map so the view animates the camera.
  DateTime? get cameraMovedAt;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$LocationFormStateImplCopyWith<_$LocationFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
