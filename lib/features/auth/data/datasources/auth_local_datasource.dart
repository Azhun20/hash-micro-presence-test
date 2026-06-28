import 'package:hash_micro_presence_test/constants/hive_constant.dart';
import 'package:hash_micro_presence_test/utils/services/hive_service.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(Map<String, dynamic> user);
  Future<void> saveTokens(String token, String refreshToken);
  Map<String, dynamic>? getUser();
  String? getToken();
  Future<void> clearAuth();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveService hiveService;

  AuthLocalDataSourceImpl(this.hiveService);

  @override
  Future<void> saveUser(Map<String, dynamic> user) async {
    await hiveService.put(HiveConstant.userKey, user);
  }

  @override
  Future<void> saveTokens(String token, String refreshToken) async {
    await hiveService.saveToken(token);
    await hiveService.saveRefreshToken(refreshToken);
  }

  @override
  Map<String, dynamic>? getUser() {
    // Hive returns Map<dynamic, dynamic>; rebuild it with string keys so the
    // direct cast to Map<String, dynamic> doesn't throw.
    final raw = hiveService.get<Map<dynamic, dynamic>>(HiveConstant.userKey);
    if (raw == null) return null;
    return Map<String, dynamic>.from(raw);
  }

  @override
  String? getToken() {
    return hiveService.token;
  }

  @override
  Future<void> clearAuth() async {
    await hiveService.clearAuth();
  }
}
