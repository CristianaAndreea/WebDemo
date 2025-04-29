import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/project_route.dart';
import '../../../routes/routes.dart';
import '../../../theme/text_styles.dart';
import '../bloc/home.dart';
import 'home_widgets.dart';

class MyProjectsGridviewWidget extends StatefulWidget {
  final Size size;

  const MyProjectsGridviewWidget({
    super.key,
    required this.size,
  });

  @override
  State<MyProjectsGridviewWidget> createState() =>
      _MyProjectsGridviewWidgetState();
}

class _MyProjectsGridviewWidgetState extends State<MyProjectsGridviewWidget> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context)..add(HomeEventGetDetails());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.projects.isEmpty
            ? _buildEmptyListState(widget.size)
            : _buildGriState(state);
      },
    );
  }

  Widget _buildEmptyListState(Size size) {
    return Center(
      child: Text(
        'You haven\'t created any projects yet.',
        style: WebTextStyles.bodyLargeRegular,
      ),
    );
  }

  Widget _buildGriState(HomeState state) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          mainAxisExtent: 280,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.projects.length,
        itemBuilder: (BuildContext context, int index) {
          return ProjectItemWidget(
            size: widget.size,
            project: state.projects[index],
            onProjectClicked: (project) {
              var route = ProjectRoute(
                route: routeProjectDetails,
                configuration: PageConfiguration.edit,
                project: project,
              );
              var event = HomeEventNavigate(route: route);
              _homeBloc.add(event);
            },
          );
        });
  }
}
