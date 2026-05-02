import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiptap_tour/core/router/route_names.dart';
import 'package:tiptap_tour/presentation/screens/home/home_screen.dart';
import 'package:tiptap_tour/presentation/screens/nearby/nearby_screen.dart';
import 'package:tiptap_tour/presentation/screens/summary/summary_screen.dart';
import 'package:tiptap_tour/presentation/screens/settings/settings_screen.dart';
import 'package:tiptap_tour/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:tiptap_tour/presentation/screens/trip/trip_detail_screen.dart';
import 'package:tiptap_tour/presentation/main_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter({required bool isFirstLaunch}) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: isFirstLaunch ? '/onboarding' : '/',
    routes: [
      GoRoute(
        path: '/onboarding',
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: RouteNames.home,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'trip/:tripId',
                name: RouteNames.tripDetail,
                builder: (context, state) => TripDetailScreen(
                  tripId: state.pathParameters['tripId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/nearby',
            name: RouteNames.nearby,
            builder: (context, state) => const NearbyScreen(),
          ),
          GoRoute(
            path: '/summary',
            name: RouteNames.summary,
            builder: (context, state) => const SummaryScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: RouteNames.settings,
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}
