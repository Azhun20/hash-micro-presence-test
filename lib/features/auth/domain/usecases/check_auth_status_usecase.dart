import 'package:dartz/dartz.dart';
import 'package:skeleton_app/core/error/failure.dart';
import 'package:skeleton_app/features/auth/domain/entities/user_entity.dart';
import 'package:skeleton_app/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthStatusUseCase {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  Future<Either<Failure, UserEntity?>> call() {
    return repository.checkAuthStatus();
  }
}
