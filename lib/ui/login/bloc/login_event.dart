import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

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
class LoginEventSubmit extends LoginEvent {
  final String email;
  final String password;

  const LoginEventSubmit({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
