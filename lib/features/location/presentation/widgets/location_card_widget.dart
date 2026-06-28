import 'package:flutter/material.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';

class LocationCardWidget extends StatelessWidget {
  const LocationCardWidget({
    super.key,
    required this.location,
    required this.onTap,
    required this.onDelete,
  });

  final LocationEntity location;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final coordinates =
        '${location.latitude.toStringAsFixed(6)}, '
        '${location.longitude.toStringAsFixed(6)}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.neutral0,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.neutral40),
        boxShadow: [
          BoxShadow(
            color: context.neutral900.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.primary50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.location_on, color: context.primary500),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(location.name, style: context.body1SemiBold),
                    if (location.address?.isNotEmpty ?? false) ...[
                      const SizedBox(height: 2),
                      Text(
                        location.address!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.body3Regular.copyWith(
                          color: context.neutral400,
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.my_location,
                          size: 14,
                          color: context.neutral300,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            coordinates,
                            style: context.caption1Regular.copyWith(
                              color: context.neutral300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: context.info50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Radius ${location.radiusMeters.toStringAsFixed(0)} m',
                        style: context.caption1Medium.copyWith(
                          color: context.info700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete_outline, color: context.danger500),
                tooltip: 'Hapus lokasi',
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
