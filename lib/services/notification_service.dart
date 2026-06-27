import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const _prefEnabled = 'notif_daily_enabled';
const _prefHour = 'notif_daily_hour';
const _prefMinute = 'notif_daily_minute';
const _dailyNotifId = 42;
const _channelId = 'daily_reminder';
const _channelName = 'Daily Reminders';

@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {}

class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();

  bool _enabled = false;
  int _hour = 9;
  int _minute = 0;

  bool get isDailyReminderEnabled => _enabled;
  int get reminderHour => _hour;
  int get reminderMinute => _minute;

  Future<void> init() async {
    tz.initializeTimeZones();
    try {
      final tzInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(tzInfo.identifier));
    } catch (_) {}

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(settings: const InitializationSettings(android: androidInit));

    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool(_prefEnabled) ?? false;
    _hour = prefs.getInt(_prefHour) ?? 9;
    _minute = prefs.getInt(_prefMinute) ?? 0;

    await _initFirebaseMessaging();

    if (_enabled) {
      await _scheduleDailyNotification();
    }
  }

  Future<void> _initFirebaseMessaging() async {
    try {
      FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        FirebaseMessaging.onMessage.listen(_showFcmNotification);
      }
    } catch (_) {}
  }

  void _showFcmNotification(RemoteMessage message) {
    final n = message.notification;
    if (n == null) return;
    _plugin.show(
      id: 0,
      title: n.title,
      body: n.body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  Future<void> setDailyReminder({
    required bool enabled,
    int hour = 9,
    int minute = 0,
  }) async {
    _enabled = enabled;
    _hour = hour;
    _minute = minute;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefEnabled, enabled);
    await prefs.setInt(_prefHour, hour);
    await prefs.setInt(_prefMinute, minute);

    if (enabled) {
      await _scheduleDailyNotification();
    } else {
      await _plugin.cancel(id: _dailyNotifId);
    }
  }

  Future<void> _scheduleDailyNotification() async {
    await _plugin.cancel(id: _dailyNotifId);

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      _hour,
      _minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id: _dailyNotifId,
      title: 'Time to learn!',
      body: 'Continue your HTML & JavaScript journey — just 5 minutes today.',
      scheduledDate: scheduled,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: 'Daily learning reminder',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}

final notificationService = NotificationService();
