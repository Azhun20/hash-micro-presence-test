import 'package:flutter_test/flutter_test.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/utils/distance_format.dart';

void main() {
  group('formatDistance', () {
    test('renders meters below 1 km', () {
      expect(formatDistance(42.4), '42 m');
      expect(formatDistance(0), '0 m');
    });

    test('renders kilometers at or above 1 km', () {
      expect(formatDistance(1000), '1.0 km');
      expect(formatDistance(1250), '1.3 km');
    });
  });
}
