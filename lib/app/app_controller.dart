import 'package:fittrack/features/dashboard/bloc/today_bloc.dart';
import 'package:fittrack/features/notifications/bloc/notification_bloc.dart';
import 'package:fittrack/features/notifications/data/notification_service.dart';
import 'package:fittrack/features/water/bloc/water_bloc.dart';

/// Orchestrates BLoCs and app-level logic.
class AppController {
  static final AppController _instance = AppController._internal();
  factory AppController() => _instance;
  AppController._internal();

  late final TodayBloc todayBloc;
  late final WaterBloc waterBloc;
  late final NotificationBloc notificationBloc;

  void initialize() {
    todayBloc = TodayBloc();
    waterBloc = WaterBloc();
    notificationBloc = NotificationBloc(NotificationService());

    todayBloc.add(LoadTodayPlan());
    waterBloc.add(LoadWater());
    notificationBloc.add(InitializeNotifications());
  }

  void refreshAll() {
    todayBloc.add(RefreshTodayPlan());
    waterBloc.add(LoadWater());
  }

  void addWater(int ml) {
    waterBloc.add(AddWater(ml));
  }

  void resetWater() {
    waterBloc.add(ResetWater());
  }

  void toggleWaterNotifications() {
    notificationBloc.add(ToggleWaterNotifications());
  }

  void toggleMealNotifications() {
    notificationBloc.add(ToggleMealNotifications());
  }

  void toggleGymNotifications(String workoutTitle) {
    notificationBloc.add(ToggleGymNotifications(workoutTitle));
  }

  void dispose() {
    todayBloc.close();
    waterBloc.close();
    notificationBloc.close();
  }
}
