import 'package:dartz/dartz.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/location/data/datasources/location_geo_datasource.dart';
import 'package:hash_micro_presence_test/features/location/data/datasources/location_local_datasource.dart';
import 'package:hash_micro_presence_test/features/location/data/models/location_model.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/geo_position.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';
import 'package:hash_micro_presence_test/features/location/domain/repositories/location_repository.dart';
import 'package:uuid/uuid.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource localDataSource;
  final LocationGeoDataSource geoDataSource;

  LocationRepositoryImpl(this.localDataSource, this.geoDataSource);

  static const _uuid = Uuid();

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocations() async {
    try {
      final models = await localDataSource.getLocations();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> getLocationById(String id) async {
    try {
      final model = await localDataSource.getLocationById(id);
      if (model == null) {
        return const Left(CacheFailure(message: 'Lokasi tidak ditemukan.'));
      }
      return Right(model.toEntity());
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> saveLocation(
    LocationEntity location,
  ) async {
    try {
      final now = DateTime.now();
      final isNew = location.id.isEmpty;

      final entity = location.copyWith(
        id: isNew ? _uuid.v4() : location.id,
        createdAt: location.createdAt ?? now,
        updatedAt: now,
      );

      await localDataSource.saveLocation(LocationModel.fromEntity(entity));
      return Right(entity);
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLocation(String id) async {
    try {
      await localDataSource.deleteLocation(id);
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  @override
  Future<Either<Failure, GeoPosition>> getCurrentPosition() async {
    try {
      final position = await geoDataSource.getCurrentPosition();
      return Right(position);
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }
}
