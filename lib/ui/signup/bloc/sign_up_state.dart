import 'package:flutter/material.dart';

@immutable
class SignupState {
  final bool isEmailValid;
  // final bool isNameValid;
  final bool isPasswordValid;
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final bool showPassword;
  final bool isSubmitEnabled;

  const SignupState({
    required this.isEmailValid,
    // @required this.isNameValid,
    required this.isPasswordValid,
    required this.isSuccess,
    required this.isLoading,
    required this.isError,
    required this.showPassword,
    required this.isSubmitEnabled,
  });

  factory SignupState.empty() {
    return const SignupState(
      isEmailValid: true,
      // isNameValid: true,
      isPasswordValid: true,
      isSuccess: false,
      isLoading: false,
      isError: false,
      showPassword: false,
      isSubmitEnabled: false,
    );
  }

  SignupState copyWith({
    bool? isEmailValid,
    // bool isNameValid,
    bool? isPasswordValid,
    bool? isSuccess,
    bool ?isLoading,
    bool? isError,
    bool? showPassword,
    bool? isSubmitEnabled,
  }) {
    return SignupState(
      isEmailValid: isEmailValid?? this.isEmailValid,
      // isNameValid: isNameValid ?? this.isNameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      showPassword: showPassword ?? this.showPassword,
      isSubmitEnabled: isSubmitEnabled ?? this.isSubmitEnabled,
    );
  }
}
