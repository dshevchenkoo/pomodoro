import 'package:flutter/material.dart';
import 'package:pomodoro/features/di.dart';
import 'package:pomodoro/features/timer/data/model/pomodoro.dart';
import 'package:pomodoro/features/timer/data/repository/pomodoro_repository.dart';

class AnalyticsScreen extends StatelessWidget {
  late Future<List<Pomodoro>> _pomodorosFuture;

  AnalyticsScreen() {
    final repository = locator<PomodoroRepository>();
    _pomodorosFuture = repository.getPomodoros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Analytics'),
      ),
      body: FutureBuilder<List<Pomodoro>>(
        future: _pomodorosFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final pomodoros = snapshot.data!;
            // Здесь можно отобразить график и статистику по помидоркам
            return Center(
              child: Text('Number of Pomodoros: ${pomodoros.length}'),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
