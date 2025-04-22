import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../controller/simple_ui_controller.dart';
import 'bloc/singup.dart';
import 'widgets/sign_up_widget.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({super.key});

  @override
  State<SignUpPageWidget> createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  SimpleUIController simpleUIController = Get.put(SimpleUIController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (context) => SignupBloc(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size);
              } else {
                return SignupWidget(simpleUIController: simpleUIController);
              }
            },
          ),
        ),
      ),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(Size size) {
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
          child: SignupWidget(simpleUIController: simpleUIController),
        ),
      ],
    );
  }
}
