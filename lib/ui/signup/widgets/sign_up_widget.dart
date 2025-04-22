import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:web_demo/routes/routes.dart';
import 'package:web_demo/theme/text_styles.dart';
import 'package:web_demo/ui/controller/simple_ui_controller.dart';
import 'package:web_demo/ui/login/login_screen.dart';
import 'package:web_demo/ui/signup/widgets/widgets.dart';
import 'package:web_demo/utils/validators.dart';

import '../../common/common.dart';
import '../bloc/singup.dart';

class SignupWidget extends StatefulWidget {
  final SimpleUIController simpleUIController;

  const SignupWidget({super.key, required this.simpleUIController});

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final _formKey = GlobalKey<FormState>();
  bool? _termsChecked = false;
  bool? _submitEnabled = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late SignupBloc _signupBloc;

  @override
  void initState() {
    super.initState();
    _signupBloc = BlocProvider.of<SignupBloc>(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.isSuccess) {
          navKey.currentState?.pushNamed(routeMain);
        } else if (state.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
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
                child: Text('Sign Up', style: WebTextStyles.heading1),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Create Account',
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
                      /// Username
                      WebTextFormField(
                        controller: nameController,
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          } else if (!Validators.isUsernameValid(value)) {
                            return 'Username must have between 3 and 100 characters length';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),

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
                          obscureText:
                              widget.simpleUIController.isObscure.value,
                          onToggleVisibility: () {
                            widget.simpleUIController.isObscureActive();
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      TermsAndConditionsWidget(
                        checked: _termsChecked,
                        onCheckedChanged: (checked) {
                          setState(() {
                            _termsChecked = checked;
                            _submitEnabled = checked == true;
                          });
                        },
                      ),
                      SizedBox(height: size.height * 0.02),

                      /// SignUp Button
                      GeneralButtonWidget(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            var event = SignupEventSubmit(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            _signupBloc.add(event);
                          }
                        },
                        text: 'Sign up',
                        enabled: _submitEnabled,
                      ),
                      SizedBox(height: size.height * 0.03),

                      /// Navigate To Login Screen
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const LoginPageWidget(),
                            ),
                          );
                          nameController.clear();
                          emailController.clear();
                          passwordController.clear();
                          _formKey.currentState?.reset();

                          widget.simpleUIController.isObscure.value = true;
                        },
                        child: WebRichTextWidget(
                          text: 'Already have an account?',
                          action: 'Login',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        );
      },
    );
  }
}
