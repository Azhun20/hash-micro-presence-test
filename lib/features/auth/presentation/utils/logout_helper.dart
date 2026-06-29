import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hash_micro_presence_test/configs/routes/route.dart';
import 'package:hash_micro_presence_test/core/di/service_locator.dart';
import 'package:hash_micro_presence_test/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hash_micro_presence_test/utils/functions/dialog_utils_function.dart';

/// Shows a confirmation dialog before logging out. On confirm, clears the
/// session and routes back to login.
Future<void> confirmLogout(BuildContext context) async {
  final confirmed = await DialogUtilsFunction.showConfirmationDialog(
    context,
    title: 'Keluar',
    subtitle: 'Apakah Anda yakin ingin keluar dari akun ini?',
    confirmText: 'Keluar',
    isNegativeConfirm: true,
  );

  if ((confirmed ?? false) && context.mounted) {
    await sl<AuthCubit>().logout();
    if (context.mounted) context.go(Routes.login);
  }
}
