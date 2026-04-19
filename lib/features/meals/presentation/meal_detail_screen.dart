import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:fittrack/features/meals/domain/meal_model.dart';

class MealDetailScreen extends StatelessWidget {
  final DayMealPlan meal;
  const MealDetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F1A),
        foregroundColor: Colors.white,
        title: Text(
          meal.isVegetarian ? '🌱 Veg Day Meals' : '🍽️ Today\'s Meals',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _MacroSummaryCard(meal: meal),
          const SizedBox(height: 20),

          const Text(
            'Meal Schedule',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          ...meal.meals.asMap().entries.map(
            (entry) => _MealItemCard(
              item: entry.value,
              isLast: entry.key == meal.meals.length - 1,
            ),
          ),

          const SizedBox(height: 20),

          _TipsCard(isVeg: meal.isVegetarian),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _MacroSummaryCard extends StatelessWidget {
  final DayMealPlan meal;
  const _MacroSummaryCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daily Macros',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${meal.totalCalories} kcal',
                  style: const TextStyle(
                    color: Color(0xFF6C63FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _MacroBar(
                  label: 'Protein',
                  value: meal.totalProtein,
                  unit: 'g',
                  target: 130,
                  color: const Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MacroBar(
                  label: 'Carbs',
                  value: meal.totalCarbs,
                  unit: 'g',
                  target: 200,
                  color: const Color(0xFFFFC107),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MacroBar(
                  label: 'Fat',
                  value: meal.totalFat,
                  unit: 'g',
                  target: 60,
                  color: const Color(0xFFFF5722),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MacroBar extends StatelessWidget {
  final String label, unit;
  final int value, target;
  final Color color;
  const _MacroBar({
    required this.label,
    required this.value,
    required this.unit,
    required this.target,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (value / target).clamp(0.0, 1.0);
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 36,
          lineWidth: 6,
          percent: percent,
          center: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$value',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                unit,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 10,
                ),
              ),
            ],
          ),
          progressColor: color,
          backgroundColor: color.withOpacity(0.15),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
        Text(
          'Target: $target$unit',
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _MealItemCard extends StatelessWidget {
  final MealItem item;
  final bool isLast;
  const _MealItemCard({required this.item, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF6C63FF),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(item.emoji, style: const TextStyle(fontSize: 16)),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFF6C63FF).withOpacity(0.3),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.time,
                        style: const TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${item.calories} kcal',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.65),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _MacroChip('P: ${item.protein}g', const Color(0xFF4CAF50)),
                      const SizedBox(width: 6),
                      _MacroChip('C: ${item.carbs}g', const Color(0xFFFFC107)),
                      const SizedBox(width: 6),
                      _MacroChip('F: ${item.fat}g', const Color(0xFFFF5722)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MacroChip extends StatelessWidget {
  final String label;
  final Color color;
  const _MacroChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  final bool isVeg;
  const _TipsCard({required this.isVeg});

  @override
  Widget build(BuildContext context) {
    final tips = isVeg
        ? [
            '🥛 Use 2 scoops whey today for extra protein (veg day)',
            '🫘 Rajma/chana are your best protein sources today',
            '🧀 Paneer counts — don\'t skip the dinner',
            '💊 Consider B12 supplement on veg days',
          ]
        : [
            '🍗 Chicken breast > thigh for lean protein',
            '⏰ Eat dinner within 1hr post-workout',
            '🥚 2 whole eggs + 2 whites = better fat ratio',
            '🐟 Fish on rest days keeps calories lower',
          ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💡 Meal Tips',
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          ...tips.map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  tip,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
