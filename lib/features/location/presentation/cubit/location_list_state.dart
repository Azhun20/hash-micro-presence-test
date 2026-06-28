part of 'location_list_cubit.dart';

@freezed
class LocationListState with _$LocationListState {
  const factory LocationListState({
    @Default(false) bool isLoading,
    @Default(<LocationEntity>[]) List<LocationEntity> locations,
    String? errorMessage,
    // Bumped whenever a delete succeeds so the view can show a confirmation.
    DateTime? deletedAt,
  }) = _LocationListState;
}
