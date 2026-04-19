class ExerciseModel {
  final String id;
  final String name;
  final int sets;
  final String reps;
  final String rest;
  final String youtubeVideoId;
  final String muscleGroup;
  final String instructions;

  const ExerciseModel({
    required this.id,
    required this.name,
    required this.sets,
    required this.reps,
    required this.rest,
    required this.youtubeVideoId,
    required this.muscleGroup,
    required this.instructions,
  });
}

class WorkoutDay {
  final String title;
  final String subtitle;
  final bool isRestDay;
  final List<ExerciseModel> exercises;
  final String warmUp;
  final String coolDown;

  const WorkoutDay({
    required this.title,
    required this.subtitle,
    required this.isRestDay,
    required this.exercises,
    this.warmUp = '5 min light cardio + dynamic stretching',
    this.coolDown = '5 min static stretching — focus on worked muscles',
  });
}
