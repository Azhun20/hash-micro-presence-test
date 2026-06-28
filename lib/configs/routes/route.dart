/// Application routes
class Routes {
  Routes._();

  // Auth routes
  static const String splash = '/';
  static const String login = '/login';

  // Main routes
  static const String dashboard = '/dashboard';

  // Location routes (admin only)
  static const String locations = '/locations';
  static const String locationForm = '/locations/form';

  // Attendance routes (user) — placeholder until Plan 2.
  static const String attendance = '/attendance';
}
