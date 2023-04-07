import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/features/timer/data/model/pomodoro.dart';
import 'package:pomodoro/features/timer/data/repository/pomodoro_repository.dart';

class PomodoroState extends ChangeNotifier {
  final PomodoroRepository pomodoroRepository;

  PomodoroState(this.pomodoroRepository);

  Pomodoro _currentPomodoro = Pomodoro(
    title: '',
    duration: 0,
    startTime: DateTime.now(),
    endTime: DateTime.now(),
  );

  Timer? _timer;

  Pomodoro get currentPomodoro => _currentPomodoro;

  // Установка новой Помидорки
  void setPomodoro(Pomodoro pomodoro) {
    _currentPomodoro = pomodoro;
    startTimer();
    notifyListeners();
  }

  // Запуск таймера
  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateRemainingTime();
    });
  }

  // Обновление оставшегося времени
  void updateRemainingTime() {
    if (_currentPomodoro.remainingTime > 0) {
      _currentPomodoro = _currentPomodoro.copyWith(duration: _currentPomodoro.remainingTime - 1);
      notifyListeners();
    } else {
      _timer?.cancel();
    }
  }

  // Завершение текущей Помидорки
  void completePomodoro() {
    _currentPomodoro.endTime = DateTime.now();
    // Сохранение завершенной Помидорки в локальное хранилище
    pomodoroRepository.savePomodoro(_currentPomodoro);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
