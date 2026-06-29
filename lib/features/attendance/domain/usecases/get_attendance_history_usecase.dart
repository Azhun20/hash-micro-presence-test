import 'package:dartz/dartz.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/repositories/attendance_repository.dart';

class GetAttendanceHistoryUseCase {
  final AttendanceRepository repository;

  GetAttendanceHistoryUseCase(this.repository);

  Future<Either<Failure, List<AttendanceEntity>>> call() {
    return repository.getHistory();
  }
}
