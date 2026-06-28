import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/cubit/attendance_history_cubit.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/widgets/attendance_history_tile.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';

class AttendanceHistoryPage extends StatelessWidget {
  const AttendanceHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Absensi')),
      body: BlocBuilder<AttendanceHistoryCubit, AttendanceHistoryState>(
        builder: (context, state) {
          if (state.isLoading && state.records.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.records.isEmpty) {
            return _EmptyState();
          }

          return RefreshIndicator(
            onRefresh: () =>
                context.read<AttendanceHistoryCubit>().loadHistory(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.records.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12, left: 4),
                    child: Text(
                      '${state.records.length} absensi berhasil',
                      style: context.body3Medium.copyWith(
                        color: context.neutral400,
                      ),
                    ),
                  );
                }
                return AttendanceHistoryTile(record: state.records[index - 1]);
              },
            ),
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 72, color: context.neutral100),
            const SizedBox(height: 16),
            Text(
              'Belum ada riwayat',
              style: context.body1SemiBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Absensi yang berhasil akan tampil di sini.',
              style: context.body3Regular.copyWith(color: context.neutral400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
