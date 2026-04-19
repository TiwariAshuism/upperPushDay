class MealItem {
  final String time;
  final String name;
  final String description;
  final int protein;
  final int carbs;
  final int fat;
  final int calories;
  final String emoji;

  const MealItem({
    required this.time,
    required this.name,
    required this.description,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.calories,
    required this.emoji,
  });
}

class DayMealPlan {
  final bool isVegetarian;
  final List<MealItem> meals;
  final int totalProtein;
  final int totalCarbs;
  final int totalFat;
  final int totalCalories;

  const DayMealPlan({
    required this.isVegetarian,
    required this.meals,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalCalories,
  });
}
