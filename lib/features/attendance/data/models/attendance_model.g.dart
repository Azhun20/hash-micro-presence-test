// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceModelImpl _$$AttendanceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceModelImpl(
      id: json['id'] as String,
      locationId: json['location_id'] as String,
      locationName: json['location_name'] as String,
      distanceMeters: (json['distance_meters'] as num).toDouble(),
      userLat: (json['user_lat'] as num).toDouble(),
      userLng: (json['user_lng'] as num).toDouble(),
      accuracyMeters: (json['accuracy_meters'] as num?)?.toDouble(),
      note: json['note'] as String?,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$$AttendanceModelImplToJson(
        _$AttendanceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location_id': instance.locationId,
      'location_name': instance.locationName,
      'distance_meters': instance.distanceMeters,
      'user_lat': instance.userLat,
      'user_lng': instance.userLng,
      'accuracy_meters': instance.accuracyMeters,
      'note': instance.note,
      'timestamp': instance.timestamp,
    };
