import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hash_micro_presence_test/configs/routes/route.dart';
import 'package:hash_micro_presence_test/core/di/service_locator.dart';
import 'package:hash_micro_presence_test/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hash_micro_presence_test/features/location/domain/entities/location_entity.dart';
import 'package:hash_micro_presence_test/features/location/presentation/cubit/location_list_cubit.dart';
import 'package:hash_micro_presence_test/features/location/presentation/widgets/location_card_widget.dart';
import 'package:hash_micro_presence_test/shared/widgets/custom_button_widget.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';
import 'package:hash_micro_presence_test/utils/functions/dialog_utils_function.dart';

class LocationListPage extends StatelessWidget {
  const LocationListPage({super.key});

  Future<void> _confirmDelete(
    BuildContext context,
    LocationEntity location,
  ) async {
    final confirmed = await DialogUtilsFunction.showConfirmationDialog(
      context,
      title: 'Hapus Lokasi',
      subtitle: 'Yakin ingin menghapus "${location.name}"?',
      confirmText: 'Hapus',
    );
    if ((confirmed ?? false) && context.mounted) {
      unawaited(context.read<LocationListCubit>().deleteLocation(location.id));
    }
  }

  Future<void> _openForm(BuildContext context, {String? id}) async {
    final path = id == null
        ? Routes.locationForm
        : '${Routes.locationForm}?id=$id';
    await context.push(path);
    if (context.mounted) {
      unawaited(context.read<LocationListCubit>().loadLocations());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Lokasi'),
        actions: [
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add_location_alt),
        label: const Text('Tambah Lokasi'),
      ),
      body: BlocConsumer<LocationListCubit, LocationListState>(
        listenWhen: (prev, curr) =>
            prev.deletedAt != curr.deletedAt ||
            prev.errorMessage != curr.errorMessage,
        listener: (context, state) {
          if (state.deletedAt != null) {
            DialogUtilsFunction.showSuccessSnackbar(
              context,
              message: 'Lokasi berhasil dihapus.',
            );
          }
          if (state.errorMessage != null) {
            DialogUtilsFunction.showErrorSnackbar(
              context,
              message: state.errorMessage!,
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.locations.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.locations.isEmpty) {
            return _EmptyState(onAdd: () => _openForm(context));
          }

          return RefreshIndicator(
            onRefresh: () => context.read<LocationListCubit>().loadLocations(),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              itemCount: state.locations.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12, left: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.place_outlined,
                          size: 16,
                          color: context.neutral300,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${state.locations.length} lokasi terdaftar',
                          style: context.body3Medium.copyWith(
                            color: context.neutral400,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                final location = state.locations[index - 1];
                return LocationCardWidget(
                  location: location,
                  onTap: () => _openForm(context, id: location.id),
                  onDelete: () => _confirmDelete(context, location),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

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
              'Tambahkan lokasi pertama Anda dan tandai titiknya dengan GPS.',
              style: context.body3Regular.copyWith(color: context.neutral400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomButtonWidget.filled(
              text: 'Tambah Lokasi',
              onPressed: onAdd,
              prefixIcon: const Icon(
                Icons.add_location_alt,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
