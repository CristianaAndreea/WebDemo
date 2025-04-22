import 'package:flutter/material.dart';

@immutable
class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final bool showPassword;
  final bool isSubmitEnabled;
  final String errorMessage;

  const LoginState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSuccess,
    required this.isLoading,
    required this.isError,
    required this.showPassword,
    required this.isSubmitEnabled,
    required this.errorMessage,
  });

  factory LoginState.empty() {
    return const LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSuccess: false,
      isLoading: false,
      isError: false,
      showPassword: false,
      isSubmitEnabled: false,
      errorMessage: '',
    );
  }

  LoginState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSuccess,
    bool ?isLoading,
    bool? isError,
    bool? showPassword,
    bool? isSubmitEnabled,
    String? errorMessage,
  }) {
    return LoginState(
      isEmailValid: isEmailValid?? this.isEmailValid,
      // isNameValid: isNameValid ?? this.isNameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      showPassword: showPassword ?? this.showPassword,
      isSubmitEnabled: isSubmitEnabled ?? this.isSubmitEnabled,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
