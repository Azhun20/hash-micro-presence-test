import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/core/logging/app_logger.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_check.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/check_in_outcome.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/usecases/check_in_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/get_locations_usecase.dart';

part 'attendance_cubit.freezed.dart';
part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final GetLocationsUseCase getLocationsUseCase;
  final CheckInUseCase checkInUseCase;

  AttendanceCubit({
    required this.getLocationsUseCase,
    required this.checkInUseCase,
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
        // Keep the previously selected location if it still exists, else pick
        // the first so the map and button are immediately usable.
        final selected =
            state.selectedLocation ??
            (locations.isNotEmpty ? locations.first : null);
        emit(
          state.copyWith(
            isLoadingLocations: false,
            locations: locations,
            selectedLocation: selected,
          ),
        );
      },
    );
  }

  void selectLocation(LocationEntity location) {
    emit(
      state.copyWith(
        selectedLocation: location,
        lastRecord: null,
        tooFarCheck: null,
        errorMessage: null,
      ),
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
}
