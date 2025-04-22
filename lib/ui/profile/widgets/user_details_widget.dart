import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:web_demo/ui/common/common.dart';
import 'package:web_demo/ui/controller/simple_ui_controller.dart';

import '../../../utils/validators.dart';
import '../../../theme/text_styles.dart';
import '../bloc/profile.dart';

class UserDetailsWidget extends StatefulWidget {
  final String userName;
  final String email;
  final String password;

  const UserDetailsWidget({
    super.key,
    required this.userName,
    required this.email,
    required this.password,
  });

  @override
  State<StatefulWidget> createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late ProfileBloc _profileBloc;

  final _formKey = GlobalKey<FormState>();
  SimpleUIController simpleUIController = Get.put(SimpleUIController());

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
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
    nameController = TextEditingController(text: widget.userName);
    emailController = TextEditingController(text: widget.email);
    passwordController = TextEditingController(text: widget.password);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User Details', style: WebTextStyles.bodyXLargeSemiBold),
          const SizedBox(height: 40),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(height: size.height * 0.03),

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
              SizedBox(height: size.height * 0.03),

              /// password
              // Obx(
              //   () => TextFormField(
              //     readOnly: true,
              //     style: textFormFieldStyle(),
              //     controller: passwordController,
              //     obscureText: simpleUIController.isObscure.value,
              //     decoration: InputDecoration(
              //       prefixIcon: const Icon(Icons.lock),
              //       suffixIcon: IconButton(
              //         icon: Icon(
              //           simpleUIController.isObscure.value
              //               ? Icons.visibility
              //               : Icons.visibility_off,
              //         ),
              //         onPressed: () {
              //           simpleUIController.isObscureActive();
              //         },
              //       ),
              //       hintText: 'Password',
              //       border: const OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(15)),
              //       ),
              //     ),
              //     // The validator receives the text that the user has entered.
              //     validator: (value) {
              //       // if (value == null || value.isEmpty) {
              //       //   return 'Please enter some text';
              //       // } else if (value.length < 7) {
              //       //   return 'at least enter 6 characters';
              //       // } else if (value.length > 13) {
              //       //   return 'maximum character is 13';
              //       // }
              //       return null;
              //     },
              //   ),
              // ),
              Obx(
                    () => PasswordFormFieldWidget(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    // There is an issue here because the password is encrypted and it doesn't match the validator
                    // else if (!Validators.isValidPassword(value)) {
                    //   return 'Password must have between 5 and 40 characters';
                    // }
                    return null;
                  },
                  obscureText: simpleUIController.isObscure.value,
                  onToggleVisibility: () {
                    simpleUIController.isObscureActive();
                  },
                ),
              ),
              SizedBox(height: size.height * 0.04),

              /// Save updates Button
              GeneralButtonWidget(
                text: "Save",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var event = ProfileEventSaveDetails(
                      userName: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    _profileBloc.add(event);
                    // TODO i need to update the userName in MainScreen
                    _formKey.currentState?.reset();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
