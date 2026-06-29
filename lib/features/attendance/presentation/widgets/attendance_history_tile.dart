import 'package:flutter/material.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/utils/distance_format.dart';
import 'package:hash_micro_presence_test/utils/extensions/date_time_extenstion.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';

/// One successful attendance record in the history list.
class AttendanceHistoryTile extends StatelessWidget {
  const AttendanceHistoryTile({super.key, required this.record});

  final AttendanceEntity record;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.neutral0,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.neutral40),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.success50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.check_circle, color: context.success500),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.locationName,
                  style: context.body2SemiBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: context.success50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              formatDistance(record.distanceMeters),
              style: context.caption1SemiBold.copyWith(
                color: context.success700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
