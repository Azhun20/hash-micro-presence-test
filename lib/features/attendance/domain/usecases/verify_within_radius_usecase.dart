import 'package:geolocator/geolocator.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_check.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';

/// Pure radius check — no I/O, fully deterministic. This is the core rule:
/// distance ≤ pin.radiusMeters means the user may check in.
class VerifyWithinRadiusUseCase {
  AttendanceCheck call({
    required double userLat,
    required double userLng,
    required double accuracyMeters,
    required LocationEntity pin,
  }) {
    final distance = Geolocator.distanceBetween(
      userLat,
      userLng,
      pin.latitude,
      pin.longitude,
    );

    return AttendanceCheck(
      withinRadius: distance <= pin.radiusMeters,
      distanceMeters: distance,
      radiusMeters: pin.radiusMeters,
      userLat: userLat,
      userLng: userLng,
      accuracyMeters: accuracyMeters,
    );
  }
}
