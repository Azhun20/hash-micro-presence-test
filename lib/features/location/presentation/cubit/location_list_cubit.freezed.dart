// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocationListState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<LocationEntity> get locations => throw _privateConstructorUsedError;
  String? get errorMessage =>
      throw _privateConstructorUsedError; // Bumped whenever a delete succeeds so the view can show a confirmation.
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocationListStateCopyWith<LocationListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationListStateCopyWith<$Res> {
  factory $LocationListStateCopyWith(
          LocationListState value, $Res Function(LocationListState) then) =
      _$LocationListStateCopyWithImpl<$Res, LocationListState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<LocationEntity> locations,
      String? errorMessage,
      DateTime? deletedAt});
}

/// @nodoc
class _$LocationListStateCopyWithImpl<$Res, $Val extends LocationListState>
    implements $LocationListStateCopyWith<$Res> {
  _$LocationListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? locations = null,
    Object? errorMessage = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      locations: null == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<LocationEntity>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationListStateImplCopyWith<$Res>
    implements $LocationListStateCopyWith<$Res> {
  factory _$$LocationListStateImplCopyWith(_$LocationListStateImpl value,
          $Res Function(_$LocationListStateImpl) then) =
      __$$LocationListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<LocationEntity> locations,
      String? errorMessage,
      DateTime? deletedAt});
}

/// @nodoc
class __$$LocationListStateImplCopyWithImpl<$Res>
    extends _$LocationListStateCopyWithImpl<$Res, _$LocationListStateImpl>
    implements _$$LocationListStateImplCopyWith<$Res> {
  __$$LocationListStateImplCopyWithImpl(_$LocationListStateImpl _value,
      $Res Function(_$LocationListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? locations = null,
    Object? errorMessage = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$LocationListStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      locations: null == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<LocationEntity>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$LocationListStateImpl implements _LocationListState {
  const _$LocationListStateImpl(
      {this.isLoading = false,
      final List<LocationEntity> locations = const <LocationEntity>[],
      this.errorMessage,
      this.deletedAt})
      : _locations = locations;

  @override
  @JsonKey()
  final bool isLoading;
  final List<LocationEntity> _locations;
  @override
  @JsonKey()
  List<LocationEntity> get locations {
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  @override
  final String? errorMessage;
// Bumped whenever a delete succeeds so the view can show a confirmation.
  @override
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'LocationListState(isLoading: $isLoading, locations: $locations, errorMessage: $errorMessage, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationListStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_locations), errorMessage, deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationListStateImplCopyWith<_$LocationListStateImpl> get copyWith =>
      __$$LocationListStateImplCopyWithImpl<_$LocationListStateImpl>(
          this, _$identity);
}

abstract class _LocationListState implements LocationListState {
  const factory _LocationListState(
      {final bool isLoading,
      final List<LocationEntity> locations,
      final String? errorMessage,
      final DateTime? deletedAt}) = _$LocationListStateImpl;

  @override
  bool get isLoading;
  @override
  List<LocationEntity> get locations;
  @override
  String? get errorMessage;
  @override // Bumped whenever a delete succeeds so the view can show a confirmation.
  DateTime? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$LocationListStateImplCopyWith<_$LocationListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
