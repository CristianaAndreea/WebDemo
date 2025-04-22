import 'package:bloc/bloc.dart';
import 'package:web_demo/ui/signup/bloc/singup.dart';

import '../../../data/repository/repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  // int _nameLength = 0;
  final int _emailLength = 0;
  final int _passwordLength = 0;

  SignupBloc() : super(SignupState.empty()) {
    on<SignupEventSubmit>(_mapSubmitEventToState);
    // on<SelectCategory>(_mapSelectCategoryEventToState);
  }

  // Stream<RegisterState> _mapEmailChangedEventToState(
  //     RegisterEventEmailChanged event) async* {
  //   _emailLength = event.email.length;
  //
  //   final isEmailValid =
  //   _emailLength == 0 ? true : Validators.isValidEmail(event.email);
  //
  //   yield state.copyWith(
  //     isEmailValid: isEmailValid,
  //     isSubmitEnabled: isEmailValid &&
  //         // _nameLength > 0 &&
  //         _emailLength > 0 &&
  //         _passwordLength > 0 &&
  //         state.isPasswordValid,
  //   );
  // }

  // Stream<RegisterState> _mapPasswordChangedEventToState(
  //     RegisterEventPasswordChanged event) async* {
  //   _passwordLength = event.password.length;
  //
  //   final passwordValidator = await APISettingsRepository().getPasswordRules();
  //   final isPasswordValid = _passwordLength == 0
  //       ? true
  //       : passwordValidator.validate(event.password);
  //
  //   yield state.copyWith(
  //     isPasswordValid: isPasswordValid,
  //     isSubmitEnabled: isPasswordValid &&
  //         _emailLength > 0 &&
  //         // _nameLength > 0 &&
  //         _passwordLength > 0 &&
  //         state.isEmailValid,
  //   );
  // }

  // Stream<RegisterState> _mapNameChangedEventToState(
  //     RegisterEventNameChanged event) async* {
  //   _nameLength = event.name.length;
  //
  //   final isNameValid =
  //       _nameLength == 0 ? true : Validators.isNameValid(event.name);
  //
  //   yield state.copyWith(
  //     isNameValid: isNameValid,
  //     isSubmitEnabled: isNameValid &&
  //         _emailLength > 0 &&
  //         _nameLength > 0 &&
  //         _passwordLength > 0 &&
  //         state.isEmailValid,
  //   );
  // }

  // Stream<RegisterState> _mapShowPasswordEventToState(
  //     RegisterEventShowPassword event) async* {
  //   yield state.copyWith(
  //     showPassword: event.showPassword,
  //   );
  // }

  void _mapSubmitEventToState(
    SignupEventSubmit event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    final response = await UserRepository().register(
      name: event.name,
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
        ),
      );
    }
  }
}
