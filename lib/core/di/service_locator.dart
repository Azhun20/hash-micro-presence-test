import 'package:get_it/get_it.dart';
import 'package:hash_micro_presence_test/features/auth/di/auth_di.dart';
import 'package:hash_micro_presence_test/utils/services/api_service.dart';
import 'package:hash_micro_presence_test/utils/services/hive_service.dart';

final GetIt sl = GetIt.instance;

bool _isSetupComplete = false;

/// Setup all dependencies using GetIt service locator
Future<void> setupServiceLocator() async {
  // Prevent duplicate registration
  if (_isSetupComplete) return;

  // Register core services
  sl.registerLazySingleton<HiveService>(() => HiveService());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<HiveService>()));

  // Initialize Hive
  await sl<HiveService>().initHive();

  // Register features
  AuthDI.inject(sl);

  _isSetupComplete = true;
}
