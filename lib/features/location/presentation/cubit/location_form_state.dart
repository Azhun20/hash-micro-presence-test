part of 'location_form_cubit.dart';

@freezed
class LocationFormState with _$LocationFormState {
  const factory LocationFormState({
    @Default(false) bool isLoading, // loading edit data / capturing GPS
    @Default(false) bool isSubmitting, // saving
    @Default(false) bool isSaved, // triggers pop + success message
    @Default(false) bool isEditMode,
    @Default(false) bool isPermissionDenied,
    String? editingId,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    @Default(AppConstant.defaultAttendanceRadiusMeters) double radiusMeters,
    DateTime? createdAt,
    // Bumped when GPS recenters the map so the view animates the camera.
    DateTime? cameraMovedAt,
    String? errorMessage,
  }) = _LocationFormState;
}
