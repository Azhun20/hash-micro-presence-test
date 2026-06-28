import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_check.dart';
import 'package:hash_micro_presence_test/features/attendance/domain/entities/attendance_entity.dart';

/// A normal check-in result. Not a `Failure` — being "too far" is a valid
/// outcome, not an error. GPS/permission problems still flow through Left.
sealed class CheckInOutcome {
  const CheckInOutcome();
}

/// User was within radius → [record] was saved.
class CheckInSuccess extends CheckInOutcome {
  const CheckInSuccess(this.record);
  final AttendanceEntity record;
}

/// User was outside radius → nothing saved, only distance info.
class CheckInTooFar extends CheckInOutcome {
  const CheckInTooFar(this.check);
  final AttendanceCheck check;
}
