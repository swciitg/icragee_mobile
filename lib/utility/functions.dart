import 'package:icragee_mobile/shared/globals.dart';

DateTime getActualEventTime(DateTime time, int day) {
  final currDate = dayOneDate.add(Duration(days: day - 1));

  return currDate.copyWith(hour: time.hour, minute: time.minute);
}
