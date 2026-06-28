import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hash_micro_presence_test/constants/app_constant.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';

/// A Google Map that lets the user place/adjust a pin (drag or tap) and shows
/// the attendance radius as a circle. [onPinMoved] fires with the new position.
class LocationMapPickerWidget extends StatefulWidget {
  const LocationMapPickerWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.radiusMeters,
    required this.onPinMoved,
    required this.onUseCurrentLocation,
    this.isLocating = false,
    this.recenterToken,
  });

  final double? latitude;
  final double? longitude;
  final double radiusMeters;
  final void Function(double lat, double lng) onPinMoved;
  final VoidCallback onUseCurrentLocation;
  final bool isLocating;

  /// Changes whenever the camera should recenter to [latitude]/[longitude]
  /// (e.g. after a GPS capture).
  final DateTime? recenterToken;

  @override
  State<LocationMapPickerWidget> createState() =>
      _LocationMapPickerWidgetState();
}

class _LocationMapPickerWidgetState extends State<LocationMapPickerWidget> {
  GoogleMapController? _controller;

  LatLng get _target => LatLng(
    widget.latitude ?? AppConstant.defaultMapLat,
    widget.longitude ?? AppConstant.defaultMapLng,
  );

  @override
  void didUpdateWidget(covariant LocationMapPickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.recenterToken != oldWidget.recenterToken &&
        widget.recenterToken != null) {
      _controller?.animateCamera(CameraUpdate.newLatLng(_target));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasPin = widget.latitude != null && widget.longitude != null;

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _target,
            zoom: AppConstant.defaultMapZoom,
          ),
          onMapCreated: (controller) => _controller = controller,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onTap: (pos) => widget.onPinMoved(pos.latitude, pos.longitude),
          markers: hasPin
              ? {
                  Marker(
                    markerId: const MarkerId('pin'),
                    position: _target,
                    draggable: true,
                    onDragEnd: (pos) =>
                        widget.onPinMoved(pos.latitude, pos.longitude),
                  ),
                }
              : {},
          circles: hasPin
              ? {
                  Circle(
                    circleId: const CircleId('radius'),
                    center: _target,
                    radius: widget.radiusMeters,
                    fillColor: context.primary500.withValues(alpha: 0.15),
                    strokeColor: context.primary500,
                    strokeWidth: 2,
                  ),
                }
              : {},
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: FloatingActionButton.extended(
            heroTag: 'useCurrentLocation',
            onPressed: widget.isLocating ? null : widget.onUseCurrentLocation,
            icon: widget.isLocating
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location),
            label: const Text('Gunakan lokasi saya'),
          ),
        ),
      ],
    );
  }
}
