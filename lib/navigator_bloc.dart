import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

abstract class NavigatorEvent {}

class PushNamedEvent extends NavigatorEvent {
  final String routeName;
  PushNamedEvent(this.routeName);
}

class PopEvent extends NavigatorEvent {}

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorBloc(super.initialState);

  @override
  dynamic get initialState => null;

  @override
  Stream<dynamic> mapEventToState(NavigatorEvent event) async* {
    if (event is PushNamedEvent) {
      navigatorKey.currentState?.pushNamed(event.routeName);
    } else if (event is PopEvent) {
      navigatorKey.currentState?.pop();
    }
  }
}
