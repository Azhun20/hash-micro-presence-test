import 'package:dartz/dartz.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/check_in_outcome.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/usecases/verify_within_radius_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';
import 'package:uuid/uuid.dart';

/// Orchestrates a check-in: read GPS -> verify radius -> save ONLY if inside.
///
/// Returns a [CheckInOutcome] for the two valid cases (saved vs. too far);
/// GPS/permission problems are returned as `Left(Failure)`.
class CheckInUseCase {
  final AttendanceRepository repository;
  final VerifyWithinRadiusUseCase verify;

  CheckInUseCase(this.repository, this.verify);

  static const _uuid = Uuid();

  Future<Either<Failure, CheckInOutcome>> call(
    LocationEntity pin, {
    String? note,
  }) async {
    final posResult = await repository.getCurrentPosition();

    return posResult.fold(Left.new, (position) async {
      final check = verify(
        userLat: position.latitude,
        userLng: position.longitude,
        accuracyMeters: position.accuracyMeters,
        pin: pin,
      );

      // Outside radius -> save nothing, just return the distance info.
      if (!check.withinRadius) {
        return Right(CheckInTooFar(check));
      }

      // Inside radius -> persist the successful record.
      final record = AttendanceEntity(
        id: _uuid.v4(),
        locationId: pin.id,
        locationName: pin.name,
        distanceMeters: check.distanceMeters,
        userLat: check.userLat,
        userLng: check.userLng,
        accuracyMeters: check.accuracyMeters,
        note: note,
        timestamp: DateTime.now(),
      );

      final saved = await repository.saveAttendance(record);
      return saved.map<CheckInOutcome>(CheckInSuccess.new);
    });
  }
}
