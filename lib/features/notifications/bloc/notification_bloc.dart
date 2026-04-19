import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fittrack/features/notifications/data/notification_service.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeNotifications extends NotificationEvent {}

class ToggleWaterNotifications extends NotificationEvent {}

class ToggleGymNotifications extends NotificationEvent {
  final String workoutTitle;
  ToggleGymNotifications(this.workoutTitle);
  @override
  List<Object?> get props => [workoutTitle];
}

class ToggleMealNotifications extends NotificationEvent {}

class NotificationState extends Equatable {
  final bool waterEnabled;
  final bool gymEnabled;
  final bool mealEnabled;
  final bool isInitialized;

  const NotificationState({
    this.waterEnabled = true,
    this.gymEnabled = true,
    this.mealEnabled = true,
    this.isInitialized = false,
  });

  NotificationState copyWith({
    bool? waterEnabled,
    bool? gymEnabled,
    bool? mealEnabled,
    bool? isInitialized,
  }) {
    return NotificationState(
      waterEnabled: waterEnabled ?? this.waterEnabled,
      gymEnabled: gymEnabled ?? this.gymEnabled,
      mealEnabled: mealEnabled ?? this.mealEnabled,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  List<Object?> get props => [
    waterEnabled,
    gymEnabled,
    mealEnabled,
    isInitialized,
  ];
}

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationService _service;

  NotificationBloc(this._service) : super(const NotificationState()) {
    on<InitializeNotifications>(_onInit);
    on<ToggleWaterNotifications>(_onToggleWater);
    on<ToggleGymNotifications>(_onToggleGym);
    on<ToggleMealNotifications>(_onToggleMeal);
  }

  Future<void> _onInit(
    InitializeNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    await _service.initialize();
    await _service.requestPermissions();

    final prefs = await SharedPreferences.getInstance();
    final water = prefs.getBool('notif_water') ?? true;
    final gym = prefs.getBool('notif_gym') ?? true;
    final meal = prefs.getBool('notif_meal') ?? true;

    if (water) await _service.scheduleWaterReminders();
    if (meal) await _service.scheduleMealReminders();

    emit(
      state.copyWith(
        waterEnabled: water,
        gymEnabled: gym,
        mealEnabled: meal,
        isInitialized: true,
      ),
    );
  }

  Future<void> _onToggleWater(
    ToggleWaterNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    final newVal = !state.waterEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_water', newVal);

    if (newVal) {
      await _service.scheduleWaterReminders();
    } else {
      await _service.cancelWaterReminders();
    }

    emit(state.copyWith(waterEnabled: newVal));
  }

  Future<void> _onToggleGym(
    ToggleGymNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    final newVal = !state.gymEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_gym', newVal);

    if (newVal) {
      await _service.scheduleGymReminder(event.workoutTitle);
    } else {
      await _service.cancelWaterReminders();
    }

    emit(state.copyWith(gymEnabled: newVal));
  }

  Future<void> _onToggleMeal(
    ToggleMealNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    final newVal = !state.mealEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_meal', newVal);

    if (newVal) {
      await _service.scheduleMealReminders();
    } else {
      await _service.cancelMealReminders();
    }

    emit(state.copyWith(mealEnabled: newVal));
  }
}
