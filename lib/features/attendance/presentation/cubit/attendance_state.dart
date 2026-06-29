part of 'attendance_cubit.dart';

@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState({
    @Default(false) bool isLoadingLocations,
    @Default(<LocationEntity>[]) List<LocationEntity> locations,
    LocationEntity? selectedLocation,
    @Default(false) bool isCheckingIn,
    // Waiting for the first live GPS fix.
    @Default(false) bool isLocating,
    // Continuous live distance/within-radius vs. the selected pin. Drives
    // whether the check-in button is enabled.
    AttendanceCheck? liveCheck,
    // Successful check-in (within radius).
    AttendanceEntity? lastRecord,
    // "Too far" info — not saved, only displayed then dismissed.
    AttendanceCheck? tooFarCheck,
    @Default(false) bool isPermissionDenied,
    String? errorMessage,
  }) = _AttendanceState;
}
