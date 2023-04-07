import 'package:flutter/material.dart';
import 'package:pomodoro/features/timer/data/model/pomodoro.dart';
import 'package:pomodoro/features/timer/domain/state/pomodoro_state.dart';
import 'package:provider/provider.dart';

class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pomodoroState = Provider.of<PomodoroState>(context);
    final pomodoro = pomodoroState.currentPomodoro;

    if (pomodoro != null && pomodoro.remainingTime > 0) {
      return Text(
        'Time remaining: ${pomodoro.remainingTime} seconds',
        style: TextStyle(fontSize: 24.0),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Pomodoro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Pomodoro Title',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _durationController,
                decoration: InputDecoration(
                  labelText: 'Pomodoro Duration (minutes)',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              Consumer<PomodoroState>(
                builder: (context, pomodoroState, child) {
                  return TimerWidget(); // добавляем TimerWidget здесь
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  final title = _titleController.text;
                  final duration = int.tryParse(_durationController.text) ?? 25;
                  final pomodoro = Pomodoro(
                    title: title,
                    duration: duration,
                    startTime: DateTime.now(),
                    endTime: null,
                  );
                  Provider.of<PomodoroState>(context, listen: false).setPomodoro(pomodoro);
                },
                child: Text('Start Pomodoro'),
              ),
              SizedBox(height: 16.0),
              Consumer<PomodoroState>(
                builder: (context, pomodoroState, child) {
                  final pomodoro = pomodoroState.currentPomodoro;
                  if (pomodoro != null) {
                    return ElevatedButton(
                      onPressed: () {
                        Provider.of<PomodoroState>(context, listen: false).completePomodoro();
                        _titleController.clear();
                        _durationController.clear();
                      },
                      child: Text('Stop Pomodoro'),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
