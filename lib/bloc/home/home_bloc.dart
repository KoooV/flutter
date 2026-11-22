import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pr2/bloc/home/home_event.dart';
import 'package:pr2/bloc/home/home_state.dart';
import 'package:pr2/data/repositories/menu_repository.dart';

/// BLoC для управления состоянием домашней страницы (HomePage).
///
/// Данные загружаются через [MenuRepository], который работает с локальной
/// базой данных Drift. Экземпляр BLoC создаётся и инжектится через DI-контейнер
/// [getIt] как фабрика — новый экземпляр на каждую страницу, чтобы не
/// использовать уже закрытый bloc при повторном открытии.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._menuRepository) : super(const HomeInitial()) {
    on<LoadMenuItems>(_onLoadMenuItems);
  }

  final MenuRepository _menuRepository;

  FutureOr<void> _onLoadMenuItems(
    LoadMenuItems event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    try {
      final items = await _menuRepository.getAllMenuItems();
      emit(HomeLoaded(items));
    } catch (e) {
      emit(const HomeError('Не удалось загрузить данные'));
    }
  }
}
