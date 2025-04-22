import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:web_demo/ui/controller/simple_ui_controller.dart';

import 'bloc/login.dart';
import 'widgets/login_widget.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  SimpleUIController simpleUIController = Get.find<SimpleUIController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (context) => LoginBloc(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size, simpleUIController);
              } else {
                return LoginWidget(simpleUIController: simpleUIController);
              }
            },
          ),
        ),
      ),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(Size size, SimpleUIController simpleUIController) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Image.asset(
            'assets/images/login_page_background.jpg',
            height: size.height,
            width: size.width,
            fit: BoxFit.fitHeight,
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: LoginWidget(simpleUIController: simpleUIController),
        ),
      ],
    );
  }
}
