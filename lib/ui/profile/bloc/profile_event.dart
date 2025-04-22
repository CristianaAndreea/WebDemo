import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileEventGetDetails extends ProfileEvent {
  const ProfileEventGetDetails();
}

class ProfileEventSaveDetails extends ProfileEvent {
  final String userName;
  final String email;
  final String password;

  const ProfileEventSaveDetails({
    required this.userName,
    required this.email,
    required this.password,
  });
}

class ProfileEventDelete extends ProfileEvent {
  const ProfileEventDelete();
}

class ProfileEventLogout extends ProfileEvent {
  const ProfileEventLogout();
}
