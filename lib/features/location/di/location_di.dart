import 'package:get_it/get_it.dart';
import 'package:hash_micro_presence_test/features/location/data/datasources/location_geo_datasource.dart';
import 'package:hash_micro_presence_test/features/location/data/datasources/location_local_datasource.dart';
import 'package:hash_micro_presence_test/features/location/data/repositories/location_repository_impl.dart';
import 'package:hash_micro_presence_test/features/location/domain/repositories/location_repository.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/delete_location_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/get_current_position_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/get_location_by_id_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/get_locations_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/save_location_usecase.dart';
import 'package:hash_micro_presence_test/features/location/presentation/cubit/location_form_cubit.dart';
import 'package:hash_micro_presence_test/features/location/presentation/cubit/location_list_cubit.dart';
import 'package:hash_micro_presence_test/utils/services/hive_service.dart';

class LocationDI {
  static void inject(GetIt sl) {
    // Data sources
    sl.registerLazySingleton<LocationLocalDataSource>(
      () => LocationLocalDataSourceImpl(sl<HiveService>()),
    );
    sl.registerLazySingleton<LocationGeoDataSource>(
      () => LocationGeoDataSourceImpl(),
    );

    // Repository
    sl.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(
        sl<LocationLocalDataSource>(),
        sl<LocationGeoDataSource>(),
      ),
    );

    // Use cases
    sl.registerLazySingleton<GetLocationsUseCase>(
      () => GetLocationsUseCase(sl<LocationRepository>()),
    );
    sl.registerLazySingleton<GetLocationByIdUseCase>(
      () => GetLocationByIdUseCase(sl<LocationRepository>()),
    );
    sl.registerLazySingleton<SaveLocationUseCase>(
      () => SaveLocationUseCase(sl<LocationRepository>()),
    );
    sl.registerLazySingleton<DeleteLocationUseCase>(
      () => DeleteLocationUseCase(sl<LocationRepository>()),
    );
    sl.registerLazySingleton<GetCurrentPositionUseCase>(
      () => GetCurrentPositionUseCase(sl<LocationRepository>()),
    );

    // Cubits — factory so each page visit gets a fresh instance.
    sl.registerFactory<LocationListCubit>(
      () => LocationListCubit(
        getLocationsUseCase: sl<GetLocationsUseCase>(),
        deleteLocationUseCase: sl<DeleteLocationUseCase>(),
      ),
    );
    sl.registerFactory<LocationFormCubit>(
      () => LocationFormCubit(
        saveLocationUseCase: sl<SaveLocationUseCase>(),
        getCurrentPositionUseCase: sl<GetCurrentPositionUseCase>(),
        getLocationByIdUseCase: sl<GetLocationByIdUseCase>(),
      ),
    );
  }
}
