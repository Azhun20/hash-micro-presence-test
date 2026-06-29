import 'package:flutter/material.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';

/// Dropdown to pick which saved pin to check in against.
class LocationSelectorWidget extends StatelessWidget {
  const LocationSelectorWidget({
    super.key,
    required this.locations,
    required this.selected,
    required this.onChanged,
  });

  final List<LocationEntity> locations;
  final LocationEntity? selected;
  final ValueChanged<LocationEntity> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Lokasi',
          style: context.body3SemiBold.copyWith(color: context.neutral500),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: context.neutral0,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.neutral40),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selected?.id,
              icon: Icon(Icons.expand_more, color: context.neutral300),
              hint: Text(
                'Pilih lokasi absensi',
                style: context.body2Regular.copyWith(
                  color: context.neutral200,
                ),
              ),
              items: locations
                  .map(
                    (loc) => DropdownMenuItem<String>(
                      value: loc.id,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 18,
                            color: context.primary500,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              loc.name,
                              overflow: TextOverflow.ellipsis,
                              style: context.body2Medium,
                            ),
                          ),
                          Text(
                            '${loc.radiusMeters.toStringAsFixed(0)} m',
                            style: context.caption2Regular.copyWith(
                              color: context.neutral300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (id) {
                if (id == null) return;
                final picked = locations.firstWhere((l) => l.id == id);
                onChanged(picked);
              },
            ),
          ),
        ),
      ],
    );
  }
}
