import 'package:dartz/dartz.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/geo_position.dart';
import 'package:hash_micro_presence_test/features/location/domain/repositories/location_repository.dart';

class GetCurrentPositionUseCase {
  final LocationRepository repository;

  GetCurrentPositionUseCase(this.repository);

  Future<Either<Failure, GeoPosition>> call() {
    return repository.getCurrentPosition();
  }
}
