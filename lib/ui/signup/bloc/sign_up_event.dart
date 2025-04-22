import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}
//
// class RegisterEventEmailChanged extends RegisterEvent {
//   final String email;
//
//   const RegisterEventEmailChanged({required this.email});
//
//   @override
//   List<Object> get props => [email];
// }

// class RegisterEventNameChanged extends RegisterEvent {
//   final String name;
//
//   const RegisterEventNameChanged({@required this.name});
//
//   @override
//   List<Object> get props => [name];
// }

// class RegisterEventPasswordChanged extends RegisterEvent {
//   final String password;
//
//   const RegisterEventPasswordChanged({required this.password});
//
//   @override
//   List<Object> get props => [password];
// }
//
// class RegisterEventShowPassword extends RegisterEvent {
//   final bool showPassword;
//
//   const RegisterEventShowPassword({required this.showPassword});
//
//   @override
//   List<Object> get props => [showPassword];
// }
//
class SignupEventSubmit extends SignupEvent {
  final String name;
  final String email;
  final String password;

  const SignupEventSubmit({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
