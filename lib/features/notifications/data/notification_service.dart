import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const String waterChannelId = 'water_reminders';
  static const String waterChannelName = 'Water Reminders';
  static const String gymChannelId = 'gym_reminders';
  static const String gymChannelName = 'Gym Reminders';
  static const String mealChannelId = 'meal_reminders';
  static const String mealChannelName = 'Meal Reminders';

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    await _createChannels();
  }

  Future<void> _createChannels() async {
    const waterChannel = AndroidNotificationChannel(
      waterChannelId,
      waterChannelName,
      description: 'Reminders to drink water every hour',
      importance: Importance.high,
    );

    const gymChannel = AndroidNotificationChannel(
      gymChannelId,
      gymChannelName,
      description: 'Gym workout reminders',
      importance: Importance.high,
    );

    const mealChannel = AndroidNotificationChannel(
      mealChannelId,
      mealChannelName,
      description: 'Meal time reminders',
      importance: Importance.defaultImportance,
    );

    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(waterChannel);
    await androidPlugin?.createNotificationChannel(gymChannel);
    await androidPlugin?.createNotificationChannel(mealChannel);
  }

  void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap - can be used to navigate to specific screen
  }

  Future<void> scheduleWaterReminders() async {
    await cancelWaterReminders();

    final now = tz.TZDateTime.now(tz.local);

    for (int hour = 8; hour <= 22; hour++) {
      final scheduleTime = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        0,
      );

      final id = 100 + hour;

      await _plugin.zonedSchedule(
        id,
        '💧 Time to Drink Water!',
        'Stay on track — drink 250ml now. Goal: 3L/day',
        scheduleTime.isBefore(now)
            ? scheduleTime.add(const Duration(days: 1))
            : scheduleTime,
        NotificationDetails(
          android: AndroidNotificationDetails(
            waterChannelId,
            waterChannelName,
            channelDescription: 'Reminders to drink water',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  Future<void> cancelWaterReminders() async {
    for (int hour = 8; hour <= 22; hour++) {
      await _plugin.cancel(100 + hour);
    }
  }

  Future<void> scheduleGymReminder(String workoutTitle) async {
    await _plugin.cancel(200);

    final now = tz.TZDateTime.now(tz.local);
    var scheduleTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      17,
      30,
    );

    if (scheduleTime.isBefore(now)) {
      scheduleTime = scheduleTime.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      200,
      '🏋️ Gym Time in 30 mins!',
      'Today: $workoutTitle — Don\'t skip! 💪',
      scheduleTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          gymChannelId,
          gymChannelName,
          channelDescription: 'Gym reminder',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleMealReminders() async {
    await cancelMealReminders();

    final mealTimes = [
      {'id': 301, 'hour': 8, 'min': 0, 'title': '🥤 Morning Shake Time', 'body': 'Start your day with protein — whey + milk + banana'},
      {'id': 302, 'hour': 13, 'min': 0, 'title': '🍽️ Lunch Time!', 'body': 'Biggest meal of the day — load up on protein & carbs'},
      {'id': 303, 'hour': 18, 'min': 0, 'title': '💪 Pre-Workout Shake', 'body': 'Fuel up before gym — whey shake now!'},
      {'id': 304, 'hour': 21, 'min': 0, 'title': '🍽️ Post-Workout Dinner', 'body': 'Recovery meal — eat within 1 hr of workout'},
    ];

    final now = tz.TZDateTime.now(tz.local);

    for (final meal in mealTimes) {
      var scheduleTime = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        meal['hour'] as int,
        meal['min'] as int,
      );

      if (scheduleTime.isBefore(now)) {
        scheduleTime = scheduleTime.add(const Duration(days: 1));
      }

      await _plugin.zonedSchedule(
        meal['id'] as int,
        meal['title'] as String,
        meal['body'] as String,
        scheduleTime,
        NotificationDetails(
          android: AndroidNotificationDetails(
            mealChannelId,
            mealChannelName,
            channelDescription: 'Meal reminder',
            importance: Importance.defaultImportance,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  Future<void> cancelMealReminders() async {
    for (int id in [301, 302, 303, 304]) {
      await _plugin.cancel(id);
    }
  }

  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          waterChannelId,
          waterChannelName,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> requestPermissions() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();
  }
}
