import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hash_micro_presence_test/configs/routes/route.dart';
import 'package:hash_micro_presence_test/constants/app_constant.dart';
import 'package:hash_micro_presence_test/core/di/service_locator.dart';
import 'package:hash_micro_presence_test/core/extensions/context_extensions.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/widgets/attendance_success_card.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/widgets/location_selector_widget.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/widgets/too_far_info_widget.dart';
import 'package:hash_micro_presence_test/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';
import 'package:hash_micro_presence_test/shared/widgets/custom_button_widget.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absensi'),
        actions: [
          IconButton(
            tooltip: 'Muat ulang lokasi',
            onPressed: () => context.read<AttendanceCubit>().loadLocations(),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: 'Riwayat',
            onPressed: () => context.push(Routes.attendanceHistory),
            icon: const Icon(Icons.history),
          ),
          IconButton(
            tooltip: 'Keluar',
            onPressed: () {
              sl<AuthCubit>().logout();
              context.go(Routes.login);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<AttendanceCubit, AttendanceState>(
        builder: (context, state) {
          if (state.isLoadingLocations && state.locations.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.locations.isEmpty) {
            return const _NoLocationsState();
          }

          final cubit = context.read<AttendanceCubit>();
          final pin = state.selectedLocation;

          return Column(
            children: [
              if (pin != null)
                SizedBox(
                  height: context.screenHeight * 0.34,
                  child: _AttendanceMap(pin: pin, state: state),
                ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocationSelectorWidget(
                        locations: state.locations,
                        selected: pin,
                        onChanged: cubit.selectLocation,
                      ),
                      const SizedBox(height: 16),
                      if (state.isPermissionDenied)
                        _PermissionBanner(
                          message:
                              state.errorMessage ??
                              'Izin lokasi dibutuhkan untuk absensi.',
                          onRetry: cubit.checkIn,
                        ),
                      if (state.lastRecord != null)
                        AttendanceSuccessCard(record: state.lastRecord!),
                      if (state.tooFarCheck != null)
                        TooFarInfoWidget(
                          check: state.tooFarCheck!,
                          onRetry: cubit.checkIn,
                          onDismiss: cubit.dismissInfo,
                        ),
                      const SizedBox(height: 16),
                      CustomButtonWidget.filled(
                        text: state.isCheckingIn
                            ? 'Mengambil lokasi...'
                            : 'Absen Sekarang',
                        expanded: true,
                        isLoading: state.isCheckingIn,
                        onPressed: pin == null || state.isCheckingIn
                            ? null
                            : cubit.checkIn,
                        prefixIcon: const Icon(
                          Icons.fingerprint,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AttendanceMap extends StatelessWidget {
  const _AttendanceMap({required this.pin, required this.state});

  final LocationEntity pin;
  final AttendanceState state;

  @override
  Widget build(BuildContext context) {
    final pinLatLng = LatLng(pin.latitude, pin.longitude);

    // Show the user's last reading (success or too-far) so the distance is
    // visually obvious.
    final userCheck = state.tooFarCheck;
    final userRecord = state.lastRecord;
    LatLng? userLatLng;
    if (userRecord != null) {
      userLatLng = LatLng(userRecord.userLat, userRecord.userLng);
    } else if (userCheck != null) {
      userLatLng = LatLng(userCheck.userLat, userCheck.userLng);
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: pinLatLng,
        zoom: AppConstant.defaultMapZoom,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      // Zoom controls (+/- buttons) and pinch-to-zoom are on by default.
      markers: {
        Marker(markerId: const MarkerId('pin'), position: pinLatLng),
        if (userLatLng != null)
          Marker(
            markerId: const MarkerId('user'),
            position: userLatLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure,
            ),
          ),
      },
      circles: {
        Circle(
          circleId: const CircleId('radius'),
          center: pinLatLng,
          radius: pin.radiusMeters,
          fillColor: context.primary500.withValues(alpha: 0.15),
          strokeColor: context.primary500,
          strokeWidth: 2,
        ),
      },
    );
  }
}

class _PermissionBanner extends StatelessWidget {
  const _PermissionBanner({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
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
            style: context.body3Regular.copyWith(color: context.neutral500),
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

class _NoLocationsState extends StatelessWidget {
  const _NoLocationsState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off_outlined,
              size: 72,
              color: context.neutral100,
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada lokasi',
              style: context.body1SemiBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Minta admin menambahkan lokasi terlebih dahulu sebelum melakukan absensi.',
              style: context.body3Regular.copyWith(color: context.neutral400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
