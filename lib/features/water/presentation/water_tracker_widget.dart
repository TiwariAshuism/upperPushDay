import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:fittrack/app/app_controller.dart';
import 'package:fittrack/features/water/bloc/water_bloc.dart';

class WaterTrackerWidget extends StatelessWidget {
  const WaterTrackerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterBloc, WaterState>(
      builder: (context, state) {
        if (state is! WaterLoaded) {
          return const SizedBox(
            height: 80,
            child: Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            ),
          );
        }

        final water = state.water;
        final percent = water.progress.clamp(0.0, 1.0);
        final isGoalMet = water.isGoalMet;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isGoalMet
                  ? Colors.blue.withOpacity(0.5)
                  : Colors.blue.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircularPercentIndicator(
                    radius: 44,
                    lineWidth: 7,
                    percent: percent,
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(water.currentMl / 1000).toStringAsFixed(1)}L',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'of 3L',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                    progressColor: isGoalMet
                        ? Colors.green
                        : const Color(0xFF3B82F6),
                    backgroundColor: Colors.blue.withOpacity(0.1),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isGoalMet ? '🎉 Goal Achieved!' : 'Daily Water Goal',
                          style: TextStyle(
                            color: isGoalMet ? Colors.green : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isGoalMet
                              ? 'Great job staying hydrated!'
                              : '${(water.remaining / 1000).toStringAsFixed(1)}L remaining',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: percent,
                          backgroundColor: Colors.blue.withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isGoalMet ? Colors.green : const Color(0xFF3B82F6),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(percent * 100).toInt()}% complete',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _WaterButton(
                      label: '+150ml',
                      emoji: '🥃',
                      onTap: () => AppController().addWater(150),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _WaterButton(
                      label: '+250ml',
                      emoji: '🥤',
                      onTap: () => AppController().addWater(250),
                      isPrimary: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _WaterButton(
                      label: '+500ml',
                      emoji: '🍶',
                      onTap: () => AppController().addWater(500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WaterButton extends StatelessWidget {
  final String label, emoji;
  final VoidCallback onTap;
  final bool isPrimary;
  const _WaterButton({
    required this.label,
    required this.emoji,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isPrimary
              ? const Color(0xFF3B82F6)
              : const Color(0xFF3B82F6).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF3B82F6).withOpacity(isPrimary ? 0 : 0.3),
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : const Color(0xFF3B82F6),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
