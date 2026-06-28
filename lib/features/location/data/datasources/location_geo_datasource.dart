import 'package:geolocator/geolocator.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/geo_position.dart';

abstract class LocationGeoDataSource {
  /// Reads the current high-accuracy GPS position.
  ///
  /// Throws `LocationServiceDisabledException` when GPS is off and
  /// `PermissionDeniedException` when the user denies (or permanently denies)
  /// location permission. Both are mapped to a `LocationFailure` upstream.
  Future<GeoPosition> getCurrentPosition();
}

class LocationGeoDataSourceImpl implements LocationGeoDataSource {
  @override
  Future<GeoPosition> getCurrentPosition() async {
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

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    return GeoPosition(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracyMeters: position.accuracy,
    );
  }
}
