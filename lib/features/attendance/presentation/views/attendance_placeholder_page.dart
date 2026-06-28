import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hash_micro_presence_test/configs/routes/route.dart';
import 'package:hash_micro_presence_test/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';

/// Temporary landing page for the `user` role. Replaced by the real attendance
/// feature in Plan 2.
class AttendancePlaceholderPage extends StatelessWidget {
  const AttendancePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absensi'),
        actions: [
          IconButton(
            tooltip: 'Keluar',
            onPressed: () {
              context.read<AuthCubit>().logout();
              context.go(Routes.login);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.primary50,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.fingerprint,
                  size: 56,
                  color: context.primary500,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Fitur Absensi',
                style: context.heading1SemiBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Halaman ini akan diisi fitur absensi (Plan 2).',
                style: context.body3Regular.copyWith(color: context.neutral400),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
