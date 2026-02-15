# Flutter Skeleton App - Clean Architecture + BLoC

Skeleton Flutter app dengan Clean Architecture dan BLoC pattern untuk memulai project baru dengan cepat.

## 🏗️ Architecture

Project ini menggunakan **Clean Architecture** dengan **BLoC (Cubit)** pattern untuk state management.

### Layer Structure

```
lib/
├── app/
│   └── router/              # App routing configuration
├── configs/
│   ├── routes/              # Route constants
│   └── themes/              # App themes
├── constants/               # App constants
├── core/
│   ├── di/                  # Dependency injection
│   ├── error/               # Error handling
│   ├── extensions/          # Context extensions
│   ├── logging/             # App logger
│   └── result/              # Result type
├── features/
│   ├── auth/                # Authentication feature
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── di/
│   └── dashboard/           # Dashboard feature
│       ├── presentation/
│       └── di/
├── shared/
│   └── styles/              # Shared styles (colors, fonts)
└── utils/
    └── services/            # Utility services (Hive, API)
```

## ✨ Features

- ✅ Clean Architecture (Domain, Data, Presentation)
- ✅ BLoC (Cubit) Pattern for State Management
- ✅ Dependency Injection with GetIt
- ✅ Routing with GoRouter
- ✅ Local Storage with Hive
- ✅ HTTP Client with Dio
- ✅ Freezed for Immutable Models
- ✅ Error Handling with Either (dartz)
- ✅ Logging System

## 📦 Required Dependencies

Lihat file `REQUIRED_PACKAGES.md` untuk daftar lengkap dependencies yang dibutuhkan.

### Core Dependencies
- flutter_bloc
- freezed & freezed_annotation
- get_it
- go_router
- dartz
- dio
- hive & hive_flutter
- json_serializable
- equatable

## 🚀 Quick Start

### 1. Setup Dependencies

Copy semua dependencies dari `REQUIRED_PACKAGES.md` ke `pubspec.yaml` Anda.

```bash
flutter pub get
```

### 2. Generate Code

```bash
# Generate Freezed models
flutter pub run build_runner build --delete-conflicting-outputs

# Or watch mode for continuous generation
flutter pub run build_runner watch
```

### 3. Update Package Name

Replace semua `skeleton_app` dengan nama package Anda di seluruh file.

### 4. Configure API Base URL

Update `API_BASE_URL` di `lib/utils/services/api_service.dart` atau gunakan `--dart-define`:

```bash
flutter run --dart-define=API_BASE_URL=https://your-api.com/v1
```

### 5. Run the App

```bash
flutter run
```

## 📖 Documentation

Baca `SKELETON_GUIDE.md` untuk panduan lengkap:
- Cara menambahkan feature baru
- Cara membuat API endpoint
- Cara menambahkan route baru
- Best practices

## 🔑 Key Patterns

### Data Flow

```
UI (Page)
  ↓ User Action
Cubit
  ↓ Calls
UseCase
  ↓ Calls
Repository (abstract)
  ↓ Implemented by
RepositoryImpl
  ↓ Calls
DataSource (Remote/Local)
  ↓ Returns
Either<Failure, Data>
  ↓ Propagates up
Cubit emits new State
  ↓ Updates
UI rebuilds
```

### Error Handling

Menggunakan `Either<Failure, T>` dari dartz untuk error handling yang type-safe.

```dart
final result = await repository.login(email, password);

result.fold(
  (failure) => emit(state.copyWith(errorMessage: failure.message)),
  (user) => emit(state.copyWith(user: user, isAuthenticated: true)),
);
```

### State Management

Semua state menggunakan Freezed untuk immutability:

```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(false) bool isAuthenticated,
    UserEntity? user,
    String? errorMessage,
  }) = _AuthState;
}
```

## 📝 License

This skeleton is provided as-is for project scaffolding purposes.

## 🤝 Contributing

Contributions are welcome! Feel free to submit issues and enhancement requests.
