import 'package:flutter/material.dart';

import 'package:fittrack/features/meals/domain/meal_model.dart';

class MealCard extends StatelessWidget {
  final DayMealPlan meal;
  final VoidCallback onTap;
  const MealCard({super.key, required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: meal.isVegetarian
                ? Colors.green.withOpacity(0.3)
                : Colors.orange.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MacroItem('${meal.totalCalories}', 'kcal', const Color(0xFF6C63FF)),
                _MacroItem('${meal.totalProtein}g', 'Protein', const Color(0xFF4CAF50)),
                _MacroItem('${meal.totalCarbs}g', 'Carbs', const Color(0xFFFFC107)),
                _MacroItem('${meal.totalFat}g', 'Fat', const Color(0xFFFF5722)),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(color: Colors.white12),
            const SizedBox(height: 10),

            ...meal.meals.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text(item.emoji, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.time,
                          style: const TextStyle(
                            color: Color(0xFF6C63FF),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '${item.calories} kcal',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: meal.isVegetarian
                    ? Colors.green.withOpacity(0.15)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: meal.isVegetarian
                      ? Colors.green.withOpacity(0.3)
                      : Colors.orange.withOpacity(0.2),
                ),
              ),
              child: Center(
                child: Text(
                  'Tap for Full Meal Details & Macros',
                  style: TextStyle(
                    color: meal.isVegetarian ? Colors.green : Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MacroItem extends StatelessWidget {
  final String value, label;
  final Color color;
  const _MacroItem(this.value, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
