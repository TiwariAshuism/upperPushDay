import 'package:fittrack/features/meals/domain/meal_model.dart';
import 'package:fittrack/features/workout/domain/exercise_model.dart';

class FitnessData {
  // ─── WORKOUT SCHEDULE ───────────────────────────────────────────
  // Mon=Upper Push, Tue=Lower Quad, Wed=Rest, Thu=Upper Pull,
  // Fri=Lower Hamstring, Sat=Rest, Sun=Rest

  static WorkoutDay getWorkoutForDay(DateTime date) {
    final weekday = date.weekday; // 1=Mon, 7=Sun
    switch (weekday) {
      case 1:
        return upperPushDay;
      case 2:
        return lowerQuadDay;
      case 3:
        return restDay1;
      case 4:
        return upperPullDay;
      case 5:
        return lowerHamstringDay;
      case 6:
        return restDay2;
      case 7:
        return restDay3;
      default:
        return restDay1;
    }
  }

  static DayMealPlan getMealForDay(DateTime date) {
    final weekday = date.weekday;
    // Tuesday=2, Thursday=4 are vegetarian
    if (weekday == 2 || weekday == 4) {
      return weekday == 2 ? tuesdayMeal : thursdayMeal;
    }
    switch (weekday) {
      case 1:
        return mondayMeal;
      case 3:
        return wednesdayMeal;
      case 5:
        return fridayMeal;
      case 6:
        return saturdayMeal;
      case 7:
        return sundayMeal;
      default:
        return mondayMeal;
    }
  }

  // ─── WORKOUT DAYS ───────────────────────────────────────────────

  static const WorkoutDay upperPushDay = WorkoutDay(
    title: 'Upper Body — Push',
    subtitle: 'Chest · Shoulders · Triceps',
    isRestDay: false,
    exercises: [
      ExerciseModel(
        id: 'bench_press',
        name: 'Barbell Bench Press',
        sets: 3,
        reps: '10–12',
        rest: '90 sec',
        youtubeVideoId: 'SCVCLChPQFY',
        muscleGroup: 'Chest',
        instructions:
            'Lie flat, grip shoulder-width, lower bar to chest, press up explosively. Keep feet flat on floor.',
      ),
      ExerciseModel(
        id: 'incline_db',
        name: 'Incline DB Press',
        sets: 3,
        reps: '10–12',
        rest: '90 sec',
        youtubeVideoId: 'DbFgADa2PL8',
        muscleGroup: 'Upper Chest',
        instructions:
            'Set bench to 30–45°. Lower dumbbells to upper chest, press up. Control the descent.',
      ),
      ExerciseModel(
        id: 'ohp',
        name: 'Overhead Press',
        sets: 3,
        reps: '10–12',
        rest: '90 sec',
        youtubeVideoId: '2yjwXTZQDDI',
        muscleGroup: 'Shoulders',
        instructions:
            'Stand or sit, press barbell/dumbbells overhead. Do not arch lower back excessively.',
      ),
      ExerciseModel(
        id: 'lateral_raise',
        name: 'Lateral Raises',
        sets: 3,
        reps: '12–15',
        rest: '60 sec',
        youtubeVideoId: 'XPPfnSEATJA',
        muscleGroup: 'Side Delts',
        instructions:
            'Hold dumbbells at sides, raise to shoulder height with slight bend in elbow. Slow and controlled.',
      ),
      ExerciseModel(
        id: 'tricep_pushdown',
        name: 'Tricep Pushdowns',
        sets: 3,
        reps: '12–15',
        rest: '60 sec',
        youtubeVideoId: 'REbTmVpEVhg',
        muscleGroup: 'Triceps',
        instructions:
            'Cable machine, rope or bar attachment. Keep elbows pinned to sides, push down fully.',
      ),
      ExerciseModel(
        id: 'plank',
        name: 'Plank',
        sets: 3,
        reps: '30–45 sec',
        rest: '60 sec',
        youtubeVideoId: 'pSHjTRCQxIw',
        muscleGroup: 'Core',
        instructions:
            'Forearms on ground, body straight from head to heel. Do not let hips sag or rise.',
      ),
    ],
  );

  static const WorkoutDay lowerQuadDay = WorkoutDay(
    title: 'Lower Body — Quads',
    subtitle: 'Quads · Glutes · Calves',
    isRestDay: false,
    exercises: [
      ExerciseModel(
        id: 'squat',
        name: 'Barbell Squat',
        sets: 4,
        reps: '8–10',
        rest: '2 min',
        youtubeVideoId: 'ultWZbUMPL8',
        muscleGroup: 'Quads + Glutes',
        instructions:
            'Bar on upper traps, feet shoulder-width. Squat until thighs parallel. Drive through heels to stand.',
      ),
      ExerciseModel(
        id: 'leg_press',
        name: 'Leg Press',
        sets: 3,
        reps: '10–12',
        rest: '90 sec',
        youtubeVideoId: 'IZxyjW7MPJQ',
        muscleGroup: 'Quads',
        instructions:
            'Place feet mid-platform. Lower until 90° knee angle. Do not lock out knees at top.',
      ),
      ExerciseModel(
        id: 'lunges',
        name: 'Walking Lunges',
        sets: 3,
        reps: '10 per leg',
        rest: '90 sec',
        youtubeVideoId: 'L8fvypPrzzs',
        muscleGroup: 'Quads + Glutes',
        instructions:
            'Step forward, lower back knee toward floor. Keep front knee over ankle. Alternate legs.',
      ),
      ExerciseModel(
        id: 'leg_ext',
        name: 'Leg Extension',
        sets: 3,
        reps: '12–15',
        rest: '60 sec',
        youtubeVideoId: 'YyvSfVjQeL0',
        muscleGroup: 'Quads',
        instructions:
            'Sit in machine, extend legs fully, squeeze quads at top. Lower slowly.',
      ),
      ExerciseModel(
        id: 'calf_raise',
        name: 'Calf Raises',
        sets: 3,
        reps: '15–20',
        rest: '60 sec',
        youtubeVideoId: 'gwLzBJYoWlI',
        muscleGroup: 'Calves',
        instructions:
            'Stand on edge of step or floor. Rise up on toes fully, lower slowly below platform level.',
      ),
      ExerciseModel(
        id: 'dead_bug',
        name: 'Dead Bug',
        sets: 3,
        reps: '10 per side',
        rest: '60 sec',
        youtubeVideoId: 'g_BYB0R-4Ws',
        muscleGroup: 'Core',
        instructions:
            'Lie on back, arms up, knees 90°. Lower opposite arm and leg simultaneously. Keep lower back pressed to floor.',
      ),
    ],
  );

  static const WorkoutDay upperPullDay = WorkoutDay(
    title: 'Upper Body — Pull',
    subtitle: 'Back · Biceps · Rear Delts',
    isRestDay: false,
    exercises: [
      ExerciseModel(
        id: 'lat_pulldown',
        name: 'Lat Pulldown',
        sets: 4,
        reps: '8–10',
        rest: '90 sec',
        youtubeVideoId: 'CAwf7n6Luuc',
        muscleGroup: 'Lats',
        instructions:
            'Wide grip, lean slightly back, pull bar to upper chest. Squeeze lats at bottom.',
      ),
      ExerciseModel(
        id: 'cable_row',
        name: 'Seated Cable Row',
        sets: 3,
        reps: '10–12',
        rest: '90 sec',
        youtubeVideoId: 'GZbfZ033f74',
        muscleGroup: 'Mid Back',
        instructions:
            'Sit tall, pull handle to lower chest. Squeeze shoulder blades together. Control return.',
      ),
      ExerciseModel(
        id: 'db_row',
        name: 'One-Arm DB Row',
        sets: 3,
        reps: '10 per side',
        rest: '90 sec',
        youtubeVideoId: 'pYcpY20QaE8',
        muscleGroup: 'Lats + Rhomboids',
        instructions:
            'Knee and hand on bench, row dumbbell to hip. Elbow close to body. Full range of motion.',
      ),
      ExerciseModel(
        id: 'face_pulls',
        name: 'Face Pulls',
        sets: 3,
        reps: '15',
        rest: '60 sec',
        youtubeVideoId: 'HSoHeSjvIdY',
        muscleGroup: 'Rear Delts + Rotator Cuff',
        instructions:
            'Cable at face height with rope. Pull toward face, elbows flared high. Critical for posture correction.',
      ),
      ExerciseModel(
        id: 'bicep_curl',
        name: 'Bicep Curls',
        sets: 3,
        reps: '12–15',
        rest: '60 sec',
        youtubeVideoId: 'ykJmrZ5v0Oo',
        muscleGroup: 'Biceps',
        instructions:
            'Stand, curl dumbbells to shoulders. Keep elbows stationary at sides. Squeeze at top.',
      ),
      ExerciseModel(
        id: 'hanging_knee',
        name: 'Hanging Knee Raise',
        sets: 3,
        reps: '10–12',
        rest: '60 sec',
        youtubeVideoId: 'hdng3Nm1x_E',
        muscleGroup: 'Lower Abs',
        instructions:
            'Hang from pull-up bar, raise knees to chest. Control lowering. Avoid swinging.',
      ),
    ],
  );

  static const WorkoutDay lowerHamstringDay = WorkoutDay(
    title: 'Lower Body — Hamstrings',
    subtitle: 'Hamstrings · Glutes · Core',
    isRestDay: false,
    exercises: [
      ExerciseModel(
        id: 'rdl',
        name: 'Romanian Deadlift',
        sets: 4,
        reps: '8–10',
        rest: '2 min',
        youtubeVideoId: 'JCXUYuzwNrM',
        muscleGroup: 'Hamstrings + Glutes',
        instructions:
            'Hip hinge with slight knee bend. Lower bar along legs, feel hamstring stretch. Drive hips forward to stand.',
      ),
      ExerciseModel(
        id: 'leg_curl',
        name: 'Leg Curl (Machine)',
        sets: 3,
        reps: '12–15',
        rest: '90 sec',
        youtubeVideoId: 'ELOCsoDSmrg',
        muscleGroup: 'Hamstrings',
        instructions:
            'Lie face down, curl legs toward glutes. Squeeze at top, lower slowly.',
      ),
      ExerciseModel(
        id: 'hip_thrust',
        name: 'Hip Thrust',
        sets: 3,
        reps: '10–12',
        rest: '90 sec',
        youtubeVideoId: 'xDmFkJxPzeM',
        muscleGroup: 'Glutes',
        instructions:
            'Upper back on bench, barbell on hips. Drive hips up until body is flat. Squeeze glutes hard at top.',
      ),
      ExerciseModel(
        id: 'step_ups',
        name: 'Step-ups with DBs',
        sets: 3,
        reps: '10 per leg',
        rest: '90 sec',
        youtubeVideoId:
            ''
            'dQqApCGd5Ss',
        muscleGroup: 'Quads + Glutes',
        instructions:
            'Step onto bench with one foot, drive through heel to stand. Lower controlled. Alternate legs.',
      ),
      ExerciseModel(
        id: 'ab_wheel',
        name: 'Ab Wheel Rollout',
        sets: 3,
        reps: '30–45 sec plank',
        rest: '60 sec',
        youtubeVideoId: 'pSHjTRCQxIw',
        muscleGroup: 'Core',
        instructions:
            'If no ab wheel, hold plank. Keep core tight, do not let lower back sag.',
      ),
    ],
  );

  static const WorkoutDay restDay1 = WorkoutDay(
    title: 'Rest & Recovery',
    subtitle: 'Wednesday — Active Recovery',
    isRestDay: true,
    exercises: [],
    warmUp: '',
    coolDown: '',
  );

  static const WorkoutDay restDay2 = WorkoutDay(
    title: 'Rest & Recovery',
    subtitle: 'Saturday — Full Rest',
    isRestDay: true,
    exercises: [],
    warmUp: '',
    coolDown: '',
  );

  static const WorkoutDay restDay3 = WorkoutDay(
    title: 'Rest & Recovery',
    subtitle: 'Sunday — Full Rest',
    isRestDay: true,
    exercises: [],
    warmUp: '',
    coolDown: '',
  );

  // ─── REST DAY ACTIVITIES ───────────────────────────────────────
  static const List<String> restDayActivities = [
    '🚶 8,000–10,000 steps walk',
    '🧘 10 min hip flexor stretching',
    '🧘 Chest opener stretch (desk posture fix)',
    '🧘 Shoulder cross-body stretch',
    '🫀 Foam rolling — legs + upper back',
    '😴 Prioritize 7–8 hrs sleep tonight',
  ];

  // ─── MEAL PLANS ─────────────────────────────────────────────────

  static const DayMealPlan mondayMeal = DayMealPlan(
    isVegetarian: false,
    totalProtein: 133,
    totalCarbs: 170,
    totalFat: 28,
    totalCalories: 1700,
    meals: [
      MealItem(
        time: '8:00 AM',
        name: 'Morning Shake',
        description: '1 scoop whey + 200ml milk + 1 banana — blended',
        protein: 35,
        carbs: 35,
        fat: 6,
        calories: 334,
        emoji: '🥤',
      ),
      MealItem(
        time: '1:00 PM',
        name: 'Lunch',
        description: '150g chicken breast + 1.5 cup rice + dal + salad',
        protein: 45,
        carbs: 70,
        fat: 8,
        calories: 540,
        emoji: '🍗',
      ),
      MealItem(
        time: '6:00 PM',
        name: 'Pre-Workout Shake',
        description: '1 scoop whey in water + 5 dates',
        protein: 25,
        carbs: 30,
        fat: 2,
        calories: 238,
        emoji: '💪',
      ),
      MealItem(
        time: '9:00 PM',
        name: 'Post-Workout Dinner',
        description: '4 eggs (2 whole + 2 white) + 2 roti + sabzi',
        protein: 28,
        carbs: 35,
        fat: 12,
        calories: 360,
        emoji: '🍳',
      ),
    ],
  );

  static const DayMealPlan tuesdayMeal = DayMealPlan(
    isVegetarian: true,
    totalProtein: 124,
    totalCarbs: 178,
    totalFat: 34,
    totalCalories: 1700,
    meals: [
      MealItem(
        time: '8:00 AM',
        name: 'Morning Shake',
        description: '1 scoop whey + 200ml milk + 1 banana',
        protein: 35,
        carbs: 35,
        fat: 6,
        calories: 334,
        emoji: '🥤',
      ),
      MealItem(
        time: '1:00 PM',
        name: 'Lunch',
        description: '1.5 cup rajma/chana + 1.5 cup rice + raita + salad',
        protein: 28,
        carbs: 80,
        fat: 8,
        calories: 512,
        emoji: '🫘',
      ),
      MealItem(
        time: '6:00 PM',
        name: 'Pre-Workout Shake',
        description: '1 scoop whey in water + 1 apple',
        protein: 25,
        carbs: 25,
        fat: 2,
        calories: 218,
        emoji: '💪',
      ),
      MealItem(
        time: '9:00 PM',
        name: 'Post-Workout Dinner',
        description: '200g paneer bhurji + 2 roti + sabzi',
        protein: 36,
        carbs: 38,
        fat: 18,
        calories: 458,
        emoji: '🧀',
      ),
    ],
  );

  static const DayMealPlan wednesdayMeal = DayMealPlan(
    isVegetarian: false,
    totalProtein: 128,
    totalCarbs: 137,
    totalFat: 35,
    totalCalories: 1600,
    meals: [
      MealItem(
        time: '8:00 AM',
        name: 'Morning Shake',
        description: '1 scoop whey + 200ml milk + 1 banana',
        protein: 35,
        carbs: 35,
        fat: 6,
        calories: 334,
        emoji: '🥤',
      ),
      MealItem(
        time: '1:00 PM',
        name: 'Lunch',
        description: '150g grilled fish + 1.5 cup rice + dal + salad',
        protein: 45,
        carbs: 65,
        fat: 7,
        calories: 509,
        emoji: '🐟',
      ),
      MealItem(
        time: '6:00 PM',
        name: 'Evening Shake',
        description: '1 scoop whey in water + 10 almonds',
        protein: 26,
        carbs: 5,
        fat: 8,
        calories: 196,
        emoji: '🥤',
      ),
      MealItem(
        time: '9:00 PM',
        name: 'Dinner',
        description: '3 whole eggs omelette + 2 roti + sabzi',
        protein: 22,
        carbs: 32,
        fat: 14,
        calories: 338,
        emoji: '🍳',
      ),
    ],
  );

  static const DayMealPlan thursdayMeal = DayMealPlan(
    isVegetarian: true,
    totalProtein: 118,
    totalCarbs: 166,
    totalFat: 28,
    totalCalories: 1650,
    meals: [
      MealItem(
        time: '8:00 AM',
        name: 'Morning Shake',
        description: '1 scoop whey + 200ml milk + 1 banana',
        protein: 35,
        carbs: 35,
        fat: 6,
        calories: 334,
        emoji: '🥤',
      ),
      MealItem(
        time: '1:00 PM',
        name: 'Lunch',
        description: '1.5 cup chana/dal + 1.5 cup brown rice + curd + salad',
        protein: 26,
        carbs: 75,
        fat: 6,
        calories: 470,
        emoji: '🫘',
      ),
      MealItem(
        time: '6:00 PM',
        name: 'Pre-Workout Shake',
        description: '1 scoop whey in water + 1 fruit',
        protein: 25,
        carbs: 20,
        fat: 2,
        calories: 198,
        emoji: '💪',
      ),
      MealItem(
        time: '9:00 PM',
        name: 'Post-Workout Dinner',
        description: '200g tofu/paneer + 2 roti + sabzi',
        protein: 32,
        carbs: 36,
        fat: 14,
        calories: 394,
        emoji: '🧀',
      ),
    ],
  );

  static const DayMealPlan fridayMeal = DayMealPlan(
    isVegetarian: false,
    totalProtein: 133,
    totalCarbs: 170,
    totalFat: 28,
    totalCalories: 1700,
    meals: [
      MealItem(
        time: '8:00 AM',
        name: 'Morning Shake',
        description: '1 scoop whey + 200ml milk + 1 banana',
        protein: 35,
        carbs: 35,
        fat: 6,
        calories: 334,
        emoji: '🥤',
      ),
      MealItem(
        time: '1:00 PM',
        name: 'Lunch',
        description: '150g chicken + 1.5 cup rice + dal + salad',
        protein: 45,
        carbs: 70,
        fat: 8,
        calories: 540,
        emoji: '🍗',
      ),
      MealItem(
        time: '6:00 PM',
        name: 'Pre-Workout Shake',
        description: '1 scoop whey in water + 5 dates',
        protein: 25,
        carbs: 30,
        fat: 2,
        calories: 238,
        emoji: '💪',
      ),
      MealItem(
        time: '9:00 PM',
        name: 'Post-Workout Dinner',
        description: '4 eggs + 2 roti + sabzi',
        protein: 28,
        carbs: 35,
        fat: 12,
        calories: 360,
        emoji: '🍳',
      ),
    ],
  );

  static const DayMealPlan saturdayMeal = DayMealPlan(
    isVegetarian: false,
    totalProtein: 125,
    totalCarbs: 127,
    totalFat: 33,
    totalCalories: 1600,
    meals: [
      MealItem(
        time: '8:00 AM',
        name: 'Morning Shake',
        description: '1 scoop whey + 200ml milk + 1 banana',
        protein: 35,
        carbs: 35,
        fat: 6,
        calories: 334,
        emoji: '🥤',
      ),
      MealItem(
        time: '1:00 PM',
        name: 'Lunch',
        description: '150g fish/chicken + 1 cup rice + dal + salad',
        protein: 42,
        carbs: 55,
        fat: 7,
        calories: 459,
        emoji: '🐟',
      ),
      MealItem(
        time: '6:00 PM',
        name: 'Evening Shake',
        description: '1 scoop whey in water + 10 almonds',
        protein: 26,
        carbs: 5,
        fat: 8,
        calories: 196,
        emoji: '🥤',
      ),
      MealItem(
        time: '9:00 PM',
        name: 'Dinner',
        description: '3 egg omelette + 2 roti + sabzi',
        protein: 22,
        carbs: 32,
        fat: 12,
        calories: 328,
        emoji: '🍳',
      ),
    ],
  );

  static const DayMealPlan sundayMeal = DayMealPlan(
    isVegetarian: false,
    totalProtein: 130,
    totalCarbs: 145,
    totalFat: 27,
    totalCalories: 1650,
    meals: [
      MealItem(
        time: '8:00 AM',
        name: 'Morning Shake',
        description: '1 scoop whey + 200ml milk + 1 banana',
        protein: 35,
        carbs: 35,
        fat: 6,
        calories: 334,
        emoji: '🥤',
      ),
      MealItem(
        time: '1:00 PM',
        name: 'Lunch',
        description: '150g chicken + 1 cup rice + dal + salad',
        protein: 42,
        carbs: 55,
        fat: 7,
        calories: 459,
        emoji: '🍗',
      ),
      MealItem(
        time: '6:00 PM',
        name: 'Evening Shake',
        description: '1 scoop whey in water + 1 fruit',
        protein: 25,
        carbs: 20,
        fat: 2,
        calories: 198,
        emoji: '🥤',
      ),
      MealItem(
        time: '9:00 PM',
        name: 'Dinner',
        description: '4 eggs + 2 roti + sabzi',
        protein: 28,
        carbs: 35,
        fat: 12,
        calories: 360,
        emoji: '🍳',
      ),
    ],
  );
}
