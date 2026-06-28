import 'package:equatable/equatable.dart';

/// A saved location with a geotagged pin and an attendance radius.
class LocationEntity extends Equatable {
  const LocationEntity({
    required this.id,
    required this.name,
    this.address,
    required this.latitude,
    required this.longitude,
    this.radiusMeters = 50,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String? address;
  final double latitude;
  final double longitude;
  final double radiusMeters;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LocationEntity copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    double? radiusMeters,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LocationEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    latitude,
    longitude,
    radiusMeters,
    createdAt,
    updatedAt,
  ];
}
