part of 'attendance_history_cubit.dart';

@freezed
class AttendanceHistoryState with _$AttendanceHistoryState {
  const factory AttendanceHistoryState({
    @Default(false) bool isLoading,
    @Default(<AttendanceEntity>[]) List<AttendanceEntity> records,
    String? errorMessage,
  }) = _AttendanceHistoryState;
}
