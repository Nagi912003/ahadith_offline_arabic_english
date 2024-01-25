// import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';

class NotificationsServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('logo');

  void initialiseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // if (kDebugMode) {
    //   print('i\'m here trying sending notification');
    // }
    scheduleDailyNotifications('حديث اليوم', 'صل على نبينا محمد - \nلا تنسى أذكار الصباح و المساء', 5, 17);
  }

  void sendNotification(String title, String body) async{
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channel_id',
      'channel_name',

      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('birds_notification'),
      icon: 'logo',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      3,
      title,
      body,
      notificationDetails,
    );
  }

  void scheduleNotification(String title, String body) async{

    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: 'logo',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.periodicallyShow(4, title, body, RepeatInterval.daily
        , notificationDetails);
  }

  void scheduleDailyNotifications(String title, String body, int firstHour, int secondHour) async {
    // Initialize the timezone library
    tz.initializeTimeZones();

    // Get the local timezone
    tz.Location local = tz.getLocation(await FlutterNativeTimezone.getLocalTimezone());

    // Calculate the time for the notifications
    tz.TZDateTime now = tz.TZDateTime.now(local);
    // tz.TZDateTime scheduledTimeMorning = tz.TZDateTime(local, now.year, now.month, now.day, firstHour);
    tz.TZDateTime scheduledTimeEvening = tz.TZDateTime(local, now.year, now.month, now.day, firstHour);

    // Schedule the notifications
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: 'logo',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    // await _flutterLocalNotificationsPlugin.zonedSchedule(
    //   0, title, body, scheduledTimeMorning, notificationDetails,
    //   uiLocalNotificationDateInterpretation:
    //   UILocalNotificationDateInterpretation.absoluteTime,
    //   matchDateTimeComponents: DateTimeComponents.time,
    //   androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    // );
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      1, title, body, scheduledTimeEvening, notificationDetails,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  void stopNotification() async{
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

}
