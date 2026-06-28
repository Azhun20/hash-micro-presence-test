import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/usecases/verify_within_radius_usecase.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';

/// Returns a coordinate roughly [meters] north of [lat]/[lng]
/// (~111_320 m per degree of latitude).
({double lat, double lng}) _offsetNorth(double lat, double lng, double meters) {
  return (lat: lat + (meters / 111320.0), lng: lng);
}

void main() {
  final useCase = VerifyWithinRadiusUseCase();

  // radiusMeters defaults to 50.
  const pin = LocationEntity(
    id: 'pin-1',
    name: 'Kantor',
    latitude: -6.175392,
    longitude: 106.827153,
  );

  test('at the pin -> within radius, distance ~0', () {
    final result = useCase(
      userLat: pin.latitude,
      userLng: pin.longitude,
      accuracyMeters: 5,
      pin: pin,
    );

    expect(result.withinRadius, isTrue);
    expect(result.distanceMeters, lessThan(1));
  });

  test('exactly within radius boundary -> within radius (<=)', () {
    // ~49 m away, comfortably inside the 50 m radius.
    final p = _offsetNorth(pin.latitude, pin.longitude, 49);
    final result = useCase(
      userLat: p.lat,
      userLng: p.lng,
      accuracyMeters: 5,
      pin: pin,
    );

    expect(result.withinRadius, isTrue);
    expect(result.distanceMeters, closeTo(49, 2));
  });

  test('just outside radius -> not within radius', () {
    // ~60 m away, outside the 50 m radius.
    final p = _offsetNorth(pin.latitude, pin.longitude, 60);
    final result = useCase(
      userLat: p.lat,
      userLng: p.lng,
      accuracyMeters: 5,
      pin: pin,
    );

    expect(result.withinRadius, isFalse);
    expect(result.distanceMeters, greaterThan(50));
  });

  test('distance matches Geolocator.distanceBetween', () {
    final p = _offsetNorth(pin.latitude, pin.longitude, 100);
    final result = useCase(
      userLat: p.lat,
      userLng: p.lng,
      accuracyMeters: 5,
      pin: pin,
    );

    final expected = Geolocator.distanceBetween(
      p.lat,
      p.lng,
      pin.latitude,
      pin.longitude,
    );
    expect(result.distanceMeters, expected);
  });
}
