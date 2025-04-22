import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:web_demo/ui/common/common.dart';
import 'package:web_demo/ui/controller/simple_ui_controller.dart';
import 'package:web_demo/theme/text_styles.dart';
import '../../../routes/routes.dart';
import '../../../utils/utils.dart';
import '../bloc/login.dart';

class LoginWidget extends StatefulWidget {
  final SimpleUIController simpleUIController;

  const LoginWidget({super.key, required this.simpleUIController});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          navKey.currentState?.pushNamed(routeMain);
        } else if (state.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                size.width > 600
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
            children: [
              size.width > 600
                  ? Container()
                  : Image.asset(
                    'assets/images/login_page_background.jpg',
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    height: 200,
                  ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Login', style: WebTextStyles.heading1),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Enter your credentials for login',
                  style: WebTextStyles.bodyXLargeSemiBold,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// Email
                      WebTextFormField(
                        controller: emailController,
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email_rounded),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (!Validators.isValidEmail(value)) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),

                      /// Password
                      Obx(
                        () => PasswordFormFieldWidget(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            } else if (!Validators.isValidPassword(value)) {
                              return 'Password must have between 5 and 40 characters';
                            }
                            return null;
                          },
                          obscureText: widget.simpleUIController.isObscure.value,
                          onToggleVisibility: () {
                            widget.simpleUIController.isObscureActive();
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),

                      /// Login Button
                      GeneralButtonWidget(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            var event = LoginEventSubmit(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            _loginBloc.add(event);
                          }
                        },
                        text: 'Login',
                      ),
                      SizedBox(height: size.height * 0.03),

                      /// Navigate To Login Screen
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          emailController.clear();
                          passwordController.clear();
                          _formKey.currentState?.reset();
                          widget.simpleUIController.isObscure.value = true;
                        },
                        child: WebRichTextWidget(
                          text: 'Don\'t have an account?',
                          action: 'Sign up',
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
