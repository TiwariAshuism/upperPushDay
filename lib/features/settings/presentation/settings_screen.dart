import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fittrack/features/dashboard/bloc/today_bloc.dart';
import 'package:fittrack/features/notifications/bloc/notification_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F1A),
        foregroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, notifState) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SectionTitle('Profile'),
              _InfoCard(
                children: [
                  _InfoRow('Name', 'Ashu'),
                  _InfoRow('Goal', 'Muscle Recomposition'),
                  _InfoRow('Lean Mass', '~50 kg'),
                  _InfoRow('Target Calories', '~2000 kcal/day'),
                  _InfoRow('Target Protein', '125–130g/day'),
                  _InfoRow('Rest Days', 'Wed · Sat · Sun'),
                  _InfoRow('Veg Days', 'Tuesday · Thursday'),
                ],
              ),

              const SizedBox(height: 20),

              _SectionTitle('Notifications'),
              _InfoCard(
                children: [
                  _ToggleRow(
                    icon: '💧',
                    title: 'Water Reminders',
                    subtitle: 'Every hour, 8am–10pm',
                    value: notifState.waterEnabled,
                    onChanged: (_) {
                      context.read<NotificationBloc>().add(
                        ToggleWaterNotifications(),
                      );
                    },
                  ),
                  const Divider(color: Colors.white12),
                  BlocBuilder<TodayBloc, TodayState>(
                    builder: (context, todayState) {
                      final title = todayState is TodayLoaded
                          ? todayState.workout.title
                          : 'Gym Workout';
                      return _ToggleRow(
                        icon: '🏋️',
                        title: 'Gym Reminder',
                        subtitle: 'Daily at 5:30 PM',
                        value: notifState.gymEnabled,
                        onChanged: (_) {
                          context.read<NotificationBloc>().add(
                            ToggleGymNotifications(title),
                          );
                        },
                      );
                    },
                  ),
                  const Divider(color: Colors.white12),
                  _ToggleRow(
                    icon: '🍽️',
                    title: 'Meal Reminders',
                    subtitle: '8am · 1pm · 6pm · 9pm',
                    value: notifState.mealEnabled,
                    onChanged: (_) {
                      context.read<NotificationBloc>().add(
                        ToggleMealNotifications(),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _SectionTitle('Weekly Schedule'),
              _InfoCard(
                children: [
                  _ScheduleRow('Monday', '💪 Upper Body — Push', false),
                  _ScheduleRow('Tuesday', '🦵 Lower Body — Quads 🌱', false),
                  _ScheduleRow('Wednesday', '🛌 Rest + Walk', true),
                  _ScheduleRow('Thursday', '💪 Upper Body — Pull 🌱', false),
                  _ScheduleRow('Friday', '🦵 Lower Body — Hamstrings', false),
                  _ScheduleRow('Saturday', '🛌 Full Rest', true),
                  _ScheduleRow('Sunday', '🛌 Full Rest', true),
                ],
              ),

              const SizedBox(height: 20),

              _SectionTitle('About'),
              _InfoCard(
                children: [
                  _InfoRow('App Version', '1.0.0'),
                  _InfoRow('Data Source', 'InBody Scan 11.16.2025'),
                  _InfoRow('Plan Type', '4-Day Upper/Lower Split'),
                ],
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: const Color(0xFF6C63FF).withOpacity(0.8),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String icon, title, subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF6C63FF),
          ),
        ],
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  final String day, activity;
  final bool isRest;
  const _ScheduleRow(this.day, this.activity, this.isRest);

  bool get _isToday => _getDayName() == day;

  String _getDayName() {
    const days = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[DateTime.now().weekday];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: _isToday ? 8 : 0),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: _isToday
          ? BoxDecoration(
              color: const Color(0xFF6C63FF).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF6C63FF).withOpacity(0.4),
              ),
            )
          : null,
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              day,
              style: TextStyle(
                color: _isToday
                    ? const Color(0xFF6C63FF)
                    : Colors.white.withOpacity(0.5),
                fontSize: 12,
                fontWeight: _isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              activity,
              style: TextStyle(
                color: isRest
                    ? Colors.white.withOpacity(0.4)
                    : Colors.white.withOpacity(0.85),
                fontSize: 12,
              ),
            ),
          ),
          if (_isToday)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'TODAY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
