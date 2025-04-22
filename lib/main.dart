import 'dart:async';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:universal_html/js_util.dart' as js_interop;
import 'package:web_demo/routes/bloc/routing.dart';
import 'package:web_demo/routes/routes.dart';
import 'package:web_demo/ui/home/bloc/home.dart';
import 'package:web_demo/ui/main/bloc/main.dart';
import 'routes/router_generator.dart';
import 'ui/signup/sign_up_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];

  if(apiKey != null) {
    await loadGoogleMapsScript(apiKey);
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (context) => MainBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
      ],
      child: WebDemoApp(),
    ),
  );
}

Future<void> loadGoogleMapsScript(String apiKey) async {
  final completer = Completer<void>();

  // Check if the script is already loaded
  final google = js_interop.getProperty(js_interop.globalThis, 'google');
  if (google != null && js_interop.getProperty(google, 'maps') != null) {
    completer.complete();
    return completer.future;
  }

  // Create and append the script element
  final script = html.ScriptElement()
    ..id = 'google-maps-api'
    ..src = 'https://maps.googleapis.com/maps/api/js?key=$apiKey'
    ..type = 'text/javascript'
    ..async = true
    ..onLoad.listen((event) => completer.complete())
    ..onError.listen((event) => completer.completeError('Failed to load Google Maps API'));
  html.document.head!.append(script);

  return completer.future;
}

class WebDemoApp extends StatelessWidget {
  const WebDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RoutingBloc()..add(AppStarted()),
      child: BlocBuilder<RoutingBloc, RoutingState>(
        builder: (context, state) {
          switch (state) {
            case AuthenticationUninitialized():
            case AuthenticationLoading():
            // Show a loading indicator while checking login state
              return const MaterialApp(
                home: Scaffold(body: Center(child: CircularProgressIndicator())),
              );
            case AuthenticationAuthenticated():
            // Redirect to the main screen
              return _buildAuthenticatedState();
            default:
            // Redirect to the login screen
              return _buildUnauthenticatedState();
          }
        },
      ),
    );
  }

  Widget _buildAuthenticatedState() {
    return MaterialApp(
      title: 'Web Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: routeMain,
      navigatorKey: navKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  Widget _buildUnauthenticatedState() {
    return MaterialApp(
      title: 'Web Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: routeLogin,
      navigatorKey: navKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const SignUpPageWidget(),
    );
  }
}
