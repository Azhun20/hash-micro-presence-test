/// Formats a distance in meters into a friendly string: "42 m" or "1.3 km".
String formatDistance(double meters) {
  if (meters >= 1000) {
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }
  return '${meters.toStringAsFixed(0)} m';
}
