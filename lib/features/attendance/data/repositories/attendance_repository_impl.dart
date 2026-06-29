import 'package:dartz/dartz.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/attendance/data/datasources/attendance_local_datasource.dart';
import 'package:hash_micro_presence_test/features/attendance/data/models/attendance_model.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:hash_micro_presence_test/features/location/data/datasources/location_geo_datasource.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/geo_position.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceLocalDataSource localDataSource;
  final LocationGeoDataSource geoDataSource;

  AttendanceRepositoryImpl(this.localDataSource, this.geoDataSource);

  @override
  Future<Either<Failure, GeoPosition>> getCurrentPosition() async {
    try {
      final position = await geoDataSource.getCurrentPosition();
      return Right(position);
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  @override
  Stream<GeoPosition> watchPosition() => geoDataSource.watchPosition();

  @override
  Future<Either<Failure, AttendanceEntity>> saveAttendance(
    AttendanceEntity record,
  ) async {
    try {
      await localDataSource.saveAttendance(AttendanceModel.fromEntity(record));
      return Right(record);
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceEntity>>> getHistory() async {
    try {
      final models = await localDataSource.getHistory();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }
}
