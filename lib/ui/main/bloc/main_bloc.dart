import 'package:bloc/bloc.dart';

import 'main.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.empty()) {
    on<MainEventNavigate>(_mapNavigateEventToState);
    on<MainEventOnTabChange>(_mapOnTabChangeEventToState);
  }

  void _mapNavigateEventToState(
    MainEventNavigate event,
    Emitter<MainState> emit,
  ) async {
    emit(state.copyWith(route: event.route));
  }

  void _mapOnTabChangeEventToState(
      MainEventOnTabChange event,
      Emitter<MainState> emit,
      ) async {
    emit(state.copyWith(currentTabIndex: event.tabIndex));
  }
}
