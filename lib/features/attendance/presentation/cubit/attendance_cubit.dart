import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/core/logging/app_logger.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_check.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/check_in_outcome.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/usecases/check_in_usecase.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/usecases/verify_within_radius_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/geo_position.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/get_locations_usecase.dart';

part 'attendance_cubit.freezed.dart';
part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final GetLocationsUseCase getLocationsUseCase;
  final CheckInUseCase checkInUseCase;
  final AttendanceRepository repository;
  final VerifyWithinRadiusUseCase verifyWithinRadius;

  StreamSubscription<GeoPosition>? _positionSub;

  AttendanceCubit({
    required this.getLocationsUseCase,
    required this.checkInUseCase,
    required this.repository,
    required this.verifyWithinRadius,
  }) : super(const AttendanceState());

  Future<void> loadLocations() async {
    emit(state.copyWith(isLoadingLocations: true, errorMessage: null));

    final result = await getLocationsUseCase();

    result.fold(
      (failure) {
        AppLogger.error('Load locations failed', failure.message);
        emit(
          state.copyWith(
            isLoadingLocations: false,
            errorMessage: failure.message,
          ),
        );
      },
      (locations) {
        // Re-resolve the selection from the freshly loaded list so edits to a
        // location (e.g. moved pin) are reflected instead of keeping a stale
        // copy. Falls back to the first location.
        LocationEntity? selected;
        final previousId = state.selectedLocation?.id;
        if (previousId != null) {
          for (final location in locations) {
            if (location.id == previousId) {
              selected = location;
              break;
            }
          }
        }
        selected ??= locations.isNotEmpty ? locations.first : null;

        emit(
          state.copyWith(
            isLoadingLocations: false,
            locations: locations,
            selectedLocation: selected,
          ),
        );

        if (selected != null) _startTracking();
      },
    );
  }

  void selectLocation(LocationEntity location) {
    emit(
      state.copyWith(
        selectedLocation: location,
        lastRecord: null,
        tooFarCheck: null,
        liveCheck: null,
        errorMessage: null,
      ),
    );
    _startTracking();
  }

  /// Subscribes to the GPS stream and continuously recomputes the live
  /// distance/within-radius against the selected pin. This is what lets the
  /// Absen button auto-enable only when the user is actually inside the radius.
  void _startTracking() {
    _positionSub?.cancel();
    emit(state.copyWith(isLocating: true, isPermissionDenied: false));

    _positionSub = repository.watchPosition().listen(
      (position) {
        final pin = state.selectedLocation;
        if (pin == null) return;

        final check = verifyWithinRadius(
          userLat: position.latitude,
          userLng: position.longitude,
          accuracyMeters: position.accuracyMeters,
          pin: pin,
        );
        emit(state.copyWith(isLocating: false, liveCheck: check));
      },
      onError: (Object error, StackTrace stackTrace) {
        final failure = mapExceptionToFailure(error, stackTrace);
        AppLogger.error('Live location tracking failed', failure.message);
        emit(
          state.copyWith(
            isLocating: false,
            isPermissionDenied: failure is LocationFailure,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> checkIn() async {
    final pin = state.selectedLocation;
    if (pin == null || state.isCheckingIn) return;

    emit(
      state.copyWith(
        isCheckingIn: true,
        errorMessage: null,
        isPermissionDenied: false,
        lastRecord: null,
        tooFarCheck: null,
      ),
    );

    final result = await checkInUseCase(pin);

    result.fold(
      (failure) {
        AppLogger.error('Check-in failed', failure.message);
        emit(
          state.copyWith(
            isCheckingIn: false,
            isPermissionDenied: failure is LocationFailure,
            errorMessage: failure.message,
          ),
        );
      },
      (outcome) {
        switch (outcome) {
          case CheckInSuccess(:final record):
            AppLogger.info(
              'check-in OK dist=${record.distanceMeters.toStringAsFixed(1)}m',
            );
            emit(state.copyWith(isCheckingIn: false, lastRecord: record));
          case CheckInTooFar(:final check):
            AppLogger.info(
              'check-in too-far dist=${check.distanceMeters.toStringAsFixed(1)}m',
            );
            emit(state.copyWith(isCheckingIn: false, tooFarCheck: check));
        }
      },
    );
  }

  void dismissInfo() {
    emit(state.copyWith(tooFarCheck: null, errorMessage: null));
  }

  /// Retry location tracking after a permission/service error.
  void retryTracking() => _startTracking();

  @override
  Future<void> close() {
    _positionSub?.cancel();
    return super.close();
  }
}
