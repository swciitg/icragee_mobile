import 'package:icragee_mobile/shared/globals.dart';

DateTime getActualEventTime(DateTime time, int day) {
  final currDate = dayOneDate.add(Duration(days: day - 1));

  return currDate.copyWith(hour: time.hour, minute: time.minute);
}

DateTime getEventDateFromTimeAndDay(
    {required int hour, required int minute, required int day}) {
  final currDate = dayOneDate.add(Duration(days: day - 1));

  return currDate.copyWith(hour: hour, minute: minute);
}
