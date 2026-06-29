import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hash_micro_presence_test/core/logging/app_logger.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/usecases/get_attendance_history_usecase.dart';

part 'attendance_history_cubit.freezed.dart';
part 'attendance_history_state.dart';

class AttendanceHistoryCubit extends Cubit<AttendanceHistoryState> {
  final GetAttendanceHistoryUseCase getHistoryUseCase;

  AttendanceHistoryCubit({required this.getHistoryUseCase})
    : super(const AttendanceHistoryState());

  Future<void> loadHistory() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await getHistoryUseCase();

    result.fold(
      (failure) {
        AppLogger.error('Load attendance history failed', failure.message);
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (records) {
        emit(state.copyWith(isLoading: false, records: records));
      },
    );
  }
}
