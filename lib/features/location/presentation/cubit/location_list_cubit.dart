import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hash_micro_presence_test/core/logging/app_logger.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/delete_location_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/get_locations_usecase.dart';

part 'location_list_cubit.freezed.dart';
part 'location_list_state.dart';

class LocationListCubit extends Cubit<LocationListState> {
  final GetLocationsUseCase getLocationsUseCase;
  final DeleteLocationUseCase deleteLocationUseCase;

  LocationListCubit({
    required this.getLocationsUseCase,
    required this.deleteLocationUseCase,
  }) : super(const LocationListState());

  Future<void> loadLocations() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await getLocationsUseCase();

    result.fold(
      (failure) {
        AppLogger.error('Load locations failed', failure.message);
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (locations) {
        emit(state.copyWith(isLoading: false, locations: locations));
      },
    );
  }

  Future<void> deleteLocation(String id) async {
    final result = await deleteLocationUseCase(id);

    result.fold(
      (failure) {
        AppLogger.error('Delete location failed', failure.message);
        emit(state.copyWith(errorMessage: failure.message));
      },
      (_) {
        final updated = state.locations
            .where((location) => location.id != id)
            .toList();
        emit(state.copyWith(locations: updated, deletedAt: DateTime.now()));
      },
    );
  }
}
