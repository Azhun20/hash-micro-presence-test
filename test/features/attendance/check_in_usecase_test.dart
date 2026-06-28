import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/check_in_outcome.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/usecases/check_in_usecase.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/usecases/verify_within_radius_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/geo_position.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';

/// Hand-rolled fake repository — no mock library needed.
class _FakeAttendanceRepository implements AttendanceRepository {
  _FakeAttendanceRepository(this._position);

  final Either<Failure, GeoPosition> _position;
  int saveCallCount = 0;

  @override
  Future<Either<Failure, GeoPosition>> getCurrentPosition() async => _position;

  @override
  Future<Either<Failure, AttendanceEntity>> saveAttendance(
    AttendanceEntity record,
  ) async {
    saveCallCount++;
    return Right(record);
  }

  @override
  Future<Either<Failure, List<AttendanceEntity>>> getHistory() async =>
      const Right([]);
}

void main() {
  // radiusMeters defaults to 50.
  const pin = LocationEntity(
    id: 'pin-1',
    name: 'Kantor',
    latitude: -6.175392,
    longitude: 106.827153,
  );

  GeoPosition near() =>
      GeoPosition(latitude: pin.latitude, longitude: pin.longitude);

  GeoPosition far() => GeoPosition(
    latitude: pin.latitude + (200 / 111320.0), // ~200 m north
    longitude: pin.longitude,
  );

  final verify = VerifyWithinRadiusUseCase();

  test('within radius -> success outcome and saveAttendance called once', () async {
    final repo = _FakeAttendanceRepository(Right(near()));
    final useCase = CheckInUseCase(repo, verify);

    final result = await useCase(pin);

    expect(result.isRight(), isTrue);
    final outcome = result.getOrElse(() => throw Exception());
    expect(outcome, isA<CheckInSuccess>());
    expect(repo.saveCallCount, 1);
  });

  test('outside radius -> tooFar outcome and saveAttendance NOT called', () async {
    final repo = _FakeAttendanceRepository(Right(far()));
    final useCase = CheckInUseCase(repo, verify);

    final result = await useCase(pin);

    expect(result.isRight(), isTrue);
    final outcome = result.getOrElse(() => throw Exception());
    expect(outcome, isA<CheckInTooFar>());
    expect(repo.saveCallCount, 0);
  });

  test('GPS failure -> Left(Failure), nothing saved', () async {
    final repo = _FakeAttendanceRepository(
      const Left(LocationFailure(message: 'GPS off')),
    );
    final useCase = CheckInUseCase(repo, verify);

    final result = await useCase(pin);

    expect(result.isLeft(), isTrue);
    expect(repo.saveCallCount, 0);
  });
}
