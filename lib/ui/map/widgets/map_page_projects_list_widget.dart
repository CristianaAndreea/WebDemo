import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_demo/routes/project_route.dart';
import 'package:web_demo/theme/text_styles.dart';
import 'package:web_demo/ui/home/widgets/home_widgets.dart';

import '../../../data/model/model.dart';
import '../../../routes/routes.dart';
import '../bloc/map.dart';
import '../bloc/map_event.dart';
import 'map_page_projects_list_item_widget.dart';

class MapPageProjectsListWidget extends StatefulWidget {
  final Size size;
  final List<Project> projects;

  const MapPageProjectsListWidget({
    super.key,
    required this.size,
    required this.projects,
  });

  @override
  State<MapPageProjectsListWidget> createState() =>
      _MapPageProjectsListWidgetState();
}

class _MapPageProjectsListWidgetState extends State<MapPageProjectsListWidget> {
  late MapBloc _mapBloc;

  @override
  void initState() {
    super.initState();
    _mapBloc = BlocProvider.of<MapBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Projects", style: WebTextStyles.bodyXLargeSemiBold),
              InkWell(
                onTap: () {
                  var projectRoute = ProjectRoute(
                    route: routeProjectDetails,
                    configuration: PageConfiguration.add,
                  );
                  final navigateEvent = MapEventNavigate(route: projectRoute);
                  _mapBloc.add(navigateEvent);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add'.toUpperCase(),
                    style: WebTextStyles.bodyLargeBold.copyWith(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(width: double.infinity, color: Colors.black12, height: 2),
        const SizedBox(height: 8),
        Expanded(
          child:
              widget.projects.isEmpty
                  ? _buildEmptyListState(widget.size)
                  : _buildListState(),
        ),
      ],
    );
  }

  Widget _buildListState() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: widget.projects.length,
      itemBuilder: (BuildContext context, int index) {
        return ProjectItemWidget(
          project: widget.projects[index],
          onProjectClicked: (project) {
            _mapBloc.add(
              MapEventOpenInfoWindow(project: widget.projects[index]),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }

  Widget _buildEmptyListState(Size size) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'You haven\'t created any projects yet.',
          style: WebTextStyles.bodyLargeRegular,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
