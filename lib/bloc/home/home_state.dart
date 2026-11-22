import 'package:pr2/models/menu_item.dart';

abstract class HomeState {
  const HomeState();
}

/// Начальное состояние до загрузки данных.
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// Состояние загрузки данных.
class HomeLoading extends HomeState {
  const HomeLoading();
}

/// Состояние успешной загрузки данных.
class HomeLoaded extends HomeState {
  final List<MenuItem> items;
  const HomeLoaded(this.items);
}

/// Состояние ошибки загрузки данных.
class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}
