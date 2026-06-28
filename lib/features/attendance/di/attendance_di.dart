import 'package:get_it/get_it.dart';
import 'package:hash_micro_presence_test/features/attendance/data/datasources/attendance_local_datasource.dart';
import 'package:hash_micro_presence_test/features/attendance/data/repositories/attendance_repository_impl.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/usecases/check_in_usecase.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/usecases/get_attendance_history_usecase.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/usecases/verify_within_radius_usecase.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/cubit/attendance_history_cubit.dart';
import 'package:hash_micro_presence_test/features/location/data/datasources/location_geo_datasource.dart';
import 'package:hash_micro_presence_test/features/location/domain/usecases/get_locations_usecase.dart';
import 'package:hash_micro_presence_test/utils/services/hive_service.dart';

/// Must be registered AFTER `LocationDI` — reuses GetLocationsUseCase and
/// LocationGeoDataSource from the location feature.
class AttendanceDI {
  static void inject(GetIt sl) {
    // Data source
    sl.registerLazySingleton<AttendanceLocalDataSource>(
      () => AttendanceLocalDataSourceImpl(sl<HiveService>()),
    );

    // Repository — GPS delegated to the location feature's geo data source.
    sl.registerLazySingleton<AttendanceRepository>(
      () => AttendanceRepositoryImpl(
        sl<AttendanceLocalDataSource>(),
        sl<LocationGeoDataSource>(),
      ),
    );

    // Use cases
    sl.registerLazySingleton<VerifyWithinRadiusUseCase>(
      () => VerifyWithinRadiusUseCase(),
    );
    sl.registerLazySingleton<CheckInUseCase>(
      () => CheckInUseCase(
        sl<AttendanceRepository>(),
        sl<VerifyWithinRadiusUseCase>(),
      ),
    );
    sl.registerLazySingleton<GetAttendanceHistoryUseCase>(
      () => GetAttendanceHistoryUseCase(sl<AttendanceRepository>()),
    );

    // Cubits — factory so each page visit gets a fresh instance.
    sl.registerFactory<AttendanceCubit>(
      () => AttendanceCubit(
        getLocationsUseCase: sl<GetLocationsUseCase>(),
        checkInUseCase: sl<CheckInUseCase>(),
      ),
    );
    sl.registerFactory<AttendanceHistoryCubit>(
      () => AttendanceHistoryCubit(
        getHistoryUseCase: sl<GetAttendanceHistoryUseCase>(),
      ),
    );
  }
}
