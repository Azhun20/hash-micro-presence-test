import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

@freezed
class AttendanceModel with _$AttendanceModel {
  const AttendanceModel._();

  const factory AttendanceModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'location_id') required String locationId,
    @JsonKey(name: 'location_name') required String locationName,
    @JsonKey(name: 'distance_meters') required double distanceMeters,
    @JsonKey(name: 'user_lat') required double userLat,
    @JsonKey(name: 'user_lng') required double userLng,
    @JsonKey(name: 'accuracy_meters') double? accuracyMeters,
    @JsonKey(name: 'note') String? note,
    @JsonKey(name: 'timestamp') required String timestamp,
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      id: entity.id,
      locationId: entity.locationId,
      locationName: entity.locationName,
      distanceMeters: entity.distanceMeters,
      userLat: entity.userLat,
      userLng: entity.userLng,
      accuracyMeters: entity.accuracyMeters,
      note: entity.note,
      timestamp: entity.timestamp.toIso8601String(),
    );
  }

  AttendanceEntity toEntity() {
    return AttendanceEntity(
      id: id,
      locationId: locationId,
      locationName: locationName,
      distanceMeters: distanceMeters,
      userLat: userLat,
      userLng: userLng,
      accuracyMeters: accuracyMeters,
      note: note,
      timestamp: DateTime.tryParse(timestamp) ?? DateTime.now(),
    );
  }
}
