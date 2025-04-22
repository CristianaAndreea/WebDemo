import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:web_demo/routes/bloc/routing.dart';

import '../../data/storage/storage.dart';

class RoutingBloc extends Bloc<RoutingEvent, RoutingState> {
  RoutingBloc() : super(AuthenticationUninitialized()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<RoutingState> emit,
  ) async {
    emit(AuthenticationLoading());
    final isLoggedIn = await UserDataStorage().isLoggedIn();
    if (isLoggedIn) {
      emit(AuthenticationAuthenticated());
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<RoutingState> emit) async {
    emit(AuthenticationAuthenticated());
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<RoutingState> emit) async {
    await UserDataStorage().clearLoginState();
    emit(AuthenticationUnauthenticated());
  }
}
