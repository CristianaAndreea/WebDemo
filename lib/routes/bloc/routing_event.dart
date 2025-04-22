
import 'package:equatable/equatable.dart';

abstract class RoutingEvent extends Equatable{
  const RoutingEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends RoutingEvent {
  const AppStarted();
}

class LoggedIn extends RoutingEvent {
  const LoggedIn();
}

class LoggedOut extends RoutingEvent {
  const LoggedOut();
}
