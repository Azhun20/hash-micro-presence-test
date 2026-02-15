# Required Packages

Daftar lengkap dependencies yang dibutuhkan untuk skeleton ini.

## pubspec.yaml

Copy semua dependencies berikut ke `pubspec.yaml` Anda:

```yaml
name: your_app_name
description: Your app description
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_bloc: ^8.1.3

  # Dependency Injection
  get_it: ^7.6.4

  # Routing
  go_router: ^12.1.1

  # Functional Programming
  dartz: ^0.10.1

  # HTTP Client
  dio: ^5.4.0

  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0

  # JSON Serialization
  json_annotation: ^4.8.1

  # Code Generation
  freezed_annotation: ^2.4.1

  # Utils
  equatable: ^2.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^3.0.0

  # Code Generation
  build_runner: ^2.4.6
  freezed: ^2.4.5
  json_serializable: ^6.7.1
  hive_generator: ^2.0.1

flutter:
  uses-material-design: true

  # Uncomment and add your assets
  # assets:
  #   - assets/images/
  #   - assets/icons/

  # Add Montserrat font if you want to use it
  # fonts:
  #   - family: Montserrat
  #     fonts:
  #       - asset: assets/fonts/Montserrat-Regular.ttf
  #       - asset: assets/fonts/Montserrat-Medium.ttf
  #         weight: 500
  #       - asset: assets/fonts/Montserrat-SemiBold.ttf
  #         weight: 600
  #       - asset: assets/fonts/Montserrat-Bold.ttf
  #         weight: 700
```

## Package Descriptions

### Core Dependencies

| Package | Version | Description |
|---------|---------|-------------|
| **flutter_bloc** | ^8.1.3 | BLoC/Cubit state management |
| **get_it** | ^7.6.4 | Service locator for dependency injection |
| **go_router** | ^12.1.1 | Declarative routing |
| **dartz** | ^0.10.1 | Functional programming (Either, Option) |
| **dio** | ^5.4.0 | HTTP client for API calls |
| **hive** | ^2.2.3 | NoSQL local database |
| **hive_flutter** | ^1.1.0 | Hive Flutter integration |
| **json_annotation** | ^4.8.1 | Annotations for JSON serialization |
| **freezed_annotation** | ^2.4.1 | Annotations for immutable models |
| **equatable** | ^2.0.5 | Value equality |

### Dev Dependencies

| Package | Version | Description |
|---------|---------|-------------|
| **build_runner** | ^2.4.6 | Code generation tool |
| **freezed** | ^2.4.5 | Code generator for immutable models |
| **json_serializable** | ^6.7.1 | JSON serialization code generator |
| **hive_generator** | ^2.0.1 | Hive type adapter generator |
| **flutter_lints** | ^3.0.0 | Linting rules |

## Installation Steps

### 1. Add Dependencies

Copy the `pubspec.yaml` content above to your project, replacing `your_app_name` with your actual app name.

### 2. Get Packages

```bash
flutter pub get
```

### 3. Generate Code

After adding dependencies, generate the required code:

```bash
# Generate Freezed models and JSON serialization
flutter pub run build_runner build --delete-conflicting-outputs

# Or use watch mode for continuous generation during development
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Optional Packages

Depending on your project needs, you might want to add:

### Firebase
```yaml
firebase_core: ^2.24.2
firebase_auth: ^4.15.3
firebase_messaging: ^14.7.9
cloud_firestore: ^4.13.6
```

### Image Handling
```yaml
image_picker: ^1.0.5
cached_network_image: ^3.3.0
```

### UI Components
```yaml
shimmer: ^3.0.0
flutter_svg: ^2.0.9
lottie: ^2.7.0
```

### Utils
```yaml
intl: ^0.18.1                  # Internationalization
shared_preferences: ^2.2.2     # Simple key-value storage
path_provider: ^2.1.1          # File system paths
url_launcher: ^6.2.2           # Launch URLs
```

### Testing
```yaml
# dev_dependencies
mockito: ^5.4.4
bloc_test: ^9.1.5
```

## Font Setup (Optional)

If you want to use the Montserrat font as in the skeleton:

### 1. Download Montserrat Font

Download from [Google Fonts](https://fonts.google.com/specimen/Montserrat)

### 2. Add to Assets

Create `assets/fonts/` folder and add:
- Montserrat-Regular.ttf
- Montserrat-Medium.ttf (weight 500)
- Montserrat-SemiBold.ttf (weight 600)
- Montserrat-Bold.ttf (weight 700)

### 3. Update pubspec.yaml

```yaml
flutter:
  fonts:
    - family: Montserrat
      fonts:
        - asset: assets/fonts/Montserrat-Regular.ttf
        - asset: assets/fonts/Montserrat-Medium.ttf
          weight: 500
        - asset: assets/fonts/Montserrat-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Montserrat-Bold.ttf
          weight: 700
```

## Common Issues

### 1. Build Runner Conflicts

If you get conflicts during code generation:

```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. Version Conflicts

If you encounter version conflicts:

```bash
flutter pub upgrade
flutter pub get
```

### 3. iOS Pod Install Issues

```bash
cd ios
pod install --repo-update
cd ..
```

## Minimum SDK Versions

### Android (android/app/build.gradle)
```gradle
minSdkVersion 21
targetSdkVersion 33
```

### iOS (ios/Podfile)
```ruby
platform :ios, '12.0'
```

## Next Steps

After installing all dependencies:

1. Run code generation: `flutter pub run build_runner build --delete-conflicting-outputs`
2. Verify installation: `flutter doctor`
3. Run the app: `flutter run`
4. Start building your features! 🚀
