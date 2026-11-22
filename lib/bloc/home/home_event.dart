abstract class HomeEvent {
  const HomeEvent();
}

/// Событие запроса загрузки списка пунктов меню домашней страницы.
class LoadMenuItems extends HomeEvent {
  const LoadMenuItems();
}
