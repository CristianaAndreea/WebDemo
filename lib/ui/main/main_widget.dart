import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_demo/routes/routes.dart';
import 'package:web_demo/ui/about/about_page_widget.dart';
import 'package:web_demo/ui/home/widgets/home_content_widget.dart';
import 'package:web_demo/ui/home/home_screen.dart';
import 'package:web_demo/ui/map/map_screen.dart';
import 'package:web_demo/ui/profile/profile_screen.dart';
import 'package:web_demo/ui/project/project_screen.dart';

import '../../theme/text_styles.dart';
import '../common/common.dart';
import '../home/bloc/home.dart';
import '../map/bloc/map.dart';
import '../map/widgets/map_widgets.dart';
import '../profile/bloc/profile.dart';
import 'bloc/main.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  late MainBloc _mainBloc;

  static WebMap webMap = WebMap();

  @override
  void initState() {
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [BlocProvider<MapBloc>(create: (context) => MapBloc())],
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, mainState) {
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              return BlocConsumer<HomeBloc, HomeState>(
                listener: (context, homeState) {
                  _homeBlocListener(context, homeState);
                },
                builder: (context, homeState) {
                  var userName =
                      homeState.userName.isNotEmpty
                          ? homeState.userName
                          : "User";
                  return Scaffold(
                    backgroundColor: Colors.white,
                    appBar: _buildNavBar(size, userName),
                    body: Column(
                      children: [
                        Expanded(
                          child: _getChild(
                            mainState: mainState,
                            homeState: homeState,
                            mapState: mapState,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildNavBar(Size size, String username) {
    return AdjustableToolbar(
      title: "Welcome back, $username!",
      titleTextStyle: WebTextStyles.bodyXLargeBold.copyWith(
        color: Colors.white,
      ),
      actions: [
        TextButton(
          onPressed: () {
            const onTabChangeEvent = MainEventOnTabChange(tabIndex: 0);
            _mainBloc.add(onTabChangeEvent);
          },
          child: Text(
            "Home",
            style: WebTextStyles.bodyXLargeRegular.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            const onTabChangeEvent = MainEventOnTabChange(tabIndex: 1);
            _mainBloc.add(onTabChangeEvent);
          },
          child: Text(
            "Map",
            style: WebTextStyles.bodyXLargeRegular.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            const onTabChangeEvent = MainEventOnTabChange(tabIndex: 2);
            _mainBloc.add(onTabChangeEvent);
          },
          child: Text(
            "Profile",
            style: WebTextStyles.bodyXLargeRegular.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
      breakpoint: 500,
      // Adjusts to hamburger menu below this width
      onMenuItemSelected: (selection) {
        final tabIndex = switch (selection) {
          "Home" => 0,
          "Map" => 1,
          "Profile" => 2,
          _ => 0,
        };
        final onTabChangeEvent = MainEventOnTabChange(tabIndex: tabIndex);
        _mainBloc.add(onTabChangeEvent);
      },
    );
  }

  Widget _getChild({
    required MainState mainState,
    required HomeState homeState,
    required MapState mapState,
  }) {
    switch (mainState.currentTabIndex) {
      case 0:
        return _getHomeWidget(homeState);
      case 1:
        return _getMapWidget(mapState, context);
      case 2:
        return BlocProvider(
          create: (context) => ProfileBloc(),
          child: const ProfileScreen(),
        );
      case 3:
        return const AboutPageWidget();
      default:
        return const HomeScreen(childWidget: HomeContentWidget());
    }
  }

  Widget _getHomeWidget(HomeState state) {
    switch (state.projectRoute.route) {
      case routeProjectDetails:
        return HomeScreen(
          childWidget: ProjectScreen(
            configuration: state.projectRoute.configuration!,
            project: state.projectRoute.project,
          ),
        );
      default:
        return const HomeScreen(childWidget: HomeContentWidget());
    }
  }

  static Widget _getMapWidget(MapState mapState, BuildContext context) {
    switch (mapState.projectRoute.route) {
      case routeProjectDetails:
        return MapPageWidget(
          childWidget: ProjectScreen(
            configuration: mapState.projectRoute.configuration!,
            project: mapState.projectRoute.project,
          ),
        );
      default:
        return MapPageWidget(
          childWidget: MapPageContentWidget(mapWidget: webMap),
        );
    }
  }

  void _homeBlocListener(BuildContext context, HomeState homeState) {
    if (homeState.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(homeState.errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
