# Flutter Skeleton - Complete Guide

Panduan lengkap untuk menggunakan dan mengembangkan aplikasi dengan skeleton ini.

## 📚 Table of Contents

1. [Getting Started](#getting-started)
2. [Project Structure](#project-structure)
3. [Adding New Features](#adding-new-features)
4. [Adding API Endpoints](#adding-api-endpoints)
5. [Adding Routes](#adding-routes)
6. [State Management](#state-management)
7. [Error Handling](#error-handling)
8. [Best Practices](#best-practices)

---

## Getting Started

### Initial Setup

1. **Copy skeleton ke project baru**
   ```bash
   # Copy folder lib_baru ke project baru Anda
   cp -r lib_baru/* your-new-project/lib/
   ```

2. **Update package name**
   - Replace `skeleton_app` dengan nama package Anda di semua file
   - Gunakan Find & Replace di IDE Anda

3. **Install dependencies**
   ```bash
   fvm flutter pub get
   fvm flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   fvm flutter run
   ```

---

## Project Structure

### Feature Structure

Setiap feature mengikuti Clean Architecture dengan 3 layer:

```
features/your_feature/
├── di/                          # Dependency Injection
│   └── your_feature_di.dart
├── domain/                      # Business Logic Layer
│   ├── entities/                # Business objects (Equatable)
│   ├── repositories/            # Repository interfaces
│   └── usecases/                # Use cases
├── data/                        # Data Layer
│   ├── models/                  # Data models (JSON)
│   ├── datasources/             # API/Local data sources
│   └── repositories/            # Repository implementations
└── presentation/                # UI Layer
    ├── cubit/                   # State management
    ├── views/                   # Pages
    └── widgets/                 # Feature-specific widgets
```

---

## Adding New Features

### Step-by-Step Guide

#### 1. Create Feature Structure

```bash
mkdir -p lib/features/my_feature/{di,domain/{entities,repositories,usecases},data/{models,datasources,repositories},presentation/{cubit,views,widgets}}
```

#### 2. Domain Layer

**Entity** (`domain/entities/my_entity.dart`):

Entity menggunakan **Equatable** (bukan Freezed). Tidak perlu `build_runner` untuk entity —
cukup tulis manual. Sertakan semua field di `props` agar value-equality berfungsi, dan
sediakan `copyWith` bila perlu update immutable di layer presentation.

```dart
import 'package:equatable/equatable.dart';

class MyEntity extends Equatable {
  final String id;
  final String name;

  const MyEntity({
    required this.id,
    required this.name,
  });

  MyEntity copyWith({
    String? id,
    String? name,
  }) {
    return MyEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
```

> **Catatan:** hanya **entity** yang pakai Equatable. **Model** (data layer) tetap pakai
> `json_serializable` (+ Freezed bila perlu) untuk serialisasi JSON, dan **State** (presentation)
> tetap pakai Freezed untuk `copyWith` + `@Default`.

**Repository Interface** (`domain/repositories/my_repository.dart`):
```dart
import 'package:dartz/dartz.dart';
import 'package:your_app/core/error/failure.dart';
import 'package:your_app/features/my_feature/domain/entities/my_entity.dart';

abstract class MyRepository {
  Future<Either<Failure, List<MyEntity>>> getItems();
  Future<Either<Failure, MyEntity>> getItem(String id);
}
```

**UseCase** (`domain/usecases/get_items_usecase.dart`):
```dart
import 'package:dartz/dartz.dart';
import 'package:your_app/core/error/failure.dart';
import 'package:your_app/features/my_feature/domain/entities/my_entity.dart';
import 'package:your_app/features/my_feature/domain/repositories/my_repository.dart';

class GetItemsUseCase {
  final MyRepository repository;

  GetItemsUseCase(this.repository);

  Future<Either<Failure, List<MyEntity>>> call() {
    return repository.getItems();
  }
}
```

#### 3. Data Layer

**Model** (`data/models/my_model.dart`):
```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:your_app/features/my_feature/domain/entities/my_entity.dart';

part 'my_model.g.dart';

@JsonSerializable()
class MyModel {
  final String id;
  final String name;

  MyModel({required this.id, required this.name});

  factory MyModel.fromJson(Map<String, dynamic> json) =>
      _$MyModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyModelToJson(this);

  MyEntity toEntity() {
    return MyEntity(id: id, name: name);
  }
}
```

**Remote DataSource** (`data/datasources/my_remote_datasource.dart`):
```dart
import 'package:your_app/features/my_feature/data/models/my_model.dart';
import 'package:your_app/utils/services/api_service.dart';

abstract class MyRemoteDataSource {
  Future<List<MyModel>> getItems();
}

class MyRemoteDataSourceImpl implements MyRemoteDataSource {
  final ApiService apiService;

  MyRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<MyModel>> getItems() async {
    final response = await apiService.dio.get('/items');
    final List<dynamic> data = response.data['data'];
    return data.map((json) => MyModel.fromJson(json)).toList();
  }
}
```

**Repository Implementation** (`data/repositories/my_repository_impl.dart`):
```dart
import 'package:dartz/dartz.dart';
import 'package:your_app/core/error/failure.dart';
import 'package:your_app/features/my_feature/data/datasources/my_remote_datasource.dart';
import 'package:your_app/features/my_feature/domain/entities/my_entity.dart';
import 'package:your_app/features/my_feature/domain/repositories/my_repository.dart';

class MyRepositoryImpl implements MyRepository {
  final MyRemoteDataSource remoteDataSource;

  MyRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<MyEntity>>> getItems() async {
    try {
      final models = await remoteDataSource.getItems();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }
}
```

#### 4. Presentation Layer

**State** (`presentation/cubit/my_state.dart`):
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:your_app/features/my_feature/domain/entities/my_entity.dart';

part 'my_state.freezed.dart';

@freezed
class MyState with _$MyState {
  const factory MyState({
    @Default(false) bool isLoading,
    @Default([]) List<MyEntity> items,
    String? errorMessage,
  }) = _MyState;
}
```

**Cubit** (`presentation/cubit/my_cubit.dart`):
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app/core/logging/app_logger.dart';
import 'package:your_app/features/my_feature/domain/usecases/get_items_usecase.dart';
import 'package:your_app/features/my_feature/presentation/cubit/my_state.dart';

class MyCubit extends Cubit<MyState> {
  final GetItemsUseCase getItemsUseCase;

  MyCubit({required this.getItemsUseCase}) : super(const MyState());

  Future<void> loadItems() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await getItemsUseCase();

    result.fold(
      (failure) {
        AppLogger.error('Load items failed', failure.message);
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ));
      },
      (items) {
        emit(state.copyWith(
          isLoading: false,
          items: items,
        ));
      },
    );
  }
}
```

**Page** (`presentation/views/my_page.dart`):
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app/core/extensions/context_extensions.dart';
import 'package:your_app/features/my_feature/presentation/cubit/my_cubit.dart';
import 'package:your_app/features/my_feature/presentation/cubit/my_state.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    context.read<MyCubit>().loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Feature')),
      body: BlocBuilder<MyCubit, MyState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          if (state.items.isEmpty) {
            return const Center(child: Text('No items'));
          }

          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return ListTile(
                title: Text(item.name),
              );
            },
          );
        },
      ),
    );
  }
}
```

#### 5. Dependency Injection

**DI File** (`di/my_feature_di.dart`):
```dart
import 'package:get_it/get_it.dart';
import 'package:your_app/features/my_feature/data/datasources/my_remote_datasource.dart';
import 'package:your_app/features/my_feature/data/repositories/my_repository_impl.dart';
import 'package:your_app/features/my_feature/domain/repositories/my_repository.dart';
import 'package:your_app/features/my_feature/domain/usecases/get_items_usecase.dart';
import 'package:your_app/features/my_feature/presentation/cubit/my_cubit.dart';
import 'package:your_app/utils/services/api_service.dart';

class MyFeatureDI {
  static void inject(GetIt sl) {
    // Data sources
    sl.registerLazySingleton<MyRemoteDataSource>(
      () => MyRemoteDataSourceImpl(sl<ApiService>()),
    );

    // Repository
    sl.registerLazySingleton<MyRepository>(
      () => MyRepositoryImpl(sl<MyRemoteDataSource>()),
    );

    // Use cases
    sl.registerLazySingleton<GetItemsUseCase>(
      () => GetItemsUseCase(sl<MyRepository>()),
    );

    // Cubit
    sl.registerFactory<MyCubit>(
      () => MyCubit(getItemsUseCase: sl<GetItemsUseCase>()),
    );
  }
}
```

#### 6. Register DI in Service Locator

Edit `lib/core/di/service_locator.dart`:
```dart
import 'package:your_app/features/my_feature/di/my_feature_di.dart';

Future<void> setupServiceLocator() async {
  // ... existing code ...

  // Register features
  AuthDI.inject(sl);
  DashboardDI.inject(sl);
  MyFeatureDI.inject(sl);  // Add this line

  _isSetupComplete = true;
}
```

#### 7. Add Route

Edit `lib/configs/routes/route.dart`:
```dart
class Routes {
  Routes._();

  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String myFeature = '/my-feature';  // Add this
}
```

Edit `lib/app/router/app_router.dart`:
```dart
GoRoute(
  path: Routes.myFeature,
  name: Routes.myFeature,
  pageBuilder: (context, state) => MaterialPage(
    child: BlocProvider(
      create: (_) => sl<MyCubit>(),
      child: const MyPage(),
    ),
  ),
),
```

#### 8. Generate Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Adding API Endpoints

### 1. Add to Constants

Edit `lib/constants/api_constant.dart`:
```dart
class ApiConstant {
  ApiConstant._();

  // Auth endpoints
  static const String login = '/auth/login';

  // My Feature endpoints
  static const String getItems = '/items';
  static const String getItem = '/items/{id}';
}
```

### 2. Use in DataSource

```dart
final response = await apiService.dio.get(ApiConstant.getItems);
```

---

## Adding Routes

### 1. Define Route Constant

```dart
static const String myRoute = '/my-route';
```

### 2. Add to Router

```dart
GoRoute(
  path: Routes.myRoute,
  name: Routes.myRoute,
  pageBuilder: (context, state) => MaterialPage(
    child: BlocProvider(
      create: (_) => sl<MyCubit>(),
      child: const MyPage(),
    ),
  ),
),
```

### 3. Navigate

```dart
// Replace current route
context.go(Routes.myRoute);

// Push new route
context.push(Routes.myRoute);

// With parameters
context.push('${Routes.myRoute}?id=123');
```

---

## State Management

### BLoC (Cubit) Pattern

- Extend `Cubit<YourState>`
- Use `emit()` to update state
- All states must be Freezed classes
- Use `copyWith()` for immutable updates

### Example

```dart
class MyCubit extends Cubit<MyState> {
  MyCubit() : super(const MyState());

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }
}
```

---

## Error Handling

### Using Either

```dart
Future<Either<Failure, Data>> fetchData() async {
  try {
    final data = await dataSource.fetch();
    return Right(data);
  } catch (e, stackTrace) {
    return Left(mapExceptionToFailure(e, stackTrace));
  }
}
```

### In Cubit

```dart
final result = await useCase();

result.fold(
  (failure) => emit(state.copyWith(errorMessage: failure.message)),
  (data) => emit(state.copyWith(data: data)),
);
```

---

## Best Practices

### 1. Naming Conventions
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables: `camelCase`
- Private: `_privateMember`

### 2. Feature Naming
- Entity: `ProductEntity`
- Model: `ProductModel`
- Repository: `ProductRepository`
- UseCase: `GetProductsUseCase`
- Cubit: `ProductCubit`
- State: `ProductState`
- Page: `ProductPage`

### 3. Code Organization
- Keep UI pure (no business logic)
- Business logic in UseCases
- Cubits orchestrate UseCases
- Always inject dependencies via constructor

### 4. Error Messages
- User-facing errors should be user-friendly
- Log technical errors with AppLogger
- Map exceptions to Failure classes

### 5. State Management
- Use Freezed for all states
- Keep states immutable
- Use `copyWith()` for updates
- Handle loading, error, and success states

---

## Tips & Tricks

### Logging
```dart
AppLogger.debug('Debug message');
AppLogger.info('Info message');
AppLogger.error('Error', error, stackTrace);
AppLogger.auth('Authentication event');
AppLogger.network('API request');
```

### Context Extensions
```dart
context.showSnackBar('Message');
context.showErrorSnackBar('Error message');
context.primaryColor
context.screenWidth
context.unfocus()
```

### Quick Navigation
```dart
context.go(Routes.dashboard);
context.push(Routes.detail);
context.pop();
```

---

## Troubleshooting

### Build Runner Issues
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### GetIt Issues
- Make sure DI is registered in `setupServiceLocator()`
- Use `sl<T>()` to get instances
- Use `registerLazySingleton` for singletons
- Use `registerFactory` for new instances each time

### Freezed Issues
- Run build_runner after creating/modifying Freezed classes
- Import the generated `.freezed.dart` file
- Use `part 'filename.freezed.dart';`

---

## Next Steps

1. Customize theme in `lib/configs/themes/theme.dart`
2. Add more features following the guide above
3. Implement proper error handling
4. Add tests for your features
5. Configure CI/CD

Happy coding! 🚀
