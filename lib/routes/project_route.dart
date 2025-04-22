import '../data/model/model.dart';

class ProjectRoute {
  final String route;
  final PageConfiguration? configuration;
  final Project? project;

  ProjectRoute({required this.route, this.configuration, this.project});
}

enum PageConfiguration { add, edit }
