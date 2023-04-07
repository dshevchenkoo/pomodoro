import 'dart:convert';

import 'package:pomodoro/features/timer/data/model/pomodoro.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PomodoroDataSource {
  Future<List<Pomodoro>> getPomodoros();
  Future<void> savePomodoro(Pomodoro pomodoro);
}

class LocalPomodoroDataSource implements PomodoroDataSource {
  final Future<SharedPreferences> _prefs;

  LocalPomodoroDataSource(this._prefs);

  @override
  Future<List<Pomodoro>> getPomodoros() async {
    List<Pomodoro> pomodoros = [];
    List<String> pomodoroStrings = (await _prefs).getStringList('pomodoros') ?? [];
    for (String pomodoroString in pomodoroStrings) {
      Pomodoro pomodoro = Pomodoro.fromJson(json.decode(pomodoroString));
      pomodoros.add(pomodoro);
    }
    return pomodoros;
  }

  @override
  Future<void> savePomodoro(Pomodoro pomodoro) async {
    List<String> pomodoroStrings = (await _prefs).getStringList('pomodoros') ?? [];
    pomodoroStrings.add(json.encode(pomodoro.toJson()));
    await (await _prefs).setStringList('pomodoros', pomodoroStrings);
  }
}
