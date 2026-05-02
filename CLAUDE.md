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

## Project Structure

```
lib/
├── core/
│   ├── constants/         # category_constants.dart (ExpenseCategory enum)
│   ├── router/            # app_router.dart, route_names.dart (GoRouter)
│   └── utils/             # hlc.dart, debt_simplifier.dart, currency_formatter.dart
├── domain/
│   ├── entities/          # Freezed: user.dart, trip.dart, expense.dart, message.dart, p2p_peer.dart
│   ├── enums/             # split_type.dart, message_type.dart, connection_state.dart
│   └── repositories/      # Interfaces: chat_repository.dart, etc.
├── application/
│   └── providers/         # Riverpod providers (see Provider Map below)
├── infrastructure/
│   ├── database/
│   │   ├── app_database.dart    # 11 tables, 5 DAOs
│   │   ├── daos/                # trip_dao, expense_dao, chat_dao, sync_dao, user_dao
│   │   └── tables/              # Table definitions (users, trips, expenses, etc.)
│   ├── p2p/
│   │   ├── p2p_message.dart     # Protocol: 9 message types, binary framing
│   │   └── p2p_service.dart     # UDP discovery + TCP sockets
│   └── sync/
│       └── sync_engine.dart     # Delta sync with HLC timestamps
└── presentation/
    ├── theme/             # app_theme, app_colors, app_typography, glass_theme, app_animations
    ├── widgets/           # Reusable: glass_card, chat_bubble, avatar_circle, empty_state, error_state, etc.
    ├── screens/
    │   ├── onboarding/    # First-run name entry
    │   ├── home/          # Trip list + create_trip_sheet
    │   ├── trip/          # trip_detail_screen (4-tab), members_view
    │   ├── expense/       # expense_list_view, add_expense_sheet
    │   ├── balance/       # balance_view (balances + settlements)
    │   ├── chat/          # chat_view (text, image, reply, system messages)
    │   ├── nearby/        # nearby_screen (radar animation, peer discovery)
    │   ├── summary/       # summary_screen (pie chart, trip breakdown)
    │   └── settings/      # settings_screen (theme, currency, profile, about)
    └── main_shell.dart    # Bottom nav (Trips, Nearby, Summary, Settings)
```

## Provider Map

| Provider | Type | Purpose |
|---|---|---|
| `databaseProvider` | Provider | AppDatabase singleton |
| `themeProvider` | StateNotifierProvider | Theme mode (system/light/dark) |
| `currencyProvider` | StateNotifierProvider | Default currency |
| `currentUserProvider` | FutureProvider | Current user from Hive userId |
| `createUserProvider` | StateNotifierProvider | Onboarding user creation |
| `usersByTripProvider` | FutureProvider.family | Users in a trip |
| `tripsProvider` | StreamProvider | All trips (stream) |
| `activeTripsProvider` | FutureProvider | Non-archived trips |
| `tripByIdProvider` | FutureProvider.family | Single trip lookup |
| `createTripProvider` | StateNotifierProvider | Trip creation |
| `expensesByTripProvider` | StreamProvider.family | Expenses for a trip |
| `balancesByTripProvider` | FutureProvider.family | Net balances per user |
| `addExpenseProvider` | StateNotifierProvider | Add expense + system message |
| `settleUpProvider` | StateNotifierProvider | Record settlement + system message |
| `summaryDataProvider` | FutureProvider | Aggregated analytics data |
| `messagesByTripProvider` | StreamProvider.family | Chat messages for a trip |
| `sendMessageProvider` | StateNotifierProvider | Send text/image/system messages |
| `deleteMessageProvider` | StateNotifierProvider | Soft-delete messages |
| `chatP2PListenerProvider` | Provider.family | P2P incoming message listener |
| `p2pServiceProvider` | Provider | P2P networking service |
| `syncEngineProvider` | Provider | Delta sync engine |
| `p2pControllerProvider` | StateNotifierProvider | P2P scan/connect/sync actions |

## Database Schema

11 tables in Drift: `Users`, `Trips`, `TripMembers`, `Expenses`, `ExpenseSplits`, `Settlements`, `Messages`, `BudgetPools`, `BudgetContributions`, `SyncQueue`, `PeerSyncState`.

All entity tables have `hlcTimestamp` (String) and `isDeleted` (bool, default false) for sync.

Key column notes:
- Messages: `messageType` (not `type`), `sentAt` (not `createdAt`), `content` is nullable
- Expenses: has `expenseDate`, `createdAt`, `updatedAt`
- Settlements: `settledAt`, `notes` is nullable

## P2P Architecture

- **Discovery**: UDP broadcast on port 41234
- **Transport**: TCP sockets with 4-byte length-prefix framing
- **Protocol**: 9 message types (discovery, handshake, handshakeAck, syncRequest, syncResponse, chatMessage, ack, heartbeat, disconnect)
- **Sync**: Delta sync using HLC timestamps, last-write-wins conflict resolution
- **Sync tables**: users, trips, trip_members, expenses, expense_splits, settlements, messages

## UI Patterns

- **Glass cards**: Use `GlassCard` or `GlassTheme.glass(brightness:)` for glassmorphism containers
- **Animations**: Use `flutter_animate` with `AppAnimations` constants. Stagger with `AppAnimations.staggerFor(index)`
- **Empty states**: Use `EmptyState` widget with icon, title, subtitle, optional action
- **Error states**: Use `ErrorState` widget with message and optional retry callback
- **Avatars**: Use `AvatarCircle` with name-based color and initials
- **Colors**: `AppColors` has semantic colors (success/warning/error/info) and category colors
- **App bar style**: `SliverAppBar.large` with backdrop blur, transparent background

## Screen Navigation

```
/onboarding  → OnboardingScreen (first run only)
/            → HomeScreen (trip list)
/trip/:id    → TripDetailScreen (tabs: Expenses, Balances, Chat, Members)
/nearby      → NearbyScreen (P2P radar + peer list)
/summary     → SummaryScreen (spending analytics)
/settings    → SettingsScreen (theme, currency, profile)
```

## Implementation Status

- Phase 1 (Expense Management UI): Complete
- Phase 2 (P2P Foundation): Complete
- Phase 3 (Group Chat): Complete
- Phase 4 (Polish & Store Launch): Complete

## Common Pitfalls

- After editing DAO files, you may need to re-run `build_runner` if you changed `@DriftAccessor` annotations or table references. Adding methods that use existing table accessors does NOT require code gen.
- Drift companions use `Value()` wrapper for all fields.
- `insertOnConflictUpdate` is the preferred upsert pattern for sync.
- The `expenses` table's `splitType` column stores the enum name as a String.
- P2P service uses `dart:io` sockets directly — works on real devices and simulators on same network.
