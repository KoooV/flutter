# pr2

A new Flutter project.

## Архитектура слоя данных

Слой данных разделён на три роли:

- `lib/data/database/` хранит схему и подключение к Drift/SQLite;
- `lib/data/repositories/` преобразует операции БД в операции предметной модели;
- `lib/di/` настраивает создание и связывание зависимостей через GetIt.

### Таблица Drift

Таблица `MenuItems` описана в `lib/data/database/menu_items_table.dart` и отображается в таблицу SQLite `menu_items`.

| Поле | Тип Drift | Ограничения |
|---|---|---|
| `id` | `IntColumn` | первичный ключ, автоинкремент |
| `title` | `TextColumn` | обязательное, от 1 до 100 символов |
| `subtitle` | `TextColumn` | обязательное, от 1 до 200 символов |
| `description` | `TextColumn` | обязательное |
| `imagePath` | `TextColumn` | обязательное, путь к asset |

`@DataClassName('MenuItemEntity')` задаёт имя сгенерированного data-класса строки. Файл `lib/data/database/app_database.g.dart` создан кодогенератором Drift и хранит таблицу, запросы и классы companion; его редактировать вручную не нужно.

Класс `AppDatabase` зарегистрирован как синглтон. При `AppDatabase.create()` создаётся файл `pr2_app.sqlite` в каталоге документов приложения. База создаётся через `NativeDatabase.createInBackground`, что переносит работу SQLite в фоновое выполнение.

### Миграции и начальное заполнение

Текущая версия схемы — `schemaVersion = 1`. Стратегия миграции содержит обработчик `onCreate`: для новой базы вызывается `m.createAll()`, поэтому все таблицы создаются автоматически при первом запуске.

Для существующей базы с более высокой или различающейся схемой пока нет обработчика `onUpgrade`. При изменении схемы в будущем необходимо инкрементировать `schemaVersion` и описать переходы в `onUpgrade: (m, from, to) async { ... }`, сохраняя совместимость данных.

Первичные данные создаются репозиторием, а не миграцией. После открытия базы `configureDependencies()` вызывает `MenuRepository.seedIfEmpty()`. Метод читает `menu_items`; если таблица пуста, последовательно вставляет пять пунктов: `Дашборды`, `Отчёты`, `Источники`, `DAX` и `Экспорт`. Повторный запуск не создаёт дубликаты. Запись в таблице хранит строковый `imagePath`, а UI-модели дополнительно получают `IconData` по заголовку.

### Паттерн Repository

`MenuRepository` является единственной точкой доступа приложения к таблице пунктов меню. Он переводит сущности Drift (`MenuItemEntity`) в доменную модель `MenuItem` и обратно в `MenuItemsCompanion`.

Поддерживаемые операции:

- `getAllMenuItems()` — выборка всех строк;
- `getMenuItemById(int id)` — выборка по первичному ключу;
- `insertMenuItem(MenuItem item)` — вставка новой строки;
- `updateMenuItem(MenuItem item)` — замена строки по `id`;
- `deleteMenuItem(int id)` — удаление строки;
- `seedIfEmpty()` — первичное заполнение пустой таблицы.

BLoC не обращается к Drift напрямую. Он получает `MenuRepository` через конструктор и только вызывает методы репозитория. Поэтому структуру базы можно заменить или изменить, не изменяя BLoC-представление UI-моделей.

### DI-контейнер

В приложении используется GetIt. Глобальный контейнер объявлен в `lib/di/injection_container.dart` как `getIt`.

`configureDependencies()` выполняется в `main()` до запуска `MaterialApp` и регистрирует зависимости:

- `AppDatabase` — singleton, созданный асинхронно через `AppDatabase.create()`;
- `MenuRepository` — lazy singleton, который создаётся при первом обращении и получает `AppDatabase`;
- `HomeBloc` — factory, поэтому при каждом получении создаётся новый экземпляр BLoC.

Открытие зависимостей идёт снизу вверх: база создаётся первой, репозиторий получает готовую базу, а BLoC получает репозиторий. Страница `HomePage` получает `HomeBloc` из контейнера через `getIt<HomeBloc>()`; UI не создаёт DAO или экземпляры базы вручную.

При завершении работы `dispose()` закрывает `AppDatabase` и сбрасывает GetIt. Это освобождает SQLite-соединение и удаляет зарегистрированные зависимости.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
