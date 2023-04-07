class Pomodoro {
  String title;
  int duration;
  DateTime startTime;
  DateTime? endTime;

  Pomodoro({
    required this.title,
    required this.duration,
    required this.startTime,
    required this.endTime,
  });

// Расчет оставшегося времени
  int get remainingTime {
    if (endTime != null) {
      Duration diff = endTime!.difference(DateTime.now());
      return diff.inSeconds > 0 ? diff.inSeconds : 0;
    } else {
      return duration;
    }
  }

  // Сериализация в JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'duration': duration,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime != null ? endTime!.toIso8601String() : null,
    };
  }

  // Десериализация из JSON
  static Pomodoro fromJson(Map<String, dynamic> json) {
    return Pomodoro(
      title: json['title'],
      duration: json['duration'],
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
    );
  }

  Pomodoro copyWith({
    String? title,
    int? duration,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return Pomodoro(
      title: title ?? this.title,
      duration: duration ?? this.duration,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
