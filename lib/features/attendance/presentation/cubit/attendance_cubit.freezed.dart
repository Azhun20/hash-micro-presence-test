// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AttendanceState {
  bool get isLoadingLocations => throw _privateConstructorUsedError;
  List<LocationEntity> get locations => throw _privateConstructorUsedError;
  LocationEntity? get selectedLocation => throw _privateConstructorUsedError;
  bool get isCheckingIn =>
      throw _privateConstructorUsedError; // Successful check-in (within radius).
  AttendanceEntity? get lastRecord =>
      throw _privateConstructorUsedError; // "Too far" info — not saved, only displayed then dismissed.
  AttendanceCheck? get tooFarCheck => throw _privateConstructorUsedError;
  bool get isPermissionDenied => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AttendanceStateCopyWith<AttendanceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceStateCopyWith<$Res> {
  factory $AttendanceStateCopyWith(
          AttendanceState value, $Res Function(AttendanceState) then) =
      _$AttendanceStateCopyWithImpl<$Res, AttendanceState>;
  @useResult
  $Res call(
      {bool isLoadingLocations,
      List<LocationEntity> locations,
      LocationEntity? selectedLocation,
      bool isCheckingIn,
      AttendanceEntity? lastRecord,
      AttendanceCheck? tooFarCheck,
      bool isPermissionDenied,
      String? errorMessage});
}

/// @nodoc
class _$AttendanceStateCopyWithImpl<$Res, $Val extends AttendanceState>
    implements $AttendanceStateCopyWith<$Res> {
  _$AttendanceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoadingLocations = null,
    Object? locations = null,
    Object? selectedLocation = freezed,
    Object? isCheckingIn = null,
    Object? lastRecord = freezed,
    Object? tooFarCheck = freezed,
    Object? isPermissionDenied = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoadingLocations: null == isLoadingLocations
          ? _value.isLoadingLocations
          : isLoadingLocations // ignore: cast_nullable_to_non_nullable
              as bool,
      locations: null == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<LocationEntity>,
      selectedLocation: freezed == selectedLocation
          ? _value.selectedLocation
          : selectedLocation // ignore: cast_nullable_to_non_nullable
              as LocationEntity?,
      isCheckingIn: null == isCheckingIn
          ? _value.isCheckingIn
          : isCheckingIn // ignore: cast_nullable_to_non_nullable
              as bool,
      lastRecord: freezed == lastRecord
          ? _value.lastRecord
          : lastRecord // ignore: cast_nullable_to_non_nullable
              as AttendanceEntity?,
      tooFarCheck: freezed == tooFarCheck
          ? _value.tooFarCheck
          : tooFarCheck // ignore: cast_nullable_to_non_nullable
              as AttendanceCheck?,
      isPermissionDenied: null == isPermissionDenied
          ? _value.isPermissionDenied
          : isPermissionDenied // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceStateImplCopyWith<$Res>
    implements $AttendanceStateCopyWith<$Res> {
  factory _$$AttendanceStateImplCopyWith(_$AttendanceStateImpl value,
          $Res Function(_$AttendanceStateImpl) then) =
      __$$AttendanceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoadingLocations,
      List<LocationEntity> locations,
      LocationEntity? selectedLocation,
      bool isCheckingIn,
      AttendanceEntity? lastRecord,
      AttendanceCheck? tooFarCheck,
      bool isPermissionDenied,
      String? errorMessage});
}

/// @nodoc
class __$$AttendanceStateImplCopyWithImpl<$Res>
    extends _$AttendanceStateCopyWithImpl<$Res, _$AttendanceStateImpl>
    implements _$$AttendanceStateImplCopyWith<$Res> {
  __$$AttendanceStateImplCopyWithImpl(
      _$AttendanceStateImpl _value, $Res Function(_$AttendanceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoadingLocations = null,
    Object? locations = null,
    Object? selectedLocation = freezed,
    Object? isCheckingIn = null,
    Object? lastRecord = freezed,
    Object? tooFarCheck = freezed,
    Object? isPermissionDenied = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AttendanceStateImpl(
      isLoadingLocations: null == isLoadingLocations
          ? _value.isLoadingLocations
          : isLoadingLocations // ignore: cast_nullable_to_non_nullable
              as bool,
      locations: null == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<LocationEntity>,
      selectedLocation: freezed == selectedLocation
          ? _value.selectedLocation
          : selectedLocation // ignore: cast_nullable_to_non_nullable
              as LocationEntity?,
      isCheckingIn: null == isCheckingIn
          ? _value.isCheckingIn
          : isCheckingIn // ignore: cast_nullable_to_non_nullable
              as bool,
      lastRecord: freezed == lastRecord
          ? _value.lastRecord
          : lastRecord // ignore: cast_nullable_to_non_nullable
              as AttendanceEntity?,
      tooFarCheck: freezed == tooFarCheck
          ? _value.tooFarCheck
          : tooFarCheck // ignore: cast_nullable_to_non_nullable
              as AttendanceCheck?,
      isPermissionDenied: null == isPermissionDenied
          ? _value.isPermissionDenied
          : isPermissionDenied // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AttendanceStateImpl implements _AttendanceState {
  const _$AttendanceStateImpl(
      {this.isLoadingLocations = false,
      final List<LocationEntity> locations = const <LocationEntity>[],
      this.selectedLocation,
      this.isCheckingIn = false,
      this.lastRecord,
      this.tooFarCheck,
      this.isPermissionDenied = false,
      this.errorMessage})
      : _locations = locations;

  @override
  @JsonKey()
  final bool isLoadingLocations;
  final List<LocationEntity> _locations;
  @override
  @JsonKey()
  List<LocationEntity> get locations {
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  @override
  final LocationEntity? selectedLocation;
  @override
  @JsonKey()
  final bool isCheckingIn;
// Successful check-in (within radius).
  @override
  final AttendanceEntity? lastRecord;
// "Too far" info — not saved, only displayed then dismissed.
  @override
  final AttendanceCheck? tooFarCheck;
  @override
  @JsonKey()
  final bool isPermissionDenied;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AttendanceState(isLoadingLocations: $isLoadingLocations, locations: $locations, selectedLocation: $selectedLocation, isCheckingIn: $isCheckingIn, lastRecord: $lastRecord, tooFarCheck: $tooFarCheck, isPermissionDenied: $isPermissionDenied, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceStateImpl &&
            (identical(other.isLoadingLocations, isLoadingLocations) ||
                other.isLoadingLocations == isLoadingLocations) &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            (identical(other.selectedLocation, selectedLocation) ||
                other.selectedLocation == selectedLocation) &&
            (identical(other.isCheckingIn, isCheckingIn) ||
                other.isCheckingIn == isCheckingIn) &&
            (identical(other.lastRecord, lastRecord) ||
                other.lastRecord == lastRecord) &&
            (identical(other.tooFarCheck, tooFarCheck) ||
                other.tooFarCheck == tooFarCheck) &&
            (identical(other.isPermissionDenied, isPermissionDenied) ||
                other.isPermissionDenied == isPermissionDenied) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoadingLocations,
      const DeepCollectionEquality().hash(_locations),
      selectedLocation,
      isCheckingIn,
      lastRecord,
      tooFarCheck,
      isPermissionDenied,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceStateImplCopyWith<_$AttendanceStateImpl> get copyWith =>
      __$$AttendanceStateImplCopyWithImpl<_$AttendanceStateImpl>(
          this, _$identity);
}

abstract class _AttendanceState implements AttendanceState {
  const factory _AttendanceState(
      {final bool isLoadingLocations,
      final List<LocationEntity> locations,
      final LocationEntity? selectedLocation,
      final bool isCheckingIn,
      final AttendanceEntity? lastRecord,
      final AttendanceCheck? tooFarCheck,
      final bool isPermissionDenied,
      final String? errorMessage}) = _$AttendanceStateImpl;

  @override
  bool get isLoadingLocations;
  @override
  List<LocationEntity> get locations;
  @override
  LocationEntity? get selectedLocation;
  @override
  bool get isCheckingIn;
  @override // Successful check-in (within radius).
  AttendanceEntity? get lastRecord;
  @override // "Too far" info — not saved, only displayed then dismissed.
  AttendanceCheck? get tooFarCheck;
  @override
  bool get isPermissionDenied;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceStateImplCopyWith<_$AttendanceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
