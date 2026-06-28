import 'package:equatable/equatable.dart';

/// A persisted attendance record. Every stored record is, by definition, a
/// successful check-in (within radius) — there is no "rejected" record.
class AttendanceEntity extends Equatable {
  const AttendanceEntity({
    required this.id,
    required this.locationId,
    required this.locationName,
    required this.distanceMeters,
    required this.userLat,
    required this.userLng,
    this.accuracyMeters,
    this.note,
    required this.timestamp,
  });

  final String id;
  final String locationId;
  final String locationName;

  /// Distance (m) from the pin at the moment of a successful check-in (≤ radius).
  final double distanceMeters;
  final double userLat;
  final double userLng;
  final double? accuracyMeters;
  final String? note;
  final DateTime timestamp;

  @override
  List<Object?> get props => [
    id,
    locationId,
    locationName,
    distanceMeters,
    userLat,
    userLng,
    accuracyMeters,
    note,
    timestamp,
  ];
}
