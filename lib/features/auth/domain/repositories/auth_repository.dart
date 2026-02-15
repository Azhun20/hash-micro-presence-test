import 'package:dartz/dartz.dart';
import 'package:skeleton_app/core/error/failure.dart';
import 'package:skeleton_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity?>> checkAuthStatus();
}
