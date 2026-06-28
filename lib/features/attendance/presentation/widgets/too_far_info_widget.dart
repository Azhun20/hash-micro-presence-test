import 'package:flutter/material.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_check.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/utils/distance_format.dart';
import 'package:hash_micro_presence_test/shared/widgets/custom_button_widget.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';

/// Guidance (not an error) shown when the user is outside the radius. Uses a
/// warning palette — never red — and tells the user how much closer to get.
class TooFarInfoWidget extends StatelessWidget {
  const TooFarInfoWidget({
    super.key,
    required this.check,
    required this.onRetry,
    required this.onDismiss,
  });

  final AttendanceCheck check;
  final VoidCallback onRetry;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.warning50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.warning200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_searching, color: context.warning700),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Anda terlalu jauh dari lokasi',
                  style: context.body2SemiBold.copyWith(
                    color: context.warning900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Anda berada ${formatDistance(check.distanceMeters)} dari lokasi. '
            'Mendekatlah hingga ≤ ${check.radiusMeters.toStringAsFixed(0)} m '
            'untuk dapat melakukan absensi.',
            style: context.body3Regular.copyWith(color: context.neutral500),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CustomButtonWidget.outlined(
                  text: 'Tutup',
                  onPressed: onDismiss,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButtonWidget.filled(
                  text: 'Coba Lagi',
                  onPressed: onRetry,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
