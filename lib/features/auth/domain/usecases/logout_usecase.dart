import 'package:dartz/dartz.dart';
import 'package:skeleton_app/core/error/failure.dart';
import 'package:skeleton_app/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.logout();
  }
}
