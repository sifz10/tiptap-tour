# Tiptap Tour

Offline-first group trip expense manager for iOS and Android. The app already supports trip management, partial-member expense splitting, balances, settlements, local chat persistence, and P2P sync/chat foundations. The networking stack is now in a transition from Wi-Fi-only direct sockets to a transport-agnostic offline stack with BLE and future mesh relay.

## Build & Run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter run
```

Notes:
- `flutter pub get` currently succeeds, but pub.dev advisory decoding prints noisy `FormatException: advisoriesUpdated must be a String` output in this environment. Dependency resolution still completes.
- `flutter analyze` is clean except for a few info-level lints in `lib/infrastructure/p2p/p2p_message.dart`.

## Product Summary

Core user flows already implemented:
- Onboarding with persisted user profile.
- Trip creation and member management.
- Expense entry with equal / exact / percentage split modes.
- Partial participation per expense: users can be excluded from a single expense even if they belong to the trip overall.
- Balance calculation and settlement recording.
- In-trip chat persisted locally and synced over P2P.
- Summary analytics screen.
- Settings for theme and currency.

Important domain behavior:
- A trip may have 6 total members, but each expense can include any subset of them.
- This is already supported through `expense_splits` and the add-expense UI.
- Net balance is `total paid - total owed`, where `owed` only comes from expenses the member participated in.

## Architecture

The app follows Clean Architecture with 4 layers:
- `lib/presentation/` — screens, widgets, animations, theme.
- `lib/application/` — Riverpod providers and app-facing controllers.
- `lib/domain/` — entities, enums, repository interfaces.
- `lib/infrastructure/` — Drift database, DAOs, P2P transports, sync engine.

Key conventions:
- State management: Riverpod 2.x, mostly `Provider`, `FutureProvider`, `StreamProvider`, `StateNotifierProvider`.
- Persistence: Drift for relational data, Hive for lightweight settings and IDs.
- Entities: immutable domain models, UUID v4 IDs.
- Sync model: HLC timestamps plus soft deletes (`isDeleted`) for conflict-safe replication.
- Navigation: GoRouter.
- UI direction: Material 3 with glassmorphism, backdrop blur, expressive empty/error states.

## Current App Status

Product/UI work complete:
- Phase 1 Expense Management UI: complete.
- Phase 2 P2P Foundation: complete.
- Phase 3 Group Chat: complete.
- Phase 4 Polish & Store Launch: functionally complete.

Phase 4 polish that already landed:
- Summary screen is fully implemented with overview cards, category pie chart, and trip breakdown.
- Settings screen is fully implemented with profile, theme, currency, and about sections.
- `EmptyState` and `ErrorState` were redesigned into modern glass UI.
- Excessive top spacing on top-level screens was tightened.
- `app.dart` was changed to keep one stable GoRouter instance and fix the GlobalKey collision bug.

## Project Structure

```text
lib/
├── app.dart
├── main.dart
├── core/
│   ├── constants/
│   ├── router/
│   └── utils/
├── domain/
│   ├── entities/
│   ├── enums/
│   └── repositories/
├── application/
│   └── providers/
├── infrastructure/
│   ├── database/
│   │   ├── app_database.dart
│   │   ├── daos/
│   │   └── tables/
│   ├── p2p/
│   │   ├── ble/
│   │   ├── crypto/
│   │   ├── mesh/
│   │   ├── composite_transport.dart
│   │   ├── p2p_message.dart
│   │   ├── p2p_service.dart
│   │   ├── transport.dart
│   │   └── wifi_transport.dart
│   └── sync/
│       └── sync_engine.dart
└── presentation/
    ├── screens/
    ├── theme/
    └── widgets/
```

## Provider Map

High-value providers:
- `databaseProvider` — `AppDatabase` singleton.
- `themeProvider` — persisted theme mode.
- `currencyProvider` — persisted default currency.
- `currentUserProvider` — current user loaded from Hive `userId`.
- `tripsProvider` — stream of trips.
- `expensesByTripProvider` — stream of trip expenses.
- `balancesByTripProvider` — computed net balances.
- `messagesByTripProvider` — stream of trip messages.
- `summaryDataProvider` — analytics aggregate for Summary screen.
- `p2pServiceProvider` — currently returns `MeshCompositeTransport`.
- `syncEngineProvider` — sync engine built on the active transport.
- `p2pControllerProvider` — start/stop discovery, connect/disconnect, sync, toggle Wi-Fi/BLE.

Current P2P provider wiring:
- `p2pServiceProvider` now returns `MeshCompositeTransport`.
- `MeshCompositeTransport` owns `CompositeTransport` and wraps it with `MeshRouter`.
- `MeshCompositeTransport` then wraps the mesh layer with `EncryptedTransport`.
- `SyncEngine`, chat listeners, and P2P UI streams now go through mesh + encryption.
- Wi-Fi/BLE toggle state is persisted in Hive using `p2pWifiEnabled` and `p2pBleEnabled`.

## Database Schema

Drift tables:
- `Users`
- `Trips`
- `TripMembers`
- `Expenses`
- `ExpenseSplits`
- `Settlements`
- `Messages`
- `BudgetPools`
- `BudgetContributions`
- `SyncQueue`
- `PeerSyncState`

Key notes:
- Every syncable entity includes `hlcTimestamp` and `isDeleted`.
- `Messages` uses `messageType` and `sentAt`.
- `Expenses` uses `splitType` as the enum name string.
- `Settlements.notes` is nullable.
- Adding DAO methods on existing tables usually does not require code generation.

## Offline Networking Overview

The networking work is split into two tracks:
- Product-facing offline sync/chat that already exists.
- A transport modernization roadmap toward BLE-first, low-power, multi-hop communication.

### Transport Abstraction

`lib/infrastructure/p2p/transport.dart` defines the shared `P2PTransport` interface.

Implementations currently present:
- `WifiTransport` — direct sockets over LAN using UDP discovery + TCP messaging.
- `BleTransport` — BLE central/peripheral transport using `flutter_blue_plus` plus native GATT server plugins.
- `CompositeTransport` — merges Wi-Fi and BLE into one physical transport.
- `MeshRouter` — wraps any `P2PTransport` and adds relay/routing behavior.
- `EncryptedTransport` — wraps mesh and encrypts chat/sync payloads.
- `MeshCompositeTransport` — current app-facing transport combining CompositeTransport + MeshRouter + EncryptedTransport.

### Wi-Fi Transport

`WifiTransport` is the refactored version of the original P2P service.

Behavior:
- Discovery: UDP broadcast on port `41234`.
- Data channel: TCP sockets with 4-byte length-prefix framing.
- Heartbeat: periodic `heartbeat` messages.
- Direct peer connections only.

### BLE Transport

BLE work is implemented as the transport core, not yet fully production-hardened.

Files:
- `ble/ble_constants.dart`
- `ble/ble_chunker.dart`
- `ble/ble_gatt_server.dart`
- `ble/ble_transport.dart`

Native platform pieces:
- Android: custom Kotlin GATT server plugin.
- iOS: custom Swift/CoreBluetooth peripheral plugin.

BLE design:
- Discovery via BLE scanning for a dedicated service UUID.
- Peripheral advertising from native GATT server.
- Data transfer via GATT characteristics.
- Chunking and reassembly are required due to BLE MTU limits.
- Default duty cycle is designed for power savings.

Practical note:
- This code compiles and analyzes, but it still needs real-device validation across iOS and Android. BLE simulator coverage is not enough.

### Composite Transport

`CompositeTransport` is the current physical transport multiplexer.

What it does:
- Starts Wi-Fi and BLE in parallel when enabled.
- Merges discovery, connected peers, state, and incoming message streams.
- Tracks which peer is using which transport.
- Routes outgoing direct messages to the correct underlying transport.
- Supports runtime toggles for Wi-Fi and BLE from the Nearby screen.

Important note:
- The app does not expose `CompositeTransport` directly anymore.
- It is wrapped by `MeshCompositeTransport`, which adds route announcements and relay forwarding above the physical transports.

### P2P Protocol

`P2PMessage` has been extended beyond the original socket-only version.

Current protocol details:
- Messages carry `messageId` for deduplication.
- `targetId` supports directed delivery.
- `routeAnnounce` exists for route sharing.
- `MeshMetadata` can carry `originId`, `ttl`, and `hopPath`.
- Handshake factories already accept an optional `publicKey` field for future encryption work.

Current message types:
- `discovery`
- `handshake`
- `handshakeAck`
- `syncRequest`
- `syncResponse`
- `chatMessage`
- `ack`
- `heartbeat`
- `disconnect`
- `routeAnnounce`
- `keyAnnounce`

### Encryption Layer

Phase 6 encryption is implemented at code level in `lib/infrastructure/p2p/crypto/`:
- `key_store.dart` persists one X25519 identity key pair in Hive settings.
- `encrypted_transport.dart` exchanges public keys with `keyAnnounce` messages.
- Chat and sync payloads are encrypted with AES-256-GCM using X25519 shared secrets.
- Transport headers stay visible (`type`, `senderId`, `targetId`, `messageId`, mesh metadata) so relay nodes can forward without decrypting.
- Relay nodes should not be able to read encrypted chat/sync payloads.

Important limitations:
- There is not yet a user-facing trust/fingerprint verification UI.
- Key rotation and recovery are not implemented yet.
- E2E behavior has a unit test, but still needs multi-device real-world validation.

## Mesh Routing Status

Mesh groundwork exists in `lib/infrastructure/p2p/mesh/`:
- `mesh_router.dart`
- `routing_table.dart`
- `seen_message_cache.dart`

What is already implemented there:
- Route announcements.
- Multi-hop forwarding using `targetId`.
- TTL-based loop prevention.
- Seen-message deduplication.
- Route expiry and next-hop tracking.

Current live behavior:
- `MeshRouter` is active through `MeshCompositeTransport`.
- Direct peers are still sent over Wi-Fi/BLE through `CompositeTransport`.
- Routed peers learned from `routeAnnounce` are surfaced as mesh-reachable peers with `Mesh · N hops` platform labels.
- Relay forwarding uses only direct underlying peers as next hops.

What is **not** done yet:
- No store-and-forward queue for temporarily unreachable peers.
- No full real-device validation with 3+ devices.
- Route debugging UI is minimal; Nearby shows mesh-reachable peers but does not yet show full route tables.
- No fingerprint verification UI, key rotation, or encrypted backup/recovery yet.

## BLE / Mesh Roadmap

Transport modernization phases:
- Phase 1: transport abstraction refactor — complete.
- Phase 2: message protocol extensions for mesh metadata — complete.
- Phase 3: BLE transport core — complete at code level.
- Phase 4: composite Wi-Fi + BLE transport — complete.
- Phase 5: wire `MeshRouter` as the active transport — complete at code level.
- Phase 6: end-to-end encryption — complete at code level.
- Phase 7: energy tuning, background behavior, hardening, real-device validation — pending.

Recommended next implementation order:
1. Verify direct sync/chat still works on two physical devices through `MeshCompositeTransport`.
2. Test with at least 3 physical devices in a relay chain.
3. Add route visibility/debugging on Nearby screen if testing needs more observability.
4. Add fingerprint/trust UI for encryption identity verification.
5. Tune scan/advertise intervals for battery life.

## UI Patterns

Use these patterns consistently:
- `GlassCard` or `GlassTheme.glass(...)` for surface styling.
- `SliverAppBar.large` with blur, but avoid excessive top dead space.
- `EmptyState` for modern empty views, not plain text.
- `ErrorState` for user-facing failures with retry when possible.
- `flutter_animate` plus `AppAnimations` constants for entrance motion.
- `AvatarCircle` for user identity.

## Screen Notes

Top-level screens already polished:
- Home
- Nearby
- Summary
- Settings

Nearby screen specifics:
- It is the control surface for discovery and peer connections.
- It now includes Wi-Fi and Bluetooth toggle chips backed by `p2pControllerProvider`.

Summary screen specifics:
- Uses `summaryDataProvider`.
- Shows total spent, expense count, trip count, category chart, and trip breakdown.

Settings screen specifics:
- Uses theme and currency providers.
- Shows profile, theme selector, currency selector, and app/about card.

## Navigation

Routes:

```text
/onboarding
/
/trip/:id
/nearby
/summary
/settings
```

Important router note:
- `app.dart` must keep a single GoRouter instance in state.
- Recreating the router inside `build()` caused duplicate GlobalKey failures before and has already been fixed.

## Common Pitfalls

- After editing Drift annotations or table definitions, rerun build_runner.
- Drift companions require `Value(...)` wrappers.
- `insertOnConflictUpdate` is preferred for sync-safe upserts.
- Do not recreate GoRouter inside widget build methods.
- BLE code requires real devices for meaningful validation.
- BLE on iOS and Android differs in advertising behavior, connection timing, and background restrictions.
- Mesh and encryption are active in code, but still need real-device validation before calling them production-ready.

## What Another Agent Should Assume

If you are continuing this work:
- The app is already beyond the original CLAUDE description; trust the actual `infrastructure/p2p/` code over older notes.
- The live transport is `MeshCompositeTransport`, not the legacy single `P2PService` design.
- Mesh routing is integrated at code level but not yet real-device validated.
- Encryption is implemented at code level for chat/sync payloads, but trust UI and real-device validation are still pending.
- The most valuable next step is real-device mesh + encryption testing, then battery/background hardening.
