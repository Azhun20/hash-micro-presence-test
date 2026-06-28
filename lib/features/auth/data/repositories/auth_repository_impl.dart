import 'package:dartz/dartz.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/auth/data/datasources/auth_credential_datasource.dart';
import 'package:hash_micro_presence_test/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hash_micro_presence_test/features/auth/data/models/user_model.dart';
import 'package:hash_micro_presence_test/features/auth/domain/entities/user_entity.dart';
import 'package:hash_micro_presence_test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthCredentialDataSource credentialDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.credentialDataSource, this.localDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      // Validate against local hardcoded accounts (no backend).
      final userJson = credentialDataSource.authenticate(email, password);
      final user = UserModel.fromJson(userJson);

      // Issue a simple local session token so checkAuthStatus() keeps working.
      final token = 'local-${user.id}-${DateTime.now().millisecondsSinceEpoch}';

      await localDataSource.saveUser(userJson);
      await localDataSource.saveTokens(token, token);

      return Right(user.toEntity());
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearAuth();
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> checkAuthStatus() async {
    try {
      final token = localDataSource.getToken();
      if (token == null) {
        return const Right(null);
      }

      final userData = localDataSource.getUser();
      if (userData == null) {
        return const Right(null);
      }

      final user = UserModel.fromJson(userData);
      return Right(user.toEntity());
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }
}
