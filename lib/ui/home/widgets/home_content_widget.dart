import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_demo/routes/project_route.dart';
import 'package:web_demo/ui/home/widgets/home_widgets.dart';

import '../../../routes/routes.dart';
import '../../../theme/text_styles.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

class HomeContentWidget extends StatefulWidget {
  const HomeContentWidget({super.key});

  @override
  State<HomeContentWidget> createState() => _HomeContentWidgetState();
}

class _HomeContentWidgetState extends State<HomeContentWidget> {
  // does old mean inactive?
  static const List<String> filters = <String>['Active', 'Old'];

  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Projects", style: WebTextStyles.bodyXLargeSemiBold),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                color: Colors.black12,
                height: 2,
              ),
              const SizedBox(height: 40),
              ProjectsFilterWidget(
                filters: filters,
                onFilterChanged: (value) {
                  _homeBloc.add(HomeEventFilter(filterType: value));
                },
                onAddProjectClicked: () {
                  var route = ProjectRoute(
                    route: routeProjectDetails,
                    configuration: PageConfiguration.add,
                  );
                  var event = HomeEventNavigate(route: route);
                  _homeBloc.add(event);
                },
              ),
              const SizedBox(height: 40),
              ProjectsGridviewWidget(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
