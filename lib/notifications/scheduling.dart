import 'package:schedulers/schedulers.dart';

void startScheduler(void Function() callback) {
  //Future.delayed(Duration(seconds: 5), callback);
  final scheduler = TimeScheduler();

  scheduler.run(() {
    final scheduler = IntervalScheduler(delay: const Duration(days: 1));
    scheduler.run(callback);
  }, getNextNotificationDate());
}

DateTime getNextNotificationDate() {
  var now = DateTime.now();
  var notificationDate = DateTime(now.year, now.month, now.day, 18);
  if (now.compareTo(notificationDate) < 0) {
    // notifica oggi
    return notificationDate;
  } else {
    // notifica domani
    return notificationDate.add(const Duration(days: 1));
  }
}
