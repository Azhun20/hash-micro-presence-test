part of 'attendance_cubit.dart';

@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState({
    @Default(false) bool isLoadingLocations,
    @Default(<LocationEntity>[]) List<LocationEntity> locations,
    LocationEntity? selectedLocation,
    @Default(false) bool isCheckingIn,
    // Successful check-in (within radius).
    AttendanceEntity? lastRecord,
    // "Too far" info — not saved, only displayed then dismissed.
    AttendanceCheck? tooFarCheck,
    @Default(false) bool isPermissionDenied,
    String? errorMessage,
  }) = _AttendanceState;
}
