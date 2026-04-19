import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fittrack/features/notifications/data/notification_service.dart';
import 'package:fittrack/features/water/domain/water_model.dart';

abstract class WaterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWater extends WaterEvent {}

class AddWater extends WaterEvent {
  final int ml;
  AddWater(this.ml);
  @override
  List<Object?> get props => [ml];
}

class ResetWater extends WaterEvent {}

abstract class WaterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WaterLoading extends WaterState {}

class WaterLoaded extends WaterState {
  final WaterModel water;
  WaterLoaded(this.water);
  @override
  List<Object?> get props => [water];
}

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  static const String _key = 'water_ml_';
  static const int targetMl = 3000;

  WaterBloc() : super(WaterLoading()) {
    on<LoadWater>(_onLoad);
    on<AddWater>(_onAdd);
    on<ResetWater>(_onReset);
  }

  String get _todayKey {
    final now = DateTime.now();
    return '$_key${now.year}${now.month}${now.day}';
  }

  Future<void> _onLoad(LoadWater event, Emitter<WaterState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final currentMl = prefs.getInt(_todayKey) ?? 0;

    emit(
      WaterLoaded(
        WaterModel(
          targetMl: targetMl,
          currentMl: currentMl,
          date: DateTime.now(),
          entries: [],
        ),
      ),
    );
  }

  Future<void> _onAdd(AddWater event, Emitter<WaterState> emit) async {
    final current = state as WaterLoaded;
    final newMl = current.water.currentMl + event.ml;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_todayKey, newMl);

    if (newMl >= targetMl && current.water.currentMl < targetMl) {
      NotificationService().showInstantNotification(
        id: 999,
        title: '🎉 Water Goal Achieved!',
        body: 'You\'ve hit your 3L daily target. Amazing! 💧',
      );
    }

    emit(
      WaterLoaded(
        current.water.copyWith(
          currentMl: newMl.clamp(0, targetMl + 500),
          entries: [
            ...current.water.entries,
            WaterEntry(ml: event.ml, time: DateTime.now()),
          ],
        ),
      ),
    );
  }

  Future<void> _onReset(ResetWater event, Emitter<WaterState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_todayKey, 0);

    emit(
      WaterLoaded(
        WaterModel(
          targetMl: targetMl,
          currentMl: 0,
          date: DateTime.now(),
          entries: [],
        ),
      ),
    );
  }
}
