// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_history_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AttendanceHistoryState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<AttendanceEntity> get records => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AttendanceHistoryStateCopyWith<AttendanceHistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceHistoryStateCopyWith<$Res> {
  factory $AttendanceHistoryStateCopyWith(AttendanceHistoryState value,
          $Res Function(AttendanceHistoryState) then) =
      _$AttendanceHistoryStateCopyWithImpl<$Res, AttendanceHistoryState>;
  @useResult
  $Res call(
      {bool isLoading, List<AttendanceEntity> records, String? errorMessage});
}

/// @nodoc
class _$AttendanceHistoryStateCopyWithImpl<$Res,
        $Val extends AttendanceHistoryState>
    implements $AttendanceHistoryStateCopyWith<$Res> {
  _$AttendanceHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? records = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      records: null == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<AttendanceEntity>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceHistoryStateImplCopyWith<$Res>
    implements $AttendanceHistoryStateCopyWith<$Res> {
  factory _$$AttendanceHistoryStateImplCopyWith(
          _$AttendanceHistoryStateImpl value,
          $Res Function(_$AttendanceHistoryStateImpl) then) =
      __$$AttendanceHistoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading, List<AttendanceEntity> records, String? errorMessage});
}

/// @nodoc
class __$$AttendanceHistoryStateImplCopyWithImpl<$Res>
    extends _$AttendanceHistoryStateCopyWithImpl<$Res,
        _$AttendanceHistoryStateImpl>
    implements _$$AttendanceHistoryStateImplCopyWith<$Res> {
  __$$AttendanceHistoryStateImplCopyWithImpl(
      _$AttendanceHistoryStateImpl _value,
      $Res Function(_$AttendanceHistoryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? records = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AttendanceHistoryStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      records: null == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<AttendanceEntity>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AttendanceHistoryStateImpl implements _AttendanceHistoryState {
  const _$AttendanceHistoryStateImpl(
      {this.isLoading = false,
      final List<AttendanceEntity> records = const <AttendanceEntity>[],
      this.errorMessage})
      : _records = records;

  @override
  @JsonKey()
  final bool isLoading;
  final List<AttendanceEntity> _records;
  @override
  @JsonKey()
  List<AttendanceEntity> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AttendanceHistoryState(isLoading: $isLoading, records: $records, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceHistoryStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._records, _records) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_records), errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceHistoryStateImplCopyWith<_$AttendanceHistoryStateImpl>
      get copyWith => __$$AttendanceHistoryStateImplCopyWithImpl<
          _$AttendanceHistoryStateImpl>(this, _$identity);
}

abstract class _AttendanceHistoryState implements AttendanceHistoryState {
  const factory _AttendanceHistoryState(
      {final bool isLoading,
      final List<AttendanceEntity> records,
      final String? errorMessage}) = _$AttendanceHistoryStateImpl;

  @override
  bool get isLoading;
  @override
  List<AttendanceEntity> get records;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceHistoryStateImplCopyWith<_$AttendanceHistoryStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
