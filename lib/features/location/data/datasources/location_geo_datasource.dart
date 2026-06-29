import 'package:geolocator/geolocator.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/geo_position.dart';

abstract class LocationGeoDataSource {
  /// Reads the current high-accuracy GPS position.
  ///
  /// Throws `LocationServiceDisabledException` when GPS is off and
  /// `PermissionDeniedException` when the user denies (or permanently denies)
  /// location permission. Both are mapped to a `LocationFailure` upstream.
  Future<GeoPosition> getCurrentPosition();

  /// Continuous stream of high-accuracy GPS positions for live tracking.
  /// Ensures permission/service first (errors propagate on the stream).
  Stream<GeoPosition> watchPosition();
}

class LocationGeoDataSourceImpl implements LocationGeoDataSource {
  @override
  Future<GeoPosition> getCurrentPosition() async {
    await _ensurePermission();

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    return _toGeoPosition(position);
  }

  @override
  Stream<GeoPosition> watchPosition() async* {
    await _ensurePermission();

    yield* Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 2, // emit on ~2 m movement
      ),
    ).map(_toGeoPosition);
  }

  /// Ensures location service is on and permission is granted, throwing the
  /// geolocator exceptions that map to a LocationFailure upstream.
  Future<void> _ensurePermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationServiceDisabledException();
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const PermissionDeniedException('Izin lokasi ditolak.');
    }
    if (permission == LocationPermission.deniedForever) {
      throw const PermissionDeniedException(
        'Izin lokasi ditolak permanen. Aktifkan dari pengaturan aplikasi.',
      );
    }
  }

  GeoPosition _toGeoPosition(Position position) {
    return GeoPosition(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracyMeters: position.accuracy,
    );
  }
}
