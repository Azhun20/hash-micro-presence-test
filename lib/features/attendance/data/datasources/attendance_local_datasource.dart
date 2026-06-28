import 'package:hash_micro_presence_test/features/attendance/data/models/attendance_model.dart';
import 'package:hash_micro_presence_test/utils/services/hive_service.dart';

abstract class AttendanceLocalDataSource {
  Future<void> saveAttendance(AttendanceModel model);
  Future<List<AttendanceModel>> getHistory();
}

class AttendanceLocalDataSourceImpl implements AttendanceLocalDataSource {
  final HiveService hiveService;

  AttendanceLocalDataSourceImpl(this.hiveService);

  @override
  Future<void> saveAttendance(AttendanceModel model) async {
    await hiveService.attendanceBox.put(model.id, model.toJson());
  }

  @override
  Future<List<AttendanceModel>> getHistory() async {
    final models = hiveService.attendanceBox.values
        .map((raw) => AttendanceModel.fromJson(_asStringKeyedMap(raw)))
        .toList();

    // Newest first.
    models.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return models;
  }

  /// Hive returns `Map<dynamic, dynamic>`; json_serializable needs string keys.
  Map<String, dynamic> _asStringKeyedMap(Map<dynamic, dynamic> raw) {
    return Map<String, dynamic>.from(raw);
  }
}
