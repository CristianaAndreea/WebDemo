import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_demo/ui/profile/bloc/profile.dart';
import '../../../data/repository/repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial()) {
    on<ProfileEventGetDetails>(_mapGetDetailsEventToState);
    on<ProfileEventSaveDetails>(_mapSaveDetailsEventToState);
    on<ProfileEventDelete>(_mapDeleteEventToState);
    on<ProfileEventLogout>(_mapLogoutEventToState);
  }

  void _mapGetDetailsEventToState(
    ProfileEventGetDetails event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileStateLoadDetails.loading());

    final userProfileResponse = await UserRepository().getUserProfile();

    if (userProfileResponse != null && userProfileResponse.isSuccess) {
      emit(
        ProfileStateLoadDetails(
          isLoading: false,
          isSuccess: true,
          isError: false,
          savedDetails: false,
          userName: userProfileResponse.responseData['name'],
          email: userProfileResponse.responseData['email'],
          password: userProfileResponse.responseData['password'],
        ),
      );
    } else {
      emit(
        ProfileStateLoadDetails.loading().copyWith(
          isLoading: false,
          isSuccess: false,
          isError: true,
          savedDetails: false,
        ),
      );
    }
  }

  void _mapSaveDetailsEventToState(
    ProfileEventSaveDetails event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileStateLoadDetails.loading());

    final saveUserProfileResponse = await UserRepository().updateUserProfile(
      userName: event.userName,
      email: event.email,
    );

    if (saveUserProfileResponse != null && saveUserProfileResponse.isSuccess) {
      emit(
        ProfileStateLoadDetails(
          isLoading: false,
          isSuccess: true,
          isError: false,
          savedDetails: true,
          userName: saveUserProfileResponse.responseData['name'],
          email: saveUserProfileResponse.responseData['email'],
          password: saveUserProfileResponse.responseData['password'],
        ),
      );
    } else {
      emit(
        ProfileStateLoadDetails.loading().copyWith(
          isLoading: false,
          isSuccess: false,
          isError: true,
          savedDetails: false,
          email: event.email,
          userName: event.userName,
          password: event.password,
        ),
      );
    }
  }

  void _mapDeleteEventToState(
    ProfileEventDelete event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileStateLoadDetails.loading());

    final deleteUserProfileResponse =
        await UserRepository().deleteUserProfile();

    if (deleteUserProfileResponse != null &&
        deleteUserProfileResponse.isSuccess) {
      emit(ProfileStateAccountDelete(deleteUserProfileResponse.isSuccess));
    } else {
      emit(ProfileStateAccountDelete(false));
    }
  }

  void _mapLogoutEventToState(
    ProfileEventLogout event,
    Emitter<ProfileState> emit,
  ) async {
    // clear shared preferences
    final isLoggedOut = UserRepository().logout();
    emit(ProfileStateLoggedOut(await isLoggedOut));
  }
}
