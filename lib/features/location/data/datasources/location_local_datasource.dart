import 'package:hash_micro_presence_test/features/location/data/models/location_model.dart';
import 'package:hash_micro_presence_test/utils/services/hive_service.dart';

abstract class LocationLocalDataSource {
  Future<List<LocationModel>> getLocations();
  Future<LocationModel?> getLocationById(String id);
  Future<void> saveLocation(LocationModel model);
  Future<void> deleteLocation(String id);
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  final HiveService hiveService;

  LocationLocalDataSourceImpl(this.hiveService);

  @override
  Future<List<LocationModel>> getLocations() async {
    final box = hiveService.locationBox;
    final models = box.values
        .map((raw) => LocationModel.fromJson(_asStringKeyedMap(raw)))
        .toList();

    // Newest first.
    models.sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
    return models;
  }

  @override
  Future<LocationModel?> getLocationById(String id) async {
    final raw = hiveService.locationBox.get(id);
    if (raw == null) return null;
    return LocationModel.fromJson(_asStringKeyedMap(raw));
  }

  @override
  Future<void> saveLocation(LocationModel model) async {
    await hiveService.locationBox.put(model.id, model.toJson());
  }

  @override
  Future<void> deleteLocation(String id) async {
    await hiveService.locationBox.delete(id);
  }

  /// Hive returns `Map<dynamic, dynamic>`; json_serializable needs string keys.
  Map<String, dynamic> _asStringKeyedMap(Map<dynamic, dynamic> raw) {
    return Map<String, dynamic>.from(raw);
  }
}
