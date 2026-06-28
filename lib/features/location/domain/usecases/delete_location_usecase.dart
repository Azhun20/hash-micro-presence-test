import 'package:dartz/dartz.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/location/domain/repositories/location_repository.dart';

class DeleteLocationUseCase {
  final LocationRepository repository;

  DeleteLocationUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteLocation(id);
  }
}
