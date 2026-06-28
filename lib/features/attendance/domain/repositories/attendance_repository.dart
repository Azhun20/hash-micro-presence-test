import 'package:dartz/dartz.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/geo_position.dart';

abstract class AttendanceRepository {
  /// Current GPS position (lat, lng, accuracy) — reuses the location feature's
  /// geolocator wrapper.
  Future<Either<Failure, GeoPosition>> getCurrentPosition();

  Future<Either<Failure, AttendanceEntity>> saveAttendance(
    AttendanceEntity record,
  );

  Future<Either<Failure, List<AttendanceEntity>>> getHistory();
}
