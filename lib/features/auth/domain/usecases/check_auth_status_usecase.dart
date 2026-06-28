import 'package:dartz/dartz.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/auth/domain/entities/user_entity.dart';
import 'package:hash_micro_presence_test/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthStatusUseCase {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  Future<Either<Failure, UserEntity?>> call() {
    return repository.checkAuthStatus();
  }
}
