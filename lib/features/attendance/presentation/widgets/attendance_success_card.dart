import 'package:flutter/material.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/utils/distance_format.dart';
import 'package:hash_micro_presence_test/utils/extensions/date_time_extenstion.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';

/// Green confirmation shown after a successful (within-radius) check-in.
class AttendanceSuccessCard extends StatelessWidget {
  const AttendanceSuccessCard({super.key, required this.record});

  final AttendanceEntity record;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.success50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.success200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.success500,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Absensi berhasil',
                  style: context.body2SemiBold.copyWith(
                    color: context.success700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${formatDistance(record.distanceMeters)} dari ${record.locationName}',
                  style: context.body3Regular.copyWith(
                    color: context.neutral500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  record.timestamp.toTimeWithDays(),
                  style: context.caption2Regular.copyWith(
                    color: context.neutral400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
