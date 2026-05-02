# Tiptap Tour

Group trip expense manager with offline P2P communication. Flutter app targeting iOS and Android.

## Build & Run

```bash
flutter pub get                           # Install dependencies
dart run build_runner build --delete-conflicting-outputs  # Generate Drift/Freezed code
flutter run                                # Run on connected device
flutter build apk --release               # Android release build
flutter build ipa --release               # iOS release build
flutter test                              # Run all tests
flutter analyze                           # Run linter
```

## Architecture

Clean Architecture with 4 layers:
- `lib/presentation/` — UI screens, widgets, theme
- `lib/application/` — services, Riverpod providers
- `lib/domain/` — entities (Freezed), enums, repository interfaces
- `lib/infrastructure/` — Drift DB, DAOs, P2P managers, sync engine

## Key Conventions

- **State management**: Riverpod 2.x with `StateNotifier` / `AsyncNotifier`
- **Database**: Drift (SQLite) for relational data. Hive for key-value settings.
- **Entities**: Freezed immutable classes in `domain/entities/`
- **Navigation**: GoRouter, route names in `core/router/route_names.dart`
- **Theme**: Material 3, dark/light mode, glassmorphism aesthetic
- **Fonts**: Space Grotesk (headings), Plus Jakarta Sans (body)
- **Currency**: BDT (৳) is default, support for USD, EUR, GBP, INR
- **Sync**: Hybrid Logical Clocks (HLC) for offline conflict resolution
- **Soft deletes**: Use `isDeleted` flag for sync-safe deletions
- **IDs**: UUID v4 for all entity IDs

## Code Generation

After modifying Drift tables, Freezed entities, or Riverpod providers:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Package ID

- Android: `com.ryven.tiptap_tour`
- iOS: `com.ryven.tiptapTour`
