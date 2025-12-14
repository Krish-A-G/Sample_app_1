import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    await _plugin.initialize(
      const InitializationSettings(android: android),
    );
  }

  static Future<void> showLowAttendance(
      String subject,
      double percent,
      ) async {
    const details = AndroidNotificationDetails(
      'attendance_alerts',
      'Attendance Alerts',
      importance: Importance.high,
      priority: Priority.high,
    );

    await _plugin.show(
      subject.hashCode,
      'Low Attendance Alert',
      '$subject attendance is '
          '${percent.toStringAsFixed(1)}%',
      const NotificationDetails(android: details),
    );
  }
}
