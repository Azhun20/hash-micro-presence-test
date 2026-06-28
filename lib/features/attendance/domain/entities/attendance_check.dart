import 'package:equatable/equatable.dart';

/// Result of a radius check — a value object, not a persisted record.
///
/// There is no accepted/rejected status: only [withinRadius]. The "too far"
/// wording is built in the presentation layer, never stored.
class AttendanceCheck extends Equatable {
  const AttendanceCheck({
    required this.withinRadius,
    required this.distanceMeters,
    required this.radiusMeters,
    required this.userLat,
    required this.userLng,
    this.accuracyMeters,
  });

  /// True when the user is within [radiusMeters] of the pin (≤).
  final bool withinRadius;
  final double distanceMeters;
  final double radiusMeters;
  final double userLat;
  final double userLng;
  final double? accuracyMeters;

  @override
  List<Object?> get props => [
    withinRadius,
    distanceMeters,
    radiusMeters,
    userLat,
    userLng,
    accuracyMeters,
  ];
}
