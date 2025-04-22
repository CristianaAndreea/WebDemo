import 'package:equatable/equatable.dart';
import 'package:web_demo/routes/project_route.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}


class MainEventNavigate extends MainEvent {
  final ProjectRoute route;

  const MainEventNavigate({required this.route});

  @override
  List<Object> get props => [route];
}

class MainEventOnTabChange extends MainEvent {
  final int tabIndex;

  const MainEventOnTabChange({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}
