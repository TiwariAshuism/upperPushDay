import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fittrack/core/data/fitness_data.dart';
import 'package:fittrack/features/meals/domain/meal_model.dart';
import 'package:fittrack/features/workout/domain/exercise_model.dart';

abstract class TodayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTodayPlan extends TodayEvent {}

class RefreshTodayPlan extends TodayEvent {}

abstract class TodayState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodayLoading extends TodayState {}

class TodayLoaded extends TodayState {
  final WorkoutDay workout;
  final DayMealPlan meal;
  final DateTime date;
  final String dayName;

  TodayLoaded({
    required this.workout,
    required this.meal,
    required this.date,
    required this.dayName,
  });

  @override
  List<Object?> get props => [workout, meal, date];
}

class TodayError extends TodayState {
  final String message;
  TodayError(this.message);
  @override
  List<Object?> get props => [message];
}

class TodayBloc extends Bloc<TodayEvent, TodayState> {
  TodayBloc() : super(TodayLoading()) {
    on<LoadTodayPlan>(_onLoad);
    on<RefreshTodayPlan>(_onRefresh);
  }

  Future<void> _onLoad(LoadTodayPlan event, Emitter<TodayState> emit) async {
    emit(TodayLoading());
    await _loadPlan(emit);
  }

  Future<void> _onRefresh(
    RefreshTodayPlan event,
    Emitter<TodayState> emit,
  ) async {
    await _loadPlan(emit);
  }

  Future<void> _loadPlan(Emitter<TodayState> emit) async {
    try {
      final today = DateTime.now();
      final workout = FitnessData.getWorkoutForDay(today);
      final meal = FitnessData.getMealForDay(today);
      final dayNames = [
        '',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];

      emit(
        TodayLoaded(
          workout: workout,
          meal: meal,
          date: today,
          dayName: dayNames[today.weekday],
        ),
      );
    } catch (e) {
      emit(TodayError(e.toString()));
    }
  }
}
