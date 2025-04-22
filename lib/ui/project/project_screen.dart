import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_demo/data/model/project/project.dart';
import 'package:web_demo/routes/project_route.dart';
import 'package:web_demo/routes/routes.dart';
import 'package:web_demo/ui/project/widgets/project_content_widget.dart';

import '../../theme/text_styles.dart';
import 'bloc/project.dart';

class ProjectScreen extends StatelessWidget {
  final PageConfiguration configuration;
  final Project? project;

  const ProjectScreen({super.key, required this.configuration, this.project});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var pageTitle =
        configuration == PageConfiguration.add ? 'Add Project' : 'Edit Project';

    return BlocProvider(
      create: (context) => ProjectBloc(),
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 30),
            _buildHeader(pageTitle),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                width: double.maxFinite,
                color: Colors.black12,
                height: 2,
              ),
            ),
            ProjectContentWidget(size: size, project: project),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String pageTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () {
              navKey.currentState?.pushNamed(routeMain);
            },
            child: const Icon(
              Icons.chevron_left,
              color: Colors.grey,
              size: 30.0,
            ),
          ),
          Expanded(child: Container()),
          Text(pageTitle, style: WebTextStyles.bodyXLargeBold),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
