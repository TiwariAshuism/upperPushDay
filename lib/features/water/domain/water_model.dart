class WaterModel {
  final int targetMl;
  final int currentMl;
  final DateTime date;
  final List<WaterEntry> entries;

  const WaterModel({
    required this.targetMl,
    required this.currentMl,
    required this.date,
    required this.entries,
  });

  double get progress => currentMl / targetMl;
  int get remaining => targetMl - currentMl;
  bool get isGoalMet => currentMl >= targetMl;

  WaterModel copyWith({
    int? currentMl,
    List<WaterEntry>? entries,
  }) {
    return WaterModel(
      targetMl: targetMl,
      currentMl: currentMl ?? this.currentMl,
      date: date,
      entries: entries ?? this.entries,
    );
  }
}

class WaterEntry {
  final int ml;
  final DateTime time;

  const WaterEntry({required this.ml, required this.time});
}
