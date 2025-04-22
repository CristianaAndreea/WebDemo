import 'package:flutter/material.dart';
import 'package:web_demo/ui/about/about_page_widget.dart';
import 'package:web_demo/ui/common/lorem_ipsum_screen.dart';
import 'package:web_demo/ui/home/widgets/home_content_widget.dart';
import 'package:web_demo/ui/home/home_screen.dart';
import 'package:web_demo/ui/login/login_screen.dart';
import 'package:web_demo/ui/main/main_widget.dart' show MainWidget;
import 'package:web_demo/ui/map/map_screen.dart' show MapPageWidget;
import 'package:web_demo/ui/profile/profile_screen.dart';
import 'package:web_demo/ui/signup/sign_up_screen.dart';

import '../ui/map/widgets/map_widgets.dart';
import 'routes.dart';

class RouteGenerator {
  // Bad practice, but since the GMap object
  // cannot be reinitialized (for now)
  // we need to keep it alive
  // static WebMap? webMap;

  // static WebMap createMap(BuildContext context) {
  //   webMap ??= const WebMap();
  //   return webMap!;
  // }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeLogin:
        return MaterialPageRoute(builder: (_) => const LoginPageWidget());
      case routeSignup:
        return MaterialPageRoute(builder: (_) => const SignUpPageWidget());
      case routeLoremIpsum:
        {
          final title =
              settings.arguments is String ? settings.arguments as String : '';
          return MaterialPageRoute(
            builder: (_) => LoremIpsumScreen(title: title),
          );
        }
      case routeMain:
        return MaterialPageRoute(
          builder: (_) {
            return const MainWidget();
          },
        );
      case routeMap:
        return MaterialPageRoute(
          builder:
              (_) => MapPageWidget(
                childWidget: MapPageContentWidget(mapWidget: Container()),
              ),
        );
      case routeProfile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case routeAbout:
        return MaterialPageRoute(builder: (_) => const AboutPageWidget());
      default:
        return MaterialPageRoute(
          builder:
              (_) => const HomeScreen(childWidget: HomeContentWidget()),
        );
    }
  }
}
