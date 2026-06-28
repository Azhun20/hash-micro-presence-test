import 'package:equatable/equatable.dart';

/// A raw GPS reading. [accuracyMeters] is the estimated horizontal accuracy.
class GeoPosition extends Equatable {
  const GeoPosition({
    required this.latitude,
    required this.longitude,
    this.accuracyMeters = 0,
  });

  final double latitude;
  final double longitude;
  final double accuracyMeters;

  @override
  List<Object?> get props => [latitude, longitude, accuracyMeters];
}
