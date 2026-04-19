import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:fittrack/app/app_controller.dart';
import 'package:fittrack/features/dashboard/bloc/today_bloc.dart';
import 'package:fittrack/features/meals/presentation/meal_detail_screen.dart';
import 'package:fittrack/features/meals/presentation/meal_card.dart';
import 'package:fittrack/features/settings/presentation/settings_screen.dart';
import 'package:fittrack/features/water/presentation/water_tracker_widget.dart';
import 'package:fittrack/features/workout/presentation/rest_day_card.dart';
import 'package:fittrack/features/workout/presentation/workout_card.dart';
import 'package:fittrack/features/workout/presentation/workout_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => AppController().refreshAll(),
          color: const Color(0xFF6C63FF),
          child: CustomScrollView(
            slivers: [
              _buildAppBar(context),
              SliverToBoxAdapter(
                child: BlocBuilder<TodayBloc, TodayState>(
                  builder: (context, state) {
                    if (state is TodayLoading) {
                      return const SizedBox(
                        height: 400,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                      );
                    }
                    if (state is TodayLoaded) {
                      return _buildContent(context, state);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF0F0F1A),
      floating: true,
      pinned: false,
      expandedHeight: 100,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey Ashu 👋',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat('EEEE, MMM d').format(DateTime.now()),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E2E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, TodayLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SummaryStrip(state: state),
          const SizedBox(height: 24),

          _SectionHeader(
            title: "Today's Workout",
            emoji: state.workout.isRestDay ? '🛌' : '🏋️',
          ),
          const SizedBox(height: 12),
          state.workout.isRestDay
              ? RestDayCard(workout: state.workout)
              : WorkoutCard(
                  workout: state.workout,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WorkoutDetailScreen(workout: state.workout),
                    ),
                  ),
                ),
          const SizedBox(height: 24),

          _SectionHeader(
            title: "Today's Meals",
            emoji: '🍽️',
            badge: state.meal.isVegetarian ? '🌱 Veg Day' : null,
          ),
          const SizedBox(height: 12),
          MealCard(
            meal: state.meal,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MealDetailScreen(meal: state.meal),
              ),
            ),
          ),
          const SizedBox(height: 24),

          const _SectionHeader(title: 'Water Intake', emoji: '💧'),
          const SizedBox(height: 12),
          const WaterTrackerWidget(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SummaryStrip extends StatelessWidget {
  final TodayLoaded state;
  const _SummaryStrip({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF3F3A8E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              label: 'Workout',
              value: state.workout.isRestDay ? 'REST' : 'GYM',
              icon: state.workout.isRestDay ? '🛌' : '💪',
            ),
          ),
          _Divider(),
          Expanded(
            child: _StatItem(
              label: 'Calories',
              value: '${state.meal.totalCalories}',
              icon: '🔥',
            ),
          ),
          _Divider(),
          Expanded(
            child: _StatItem(
              label: 'Protein',
              value: '${state.meal.totalProtein}g',
              icon: '💊',
            ),
          ),
          _Divider(),
          Expanded(
            child: _StatItem(
              label: 'Water',
              value: '3L',
              icon: '💧',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label, value, icon;
  const _StatItem({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white.withOpacity(0.3),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title, emoji;
  final String? badge;
  const _SectionHeader({required this.title, required this.emoji, this.badge});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (badge != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.withOpacity(0.5)),
            ),
            child: Text(
              badge!,
              style: const TextStyle(color: Colors.green, fontSize: 11),
            ),
          ),
        ],
      ],
    );
  }
}
