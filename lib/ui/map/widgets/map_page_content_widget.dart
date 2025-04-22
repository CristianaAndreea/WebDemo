import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/model.dart';
import '../../home/bloc/home.dart';
import '../bloc/map.dart';
import 'map_widgets.dart';

class MapPageContentWidget extends StatefulWidget {
  final Widget mapWidget;

  const MapPageContentWidget({super.key, required this.mapWidget});

  @override
  State<MapPageContentWidget> createState() => _MapPageContentWidgetState();
}

class _MapPageContentWidgetState extends State<MapPageContentWidget> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<MapBloc>(context).add(const MapEventGetProjects());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return _buildSmallScreenWidget(size, state.projects);
            } else {
              return _buildLargeScreenWidget(size, state.projects);
            }
          },
        );
      },
    );
  }

  Widget _buildSmallScreenWidget(Size size, List<Project> projects) {
    return Column(
      children: [
        Flexible(flex: 4, child: widget.mapWidget),
        Flexible(
          flex: 2,
          child: SingleChildScrollView(
            child: Container(
              height: size.height * 0.4,
              color: Colors.white,
              child: MapPageProjectsListWidget(size: size, projects: projects),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLargeScreenWidget(Size size, List<Project> projects) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: MapPageProjectsListWidget(size: size, projects: projects),
        ),
        Flexible(flex: 4, child: widget.mapWidget),
      ],
    );
  }
}
