import 'dart:convert';

import 'package:pomodoro/features/timer/data/model/pomodoro.dart';

class PomodoroCollection {
  List<Pomodoro> pomodoros = [];

  // Добавление новой Помидорки
  void add(Pomodoro pomodoro) {
    pomodoros.add(pomodoro);
  }

  // Получение количества завершенных Помидорок
  int get completedCount {
    return pomodoros.where((p) => p.endTime != null).length;
  }

  // Получение количества оставшихся Помидорок
  int get remainingCount {
    return pomodoros.where((p) => p.endTime == null).length;
  }

  // Получение суммарной продолжительности завершенных Помидорок
  int get completedDuration {
    return pomodoros.fold(0, (sum, p) => sum + (p.endTime != null ? p.duration : 0));
  }

  // Сериализация в JSON
  String toJson() {
    List<Map<String, dynamic>> list = pomodoros.map((p) => p.toJson()).toList();
    return json.encode(list);
  }

  // Десериализация из JSON
  static PomodoroCollection fromJson(String jsonStr) {
    PomodoroCollection collection = PomodoroCollection();
    List<dynamic> list = json.decode(jsonStr);
    for (dynamic item in list) {
      Pomodoro pomodoro = Pomodoro.fromJson(item);
      collection.add(pomodoro);
    }
    return collection;
  }
}
