/// Domain-level application constants.
class AppConstant {
  AppConstant._();

  /// Default attendance radius in meters used when creating a new location.
  static const double defaultAttendanceRadiusMeters = 50;

  /// GPS readings less accurate than this (in meters) are flagged as unreliable
  /// so a "within 50 m" check stays meaningful.
  static const double minAcceptableAccuracyMeters = 50;

  /// Initial map camera position used before a GPS fix is available
  /// (Monas, Jakarta — a sensible default for this project).
  static const double defaultMapLat = -6.175392;
  static const double defaultMapLng = 106.827153;
  static const double defaultMapZoom = 16;
}
