import 'package:flutter/material.dart';

@immutable
class ProfileState{}

class ProfileStateInitial extends ProfileState {}

class ProfileStateLoggedOut extends ProfileState {
  final bool isLoggedOut;

  ProfileStateLoggedOut(this.isLoggedOut);

  @override
  List<Object> get props => [isLoggedOut];
}

class ProfileStateAccountDelete extends ProfileState {
  final bool isDeleted;

  ProfileStateAccountDelete(this.isDeleted);

  @override
  List<Object> get props => [isDeleted];
}

@immutable
class ProfileStateLoadDetails extends ProfileState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final bool savedDetails;
  final String userName;
  final String email;
  final String? password;

  ProfileStateLoadDetails({
    required this.isSuccess,
    required this.isLoading,
    required this.isError,
    required this.savedDetails,
    required this.userName,
    required this.email,
    this.password,
  });

  factory ProfileStateLoadDetails.loading() {
    return ProfileStateLoadDetails(
      isSuccess: false,
      isLoading: true,
      isError: false,
      savedDetails: false,
      userName: '',
      email: '',
      password: '',
    );
  }

  ProfileStateLoadDetails copyWith({
    bool? isSuccess,
    bool? isLoading,
    bool? isError,
    bool? savedDetails,
    String? userName,
    String? email,
    String? password,
  }) {
    return ProfileStateLoadDetails(
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      savedDetails: savedDetails ?? this.savedDetails,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

@immutable
class ProfileStateSaveDetails extends ProfileState {
  final bool isSaved;

  ProfileStateSaveDetails(this.isSaved);

  @override
  List<Object> get props => [isSaved];
}
