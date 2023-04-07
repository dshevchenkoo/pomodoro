import 'package:flutter/material.dart';
import 'package:pomodoro/features/di.dart';
import 'package:pomodoro/features/timer/domain/state/pomodoro_state.dart';
import 'package:pomodoro/features/timer/presentation/screen/analytics_screen.dart';
import 'package:pomodoro/features/timer/presentation/screen/timer_screen.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(
    ChangeNotifierProvider(
      create: (_) => locator<PomodoroState>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      home: BottomNavigationScreen(),
    );
  }
}

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    TimerScreen(),
    AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }
}
