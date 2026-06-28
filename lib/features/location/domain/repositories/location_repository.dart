import 'package:dartz/dartz.dart';
import 'package:hash_micro_presence_test/core/error/failure.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/geo_position.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<LocationEntity>>> getLocations();
  Future<Either<Failure, LocationEntity>> getLocationById(String id);

  /// Creates or updates a location and returns the persisted entity.
  Future<Either<Failure, LocationEntity>> saveLocation(LocationEntity location);

  Future<Either<Failure, void>> deleteLocation(String id);

  /// Geotagging: reads the current GPS position with high accuracy.
  Future<Either<Failure, GeoPosition>> getCurrentPosition();
}
