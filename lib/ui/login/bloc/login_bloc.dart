import 'package:bloc/bloc.dart';

import '../../../data/repository/repository.dart';
import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginState.empty()) {
    on<LoginEventSubmit>(_mapSubmitEventToState);
  }

  void _mapSubmitEventToState(
    LoginEventSubmit event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    final response = await UserRepository().login(
      email: event.email,
      password: event.password,
    );

    if (response.isSuccess) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          isError: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          isError: true,
          errorMessage: response.errorMessage,
        ),
      );
    }
  }
}
