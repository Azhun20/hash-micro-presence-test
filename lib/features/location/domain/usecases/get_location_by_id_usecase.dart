import 'package:dartz/dartz.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';
import 'package:hash_micro_presence_test/features/location/domain/repositories/location_repository.dart';

class GetLocationByIdUseCase {
  final LocationRepository repository;

  GetLocationByIdUseCase(this.repository);

  Future<Either<Failure, LocationEntity>> call(String id) {
    return repository.getLocationById(id);
  }
}
