import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pr2/bloc/home/home_event.dart';
import 'package:pr2/bloc/home/home_state.dart';
import 'package:pr2/data/menu_items_data.dart';

/// BLoC для управления состоянием домашней страницы (HomePage).
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<LoadMenuItems>(_onLoadMenuItems);
  }

  FutureOr<void> _onLoadMenuItems(
    LoadMenuItems event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    try {
      // Имитация асинхронной загрузки данных (без внешнего слоя данных).
      await Future.delayed(const Duration(seconds: 1));

      final items = menuItems;
      emit(HomeLoaded(items));
    } catch (e) {
      emit(const HomeError('Не удалось загрузить данные'));
    }
  }
}
