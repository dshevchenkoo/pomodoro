import 'package:get_it/get_it.dart';
import 'package:pomodoro/features/timer/data/data_source/pomodoro_data_source.dart';
import 'package:pomodoro/features/timer/data/repository/pomodoro_repository.dart';
import 'package:pomodoro/features/timer/domain/state/pomodoro_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => LocalPomodoroDataSource(SharedPreferences.getInstance()));

  locator.registerLazySingleton(() => PomodoroRepository(dataSource: locator<LocalPomodoroDataSource>()));
  locator.registerLazySingleton(() => PomodoroState(locator<PomodoroRepository>()));
}
