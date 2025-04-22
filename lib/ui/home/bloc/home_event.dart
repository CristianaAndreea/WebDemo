import 'package:equatable/equatable.dart';
import 'package:web_demo/routes/project_route.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeEventGetDetails extends HomeEvent {
  const HomeEventGetDetails();
}

class HomeEventNavigate extends HomeEvent {
  final ProjectRoute route;

  const HomeEventNavigate({required this.route});

  @override
  List<Object> get props => [route];
}

class HomeEventFilter extends HomeEvent {
  final String filterType;

  const HomeEventFilter({required this.filterType});

  @override
  List<Object> get props => [filterType];
}
