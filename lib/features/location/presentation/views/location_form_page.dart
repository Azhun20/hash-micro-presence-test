import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_micro_presence_test/core/extensions/context_extensions.dart';
import 'package:hash_micro_presence_test/features/location/presentation/cubit/location_form_cubit.dart';
import 'package:hash_micro_presence_test/features/location/presentation/widgets/location_map_picker_widget.dart';
import 'package:hash_micro_presence_test/features/location/presentation/widgets/permission_denied_widget.dart';
import 'package:hash_micro_presence_test/shared/widgets/custom_button_widget.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';
import 'package:hash_micro_presence_test/utils/functions/dialog_utils_function.dart';

class LocationFormPage extends StatefulWidget {
  const LocationFormPage({super.key});

  @override
  State<LocationFormPage> createState() => _LocationFormPageState();
}

class _LocationFormPageState extends State<LocationFormPage> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _sheetController = DraggableScrollableController();
  bool _controllersInitialized = false;
  bool _wasKeyboardOpen = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  /// Expand the sheet to its full size when the keyboard opens so the focused
  /// field is never hidden behind it, and collapse back to the default size
  /// when the keyboard closes.
  void _handleKeyboard(bool isKeyboardOpen) {
    if (isKeyboardOpen == _wasKeyboardOpen) return;
    _wasKeyboardOpen = isKeyboardOpen;
    if (!_sheetController.isAttached) return;

    _sheetController.animateTo(
      isKeyboardOpen ? 0.92 : 0.5,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  /// Seed text controllers once when edit data arrives.
  void _syncControllers(LocationFormState state) {
    if (_controllersInitialized) return;
    if (state.isEditMode && state.name != null) {
      _nameController.text = state.name ?? '';
      _addressController.text = state.address ?? '';
      _controllersInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationFormCubit, LocationFormState>(
      listenWhen: (prev, curr) =>
          prev.isSaved != curr.isSaved ||
          prev.errorMessage != curr.errorMessage,
      listener: (context, state) {
        _syncControllers(state);
        if (state.isSaved) {
          context.pop();
          DialogUtilsFunction.showSuccessSnackbar(
            context,
            message: 'Lokasi berhasil disimpan.',
          );
        } else if (state.errorMessage != null && !state.isPermissionDenied) {
          DialogUtilsFunction.showErrorSnackbar(
            context,
            message: state.errorMessage!,
          );
        }
      },
      builder: (context, state) {
        _syncControllers(state);
        final cubit = context.read<LocationFormCubit>();
        final hasCoordinates =
            state.latitude != null && state.longitude != null;
        final canSubmit =
            (state.name?.trim().isNotEmpty ?? false) &&
            hasCoordinates &&
            !state.isSubmitting;

        final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
        final isKeyboardOpen = keyboardInset > 0;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _handleKeyboard(isKeyboardOpen),
        );

        return Scaffold(
          // The map fills the screen; the form lives in a draggable sheet that
          // grows for the keyboard instead of squashing the map.
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(state.isEditMode ? 'Edit Lokasi' : 'Tambah Lokasi'),
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: LocationMapPickerWidget(
                  latitude: state.latitude,
                  longitude: state.longitude,
                  radiusMeters: state.radiusMeters,
                  isLocating: state.isLoading,
                  recenterToken: state.cameraMovedAt,
                  onPinMoved: cubit.onPinMoved,
                  onUseCurrentLocation: cubit.useCurrentLocation,
                ),
              ),
              DraggableScrollableSheet(
                controller: _sheetController,
                minChildSize: 0.28,
                maxChildSize: 0.92,
                snap: true,
                snapSizes: const [0.55, 0.92],
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.neutral900.withValues(alpha: 0.1),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.fromLTRB(
                        16,
                        8,
                        16,
                        20 + keyboardInset,
                      ),
                      children: [
                        const _SheetGrabHandle(),
                        if (state.isPermissionDenied) ...[
                          PermissionDeniedWidget(
                            message:
                                state.errorMessage ??
                                'Izin lokasi dibutuhkan untuk menandai titik.',
                            onRetry: cubit.useCurrentLocation,
                          ),
                          const SizedBox(height: 16),
                        ],
                        _CoordinateChip(
                          latitude: state.latitude,
                          longitude: state.longitude,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          controller: _nameController,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Nama Lokasi',
                            hintText: 'mis. Kantor Pusat',
                            prefixIcon: Icon(Icons.business),
                          ),
                          onChanged: cubit.onNameChanged,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          controller: _addressController,
                          maxLines: 2,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            labelText: 'Alamat (opsional)',
                            prefixIcon: Icon(Icons.place_outlined),
                          ),
                          onChanged: cubit.onAddressChanged,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Radius Absensi',
                              style: context.body2SemiBold,
                            ),
                            Text(
                              '${state.radiusMeters.toStringAsFixed(0)} m',
                              style: context.body2SemiBold.copyWith(
                                color: context.primary500,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: state.radiusMeters.clamp(10, 200),
                          min: 10,
                          max: 200,
                          divisions: 38,
                          label: '${state.radiusMeters.toStringAsFixed(0)} m',
                          onChanged: cubit.onRadiusChanged,
                        ),
                        const SizedBox(height: 16),
                        CustomButtonWidget.filled(
                          text: state.isEditMode
                              ? 'Simpan Perubahan'
                              : 'Simpan Lokasi',
                          expanded: true,
                          isLoading: state.isSubmitting,
                          onPressed: canSubmit ? cubit.submit : null,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SheetGrabHandle extends StatelessWidget {
  const _SheetGrabHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: context.neutral50,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _CoordinateChip extends StatelessWidget {
  const _CoordinateChip({this.latitude, this.longitude});

  final double? latitude;
  final double? longitude;

  @override
  Widget build(BuildContext context) {
    final hasCoordinates = latitude != null && longitude != null;
    final text = hasCoordinates
        ? '${latitude!.toStringAsFixed(6)}, ${longitude!.toStringAsFixed(6)}'
        : 'Tap peta atau gunakan GPS untuk menandai titik';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: hasCoordinates ? context.primary50 : context.neutral20,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.my_location,
            size: 18,
            color: hasCoordinates ? context.primary500 : context.neutral300,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: context.body3Medium.copyWith(
                color: hasCoordinates ? context.primary700 : context.neutral400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
