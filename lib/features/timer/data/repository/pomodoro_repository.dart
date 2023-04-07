import 'package:pomodoro/features/timer/data/data_source/pomodoro_data_source.dart';
import 'package:pomodoro/features/timer/data/model/pomodoro.dart';

class PomodoroRepository {
  final PomodoroDataSource dataSource;

  PomodoroRepository({
    required this.dataSource,
  });

  Future<List<Pomodoro>> getPomodoros() async {
    return dataSource.getPomodoros();
  }

  Future<void> savePomodoro(Pomodoro pomodoro) async {
    return dataSource.savePomodoro(pomodoro);
  }
}
