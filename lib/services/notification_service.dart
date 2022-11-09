import 'package:aula13_miscelaneous/models/custom_notification_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidNotificationDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('icon_app');

    await localNotificationsPlugin.initialize(
        const InitializationSettings(android: android),
        onSelectNotification: _onSelectNotification);
  }

  _onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      // Navigator.of(context).pushNamed(payload);
    }
  }

  showNotification(CustomNotification notification) {
    androidNotificationDetails = const AndroidNotificationDetails(
        'miscelaneous_n', 'miscelaneous_c',
        importance: Importance.max,
        priority: Priority.max,
        // sound: UriAndroidNotificationSound(""),
        enableVibration: true);

    localNotificationsPlugin.show(
        notification.id,
        notification.title,
        notification.body,
        NotificationDetails(android: androidNotificationDetails),
        payload: notification.payload);
  }

  scheduleNotification(CustomNotification notification) {
    final date = DateTime.now().add(const Duration(seconds: 5));
    androidNotificationDetails = const AndroidNotificationDetails(
        'miscelaneous_n', 'miscelaneous_c',
        importance: Importance.max,
        priority: Priority.max,
        enableVibration: true,
        );

    localNotificationsPlugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        tz.TZDateTime.from(date, tz.local),
        NotificationDetails(android: androidNotificationDetails),
        payload: notification.payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
  }
}
