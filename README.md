# Flutter Skeleton App

A production-ready Flutter skeleton application built with **Clean Architecture** and modern best practices. This project serves as a solid starting foundation for building scalable, maintainable Flutter applications.

---

## Overview

This skeleton app provides a pre-configured project structure with authentication flow, dependency injection, state management, routing, local storage, and a full theming system — ready to be extended into any feature-based Flutter application.

---

## Features

- **Authentication Flow** — Login screen with form validation, error handling, and session persistence
- **Clean Architecture** — Data, Domain, and Presentation layers per feature
- **State Management** — BLoC/Cubit pattern with immutable Freezed states
- **Dependency Injection** — GetIt service locator with per-feature DI modules
- **Routing** — Declarative navigation using GoRouter
- **Local Storage** — Hive NoSQL database for token and user data persistence
- **HTTP Client** — Dio with auth interceptor for automatic token injection
- **Theming** — Material 3 theme with custom typography and color system
- **Localization** — i18n support ready via Flutter's built-in `intl`
- **Logging** — Categorized debug logger (debug, info, warning, error, network, auth)
- **Error Handling** — Typed failure system using `Either<Failure, Success>` pattern

---

## Project Structure

```
lib/
├── main.dart
├── app/
│   └── router/             # GoRouter configuration
├── configs/
│   ├── environment/        # Environment variables
│   ├── routes/             # Route name constants
│   ├── themes/             # Material theme setup
│   └── ui/                 # UI configurations
├── constants/              # API, asset, and storage key constants
├── core/
│   ├── di/                 # Global dependency injection setup
│   ├── error/              # Failure types (Server, Cache, Unexpected)
│   ├── extensions/         # Context and utility extensions
│   ├── localization/       # i18n configuration
│   ├── logging/            # AppLogger utility
│   └── result/             # Result<T> type wrapper
├── features/
│   └── auth/               # Authentication feature (modular)
│       ├── data/           # DataSources, Models, Repository impl
│       ├── domain/         # Entities, Repository abstract, UseCases
│       ├── di/             # Feature-level DI
│       └── presentation/   # Cubit, State, Views
├── shared/
│   ├── styles/             # Color palette & typography
│   ├── widgets/            # Reusable UI components
│   ├── models/             # Shared data models
│   └── cubit/              # Shared cubits
└── utils/
    ├── services/           # ApiService (Dio), HiveService
    ├── extensions/         # String, DateTime, Theme extensions
    ├── functions/          # Utility functions
    └── helpers/            # Helper classes
```

---

## Architecture

This project follows **Clean Architecture** with a **feature-based modular** structure:

```
Feature
├── Data Layer
│   ├── DataSources     → Remote (API) & Local (Hive)
│   ├── Models          → JSON-serializable with json_annotation
│   └── Repositories    → Implements domain repository contracts
├── Domain Layer
│   ├── Entities        → Pure Dart objects
│   ├── Repositories    → Abstract contracts
│   └── UseCases        → Single-responsibility business logic
└── Presentation Layer
    ├── Cubit           → BLoC state management
    ├── State           → Freezed immutable state classes
    └── Views           → UI screens and widgets
```

**Data Flow Example (Login):**
```
LoginPage → AuthCubit → LoginUseCase → AuthRepository
         → RemoteDataSource (Dio API call)
         → LocalDataSource (Hive token storage)
         → Either<Failure, UserEntity>
         → AuthState (authenticated)
         → Navigate to Dashboard
```

---

## Tech Stack

| Category | Package |
|---|---|
| State Management | `flutter_bloc` |
| Dependency Injection | `get_it` |
| Routing | `go_router` |
| HTTP Client | `dio` |
| Local Storage | `hive` + `hive_flutter` |
| Immutable State | `freezed` + `freezed_annotation` |
| JSON Serialization | `json_serializable` + `json_annotation` |
| Functional Error Handling | `dartz` |
| Value Equality | `equatable` |
| Localization | `intl` |
| SVG Support | `flutter_svg` |
| Notifications | `another_flushbar` |
| Fonts | Montserrat (primary), Rajdhani (secondary) |

---

## Getting Started

### Prerequisites

- Flutter SDK (see `.fvmrc` for version — FVM recommended)
- Dart SDK `^3.8.1`

### Setup

```bash
# Clone the repository
git clone <your-repo-url>
cd skeleton_app

# Install dependencies
flutter pub get

# Generate code (Freezed, JSON, Hive adapters)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Build

```bash
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web
flutter build macos      # macOS
```

---

## Adding a New Feature

1. Create a new directory under `lib/features/<feature_name>/`
2. Set up the three layers: `data/`, `domain/`, `presentation/`
3. Add a `di/` module for the feature's dependency injection
4. Register the DI module in `core/di/service_locator.dart`
5. Define routes in `configs/routes/route.dart` and register in `app/router/app_router.dart`

---

## Code Generation

This project uses code generation for Freezed, JSON serialization, and Hive adapters. After modifying any annotated files, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

For continuous watching during development:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## Environment

Configure environment variables in `lib/configs/environment/`. This allows switching between development, staging, and production API endpoints.

---

## License

This project is intended as a starting template. Modify and use it freely for your own applications.
