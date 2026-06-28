import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hash_micro_presence_test/constants/app_constant.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/core/logging/app_logger.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/get_current_position_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/get_location_by_id_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/save_location_usecase.dart';

part 'location_form_cubit.freezed.dart';
part 'location_form_state.dart';

class LocationFormCubit extends Cubit<LocationFormState> {
  final SaveLocationUseCase saveLocationUseCase;
  final GetCurrentPositionUseCase getCurrentPositionUseCase;
  final GetLocationByIdUseCase getLocationByIdUseCase;

  LocationFormCubit({
    required this.saveLocationUseCase,
    required this.getCurrentPositionUseCase,
    required this.getLocationByIdUseCase,
  }) : super(const LocationFormState());

  /// Prepares the form. With [id] -> edit mode (loads existing location);
  /// without -> add mode (auto-captures current GPS for a sensible pin).
  Future<void> init(String? id) async {
    if (id == null || id.isEmpty) {
      emit(state.copyWith(isEditMode: false));
      await useCurrentLocation();
      return;
    }

    emit(state.copyWith(isLoading: true, isEditMode: true, editingId: id));
    final result = await getLocationByIdUseCase(id);

    result.fold(
      (failure) {
        AppLogger.error('Load location for edit failed', failure.message);
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (location) {
        emit(
          state.copyWith(
            isLoading: false,
            editingId: location.id,
            name: location.name,
            address: location.address,
            latitude: location.latitude,
            longitude: location.longitude,
            radiusMeters: location.radiusMeters,
            createdAt: location.createdAt,
          ),
        );
      },
    );
  }

  Future<void> useCurrentLocation() async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        isPermissionDenied: false,
      ),
    );

    final result = await getCurrentPositionUseCase();

    result.fold(
      (failure) {
        AppLogger.error('Get current position failed', failure.message);
        emit(
          state.copyWith(
            isLoading: false,
            isPermissionDenied: failure is LocationFailure,
            errorMessage: failure.message,
          ),
        );
      },
      (position) {
        emit(
          state.copyWith(
            isLoading: false,
            latitude: position.latitude,
            longitude: position.longitude,
            // New camera target so the view can recenter the map.
            cameraMovedAt: DateTime.now(),
          ),
        );
      },
    );
  }

  void onPinMoved(double latitude, double longitude) {
    emit(state.copyWith(latitude: latitude, longitude: longitude));
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onAddressChanged(String address) {
    emit(state.copyWith(address: address));
  }

  void onRadiusChanged(double radiusMeters) {
    emit(state.copyWith(radiusMeters: radiusMeters));
  }

  bool get _isValid =>
      (state.name?.trim().isNotEmpty ?? false) &&
      state.latitude != null &&
      state.longitude != null;

  Future<void> submit() async {
    if (!_isValid || state.isSubmitting) return;

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final entity = LocationEntity(
      id: state.editingId ?? '',
      name: state.name!.trim(),
      address: state.address?.trim(),
      latitude: state.latitude!,
      longitude: state.longitude!,
      radiusMeters: state.radiusMeters,
      createdAt: state.createdAt,
    );

    final result = await saveLocationUseCase(entity);

    result.fold(
      (failure) {
        AppLogger.error('Save location failed', failure.message);
        emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
      },
      (saved) {
        AppLogger.info('Location saved: ${saved.name}');
        emit(state.copyWith(isSubmitting: false, isSaved: true));
      },
    );
  }
}
