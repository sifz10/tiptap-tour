# Tip Tap Tour

Offline-first group trip expense manager for iOS and Android. The app name is **"Tip Tap Tour"** (three words, spaces between). The app already supports trip management, partial-member expense splitting, balances, settlements, local chat persistence, and P2P sync/chat foundations. The networking stack is now in a transition from Wi-Fi-only direct sockets to a transport-agnostic offline stack with BLE and future mesh relay.

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
- Add connected P2P peers to existing trips from the Nearby screen.
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
- App renamed from "Tiptap Tour" to "Tip Tap Tour" across all surfaces (AndroidManifest, Info.plist, app.dart, app_constants.dart, home_screen, settings_screen, onboarding).
- Onboarding screen redesigned with premium glassmorphism: gradient background, decorative orbs, logo image from `assets/logo/logo.png`, gradient title text, frosted-glass input card with backdrop blur, gradient button.
- Nearby radar redesigned with premium `_RadarPainter`: 4 concentric guide rings, diagonal cross-hairs, arc-segment sweep trail (30 segments), gradient sweep line with tip dot, 2 clean pulse rings, outer rim glow, multi-layer center dot with highlight.
- Logo asset path added to `pubspec.yaml` (`assets/logo/`).
- Fixed "Unknown" display name bug: `createUser()` now saves `displayName` to Hive alongside `userId`, so P2P transport reads the real name instead of the default 'Unknown'.
- Fixed "Bad state: Missing encryption key" error: `EncryptedTransport` now normalizes composite peer IDs (strips `@ip:port` suffix) before key lookups, so Wi-Fi peers with `userId@ip:port` format match the raw `userId` stored by `keyAnnounce`.
- Fixed BLE writeCharacteristic timeout: BLE writes now prefer `withoutResponse: true` when the characteristic supports it, with a 5-second per-write timeout and proper error wrapping instead of hanging for 15 seconds.
- Added "Add to Trip" flow: connected peers on the Nearby screen have a group-add icon button that opens a trip selection bottom sheet. Selecting a trip upserts the peer as a user and adds them as a trip member, with a snackbar offering "Go to Trip" navigation.
- Sync queue wiring: `CreateTripNotifier` and `AddPeerToTripNotifier` now record changes (trips, users, trip_members) to the sync queue via `SyncEngine.recordChange()`. Previously only chat messages were queued, so trips and members never synced.
- Auto-sync on add: `AddPeerToTripNotifier` triggers `syncWithPeer()` after adding a peer to a trip, so the trip, members, and user data reach the peer's device immediately.
- Provider invalidation: the Nearby screen invalidates `usersByTripProvider` and `tripMembersProvider` after adding a peer, so the Members tab refreshes without requiring navigation away and back.
- Custom launcher icon: `flutter_launcher_icons` generates Android and iOS app icons from `assets/logo/logo.png`, replacing the default Flutter icon.

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
│   │   │   ├── ble_chunker.dart
│   │   │   ├── ble_constants.dart
│   │   │   ├── ble_gatt_server.dart
│   │   │   └── ble_transport.dart
│   │   ├── crypto/
│   │   │   ├── encrypted_transport.dart
│   │   │   └── key_store.dart
│   │   ├── mesh/
│   │   │   ├── mesh_router.dart
│   │   │   ├── routing_table.dart
│   │   │   └── seen_message_cache.dart
│   │   ├── composite_transport.dart
│   │   ├── mesh_composite_transport.dart
│   │   ├── p2p_diagnostics.dart
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
- `p2pDiagnosticsProvider` — aggregated diagnostics (direct/mesh/encrypted peer counts, route info).
- `addPeerToTripProvider` — upserts a connected P2P peer as a user, adds them as a trip member, records all changes to the sync queue, and auto-syncs with the peer.
- `createTripProvider` — creates a trip with the creator as admin, records trip and membership to the sync queue.

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
- `UserDao.upsertUser()` uses `insertOnConflictUpdate` for sync-safe peer user creation.
- `TripDao.addMember()` uses `insertOnConflictUpdate` to avoid duplicate key errors when re-adding existing members.

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
- `P2PDiagnostics` — reports direct/mesh peers, hop count, next hop, transport label, and encryption readiness for testing.
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
- Android: custom Kotlin GATT server plugin (`android/app/src/main/kotlin/com/ryven/tiptap_tour/BleGattServerPlugin.kt`).
- iOS: custom Swift/CoreBluetooth peripheral plugin (`ios/Runner/BleGattServerPlugin.swift`).

BLE design:
- Discovery via BLE scanning for a dedicated service UUID (`a1b2c3d4-e5f6-7890-abcd-ef1234567890`).
- Peripheral advertising from native GATT server.
- Three GATT characteristics: message write (`...567891`), message notify (`...567892`), device info (`...567893`).
- Chunking and reassembly via `BleChunker` with 5-byte headers (CRC-16 hash, sequence, total, length).
- MTU negotiation: default 20 bytes, preferred 512 bytes.
- Default duty cycle: scan 10s on / 20s pause, `lowPower` scan mode, `ADVERTISE_MODE_LOW_POWER`.

BLE write resilience:
- Chunked writes prefer `withoutResponse: true` when the characteristic supports it, avoiding ACK-based timeouts.
- Each write has a 5-second timeout; failures throw a wrapped `Exception` instead of hanging.
- Connection failures reset state to `disconnected` (or `connected` if other peers are still active) instead of permanently locking to `error`.

Practical note:
- This code compiles and analyzes, but it still needs real-device validation across iOS and Android. BLE simulator coverage is not enough.
- BLE discovered peers show "BLE Device" before connection because BLE scanning cannot read the app-level display name. The real name is exchanged during the handshake after connection.

### Composite Transport

`CompositeTransport` is the current physical transport multiplexer.

What it does:
- Starts Wi-Fi and BLE in parallel when enabled.
- Merges discovery, connected peers, state, and incoming message streams.
- Tracks which peer is using which transport via `_peerTransport` map.
- Routes outgoing direct messages to the correct underlying transport.
- Supports runtime toggles for Wi-Fi and BLE from the Nearby screen.
- Deduplication: if the same peer appears on both transports, Wi-Fi takes priority (higher throughput).
- State resolution priority: syncing > connected > connecting > discovering > error > disconnected.

Important note:
- The app does not expose `CompositeTransport` directly anymore.
- It is wrapped by `MeshCompositeTransport`, which adds route announcements and relay forwarding above the physical transports.

### MeshCompositeTransport

`MeshCompositeTransport` is the app-facing transport that wires all layers together.

Construction chain:
```
MeshCompositeTransport
  └→ EncryptedTransport (encrypts chat/sync payloads)
       └→ MeshRouter (adds multi-hop relay + route announcements)
            └→ CompositeTransport (merges Wi-Fi + BLE)
                 ├→ WifiTransport (UDP discovery + TCP sockets)
                 └→ BleTransport (BLE GATT client + native server)
```

What it adds beyond the layers:
- `diagnostics` getter aggregating peer info from MeshRouter, transport type from CompositeTransport, and encryption readiness from EncryptedTransport.
- Delegates `setWifiEnabled()`/`setBleEnabled()` to CompositeTransport.

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
- Only `syncRequest`, `syncResponse`, and `chatMessage` types are encrypted. All other types (discovery, handshake, heartbeat, routeAnnounce, keyAnnounce, etc.) pass through unencrypted.
- On peer connection, `keyAnnounce` is broadcast automatically. Shared secrets are cached per peer.
- If a peer's key is unknown when sending, the transport re-announces its own key and throws `StateError`.
- `EncryptedTransport` normalizes peer IDs via `_normalizeId()` which strips `@ip:port` suffixes from Wi-Fi composite IDs. This ensures key lookups match the raw `userId` stored by `keyAnnounce` messages.

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
- Route announcements broadcast every 15 seconds with reachable peer map.
- Multi-hop forwarding using `targetId` and routing table next-hop lookup.
- TTL-based loop prevention (default TTL = 5 hops).
- Seen-message deduplication (max 1000 entries, 5-minute expiry).
- Route expiry (60 seconds per routing entry, Bellman-Ford style shortest path).
- Flood fallback for unknown destinations (excluding already-visited nodes).
- `_routedPeers` map tracks mesh-reachable peers learned from `routeAnnounce`.
- `peerDiagnostics` getter returns `P2PPeerDiagnostic` list with isDirect, hopCount, nextHopId, transportLabel, encryptionReady for each peer.

Current live behavior:
- `MeshRouter` is active through `MeshCompositeTransport`.
- Direct peers are still sent over Wi-Fi/BLE through `CompositeTransport`.
- Routed peers learned from `routeAnnounce` are surfaced as mesh-reachable peers with `Mesh · N hops` platform labels.
- Relay forwarding uses only direct underlying peers as next hops.

What is **not** done yet:
- No store-and-forward queue for temporarily unreachable peers.
- No full real-device validation with 3+ devices.
- Route debugging UI is available as a compact Nearby Network Status panel, but not as a full route-table inspector.
- No fingerprint verification UI, key rotation, or encrypted backup/recovery yet.

## BLE / Mesh Roadmap

Transport modernization phases:
- Phase 1: transport abstraction refactor — complete.
- Phase 2: message protocol extensions for mesh metadata — complete.
- Phase 3: BLE transport core — complete at code level.
- Phase 4: composite Wi-Fi + BLE transport — complete.
- Phase 5: wire `MeshRouter` as the active transport — complete at code level.
- Phase 6: end-to-end encryption — complete at code level.
- Phase 7: diagnostics/observability started; energy tuning, background behavior, hardening, real-device validation — pending.

Recommended next implementation order:
1. Verify direct sync/chat still works on two physical devices through `MeshCompositeTransport`.
2. Test with at least 3 physical devices in a relay chain.
3. Use the Nearby Network Status panel during field tests to observe direct peers, mesh peers, encryption readiness, hop count, and next hop.
4. Add fingerprint/trust UI for encryption identity verification.
5. Tune scan/advertise intervals for battery life.

## Assets

```text
assets/
├── images/
├── icons/
├── animations/
└── logo/
    └── logo.png          # Mountain scene with "Tip Tap Tour" text overlay. Used on onboarding screen.
```

All asset folders are registered in `pubspec.yaml` under `flutter: assets:`.

The logo is also used as the launcher icon for both platforms via `flutter_launcher_icons` (configured in `pubspec.yaml`). Run `dart run flutter_launcher_icons` to regenerate icons after changing the logo.

## UI Patterns

Use these patterns consistently:
- `GlassCard` or `GlassTheme.glass(...)` for surface styling.
- `SliverAppBar.large` with blur, but avoid excessive top dead space.
- `EmptyState` for modern empty views, not plain text.
- `ErrorState` for user-facing failures with retry when possible.
- `flutter_animate` plus `AppAnimations` constants for entrance motion.
- `AvatarCircle` for user identity.
- For premium screens, use `BackdropFilter` + `ImageFilter.blur` for frosted glass, gradient backgrounds with decorative orbs, and gradient text via `Paint()..shader`.
- The onboarding screen is the visual identity — keep it premium with the logo, gradient text, and glass card.

## Screen Notes

Top-level screens already polished:
- Home
- Nearby
- Summary
- Settings

Nearby screen specifics:
- It is the control surface for discovery, peer connections, and adding peers to trips.
- Connected peers show three action buttons: Add to Trip (group_add icon), Sync, and Disconnect.
- "Add to Trip" opens a bottom sheet listing all trips; tapping a trip upserts the peer as a user, adds them as a member, records all data to the sync queue, and auto-syncs so the trip appears on the peer's device. A snackbar with "Go to Trip" navigates to the trip detail (where Chat tab is available). After adding, `usersByTripProvider` and `tripMembersProvider` are invalidated so the Members tab shows the new member immediately.
- It now includes Wi-Fi and Bluetooth toggle chips backed by `p2pControllerProvider`.
- It includes a Network Status panel for Phase 7 field testing: direct peers, mesh peers, encrypted peers, route hop count, next hop, and transport state.
- Radar uses a custom `_RadarPainter` with arc-segment sweep trail, gradient sweep line, pulse rings, and multi-layer center dot. The painter takes `progress`, `isActive`, `pulseValue`, `color`, and `brightness`.

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
- Android BLE requires runtime permission requests (BLUETOOTH_SCAN, BLUETOOTH_CONNECT, BLUETOOTH_ADVERTISE) before any BLE operation. These are requested automatically in `P2PController.startDiscovery()` via `permission_handler`.
- `CompositeTransport.startDiscovery()` wraps each transport start in try/catch so one failing transport doesn't block the other.
- The `INTERNET` permission must be in the main `AndroidManifest.xml`, not just the debug manifest, for TCP/UDP sockets to work on real devices.
- Wi-Fi transport creates composite peer IDs in `userId@ip:port` format. Any layer that stores or looks up data by peer ID must normalize to raw `userId` first (see `EncryptedTransport._normalizeId()`).
- Hive settings must store `displayName` during onboarding, not just `userId`. The P2P provider reads it with a default of 'Unknown'.
- BLE characteristic writes should prefer `withoutResponse: true` when supported. Using `withoutResponse: false` requires an ACK from the peripheral and can timeout on real devices.
- Any provider that creates or modifies syncable data (trips, users, trip_members, expenses, settlements, messages) must call `SyncEngine.recordChange()` to add the change to the sync queue. Without this, the data stays local and never syncs to peers. Currently chat messages, trips, users, and trip members are wired; expenses and settlements still need sync queue wiring.
- After modifying data that other providers depend on, invalidate the relevant `FutureProvider.family` instances (e.g. `ref.invalidate(usersByTripProvider(tripId))`) so the UI refreshes.

## App Name and Branding

- App name is **"Tip Tap Tour"** everywhere: AndroidManifest `android:label`, iOS `CFBundleDisplayName` and `CFBundleName`, `AppConstants.appName`, MaterialApp `title`, onboarding screen, home screen header, settings about section.
- iOS Bluetooth permission strings also reference "Tip Tap Tour".
- The logo at `assets/logo/logo.png` is a mountain scene with blue sky and the app name overlaid. It is used prominently on the onboarding screen.

## What Another Agent Should Assume

If you are continuing this work:
- The app is already beyond the original CLAUDE description; trust the actual `infrastructure/p2p/` code over older notes.
- The live transport is `MeshCompositeTransport`, not the legacy single `P2PService` design.
- Mesh routing is integrated at code level but not yet real-device validated.
- Encryption is implemented at code level for chat/sync payloads, but trust UI and real-device validation are still pending.
- The app name is "Tip Tap Tour" (not "Tiptap Tour") — this was changed across all surfaces.
- The onboarding and radar UI have been polished to premium quality — do not regress them to simpler designs.
- Connected peers can now be added to trips from the Nearby screen — this creates the peer as a user in the database, adds them as a trip member, records everything to the sync queue, and auto-syncs so the trip appears on the peer's device.
- `displayName` is persisted to Hive during onboarding; P2P transport reads it from there. Users who onboarded before this fix may need to re-onboard or have a migration applied.
- BLE writes use `withoutResponse: true` when possible; the old `withoutResponse: false` caused 15-second timeouts on real devices.
- Sync queue wiring is partially done: chat messages, trips, users, and trip members record to sync queue. Expenses and settlements still need sync queue wiring added to their providers.
- The app launcher icon uses the logo from `assets/logo/logo.png` on both Android and iOS, generated via `flutter_launcher_icons`.
- The most valuable next step is real-device mesh + encryption testing, then battery/background hardening, then wiring sync queue for expenses and settlements.
