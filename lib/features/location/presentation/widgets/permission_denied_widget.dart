import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hash_micro_presence_test/shared/widgets/custom_button_widget.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';

/// Inline banner shown when location permission/service is unavailable.
class PermissionDeniedWidget extends StatelessWidget {
  const PermissionDeniedWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.warning50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.warning200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_off, color: context.warning700),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Lokasi tidak tersedia',
                  style: context.body2SemiBold.copyWith(
                    color: context.warning900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: context.body3Regular.copyWith(color: context.neutral400),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CustomButtonWidget.outlined(
                  text: 'Coba Lagi',
                  onPressed: onRetry,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButtonWidget.filled(
                  text: 'Buka Pengaturan',
                  onPressed: () => Geolocator.openAppSettings(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
