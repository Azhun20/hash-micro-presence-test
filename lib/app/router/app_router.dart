import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hash_micro_presence_test/configs/routes/route.dart';
import 'package:hash_micro_presence_test/core/di/service_locator.dart';
import 'package:hash_micro_presence_test/features/attendance/presentation/views/attendance_placeholder_page.dart';
import 'package:hash_micro_presence_test/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hash_micro_presence_test/features/auth/presentation/views/login_page.dart';
import 'package:hash_micro_presence_test/features/auth/presentation/views/splash_page.dart';
import 'package:hash_micro_presence_test/features/location/presentation/cubit/location_form_cubit.dart';
import 'package:hash_micro_presence_test/features/location/presentation/cubit/location_list_cubit.dart';
import 'package:hash_micro_presence_test/features/location/presentation/views/location_form_page.dart';
import 'package:hash_micro_presence_test/features/location/presentation/views/location_list_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    redirect: _guard,
    // Re-run the guard whenever auth state changes (init / login / logout).
    refreshListenable: _AuthRefreshStream(sl<AuthCubit>()),
    routes: [
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        pageBuilder: (context, state) =>
            const MaterialPage(child: SplashPage()),
      ),
      GoRoute(
        path: Routes.login,
        name: Routes.login,
        pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider.value(
            value: sl<AuthCubit>(),
            child: const LoginPage(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.locations,
        name: Routes.locations,
        pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider(
            create: (_) => sl<LocationListCubit>()..loadLocations(),
            child: const LocationListPage(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.locationForm,
        name: Routes.locationForm,
        pageBuilder: (context, state) {
          final id = state.uri.queryParameters['id'];
          return MaterialPage(
            child: BlocProvider(
              create: (_) => sl<LocationFormCubit>()..init(id),
              child: const LocationFormPage(),
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.attendance,
        name: Routes.attendance,
        pageBuilder: (context, state) => MaterialPage(
          child: BlocProvider.value(
            value: sl<AuthCubit>(),
            child: const AttendancePlaceholderPage(),
          ),
        ),
      ),
    ],
  );

  /// The home route for the current role.
  static String _homeFor(bool isAdmin) =>
      isAdmin ? Routes.locations : Routes.attendance;

  /// Route guard. Designed to never redirect in a loop: every branch either
  /// returns `null` (stay) or sends to a route whose own guard result is `null`.
  ///
  /// 1. Until the session check finishes -> stay on the splash.
  /// 2. Not logged in -> only /login is allowed.
  /// 3. Logged in on splash/login -> go to the role home.
  /// 4. Non-admin on an admin-only page -> go to their home.
  static String? _guard(BuildContext context, GoRouterState state) {
    final authState = sl<AuthCubit>().state;
    final location = state.matchedLocation;

    // 1. Session not resolved yet -> wait on the splash, no guessing.
    if (!authState.isInitialized) {
      return location == Routes.splash ? null : Routes.splash;
    }

    final isLoggedIn = authState.isAuthenticated;
    final isAdmin = authState.user?.isAdmin ?? false;
    final isAuthRoute =
        location == Routes.login || location == Routes.splash;

    // 2. Not logged in -> force to login (login itself is allowed).
    if (!isLoggedIn) {
      return location == Routes.login ? null : Routes.login;
    }

    // 3. Logged in but sitting on splash/login -> go to the role home.
    if (isAuthRoute) {
      return _homeFor(isAdmin);
    }

    // 4. Admin-only area -> non-admins go to their own home.
    if (location.startsWith(Routes.locations) && !isAdmin) {
      return Routes.attendance;
    }

    return null;
  }
}

/// Bridges [AuthCubit]'s stream to a [Listenable] so GoRouter re-runs its
/// redirect guard on every auth state change.
class _AuthRefreshStream extends ChangeNotifier {
  _AuthRefreshStream(AuthCubit cubit) {
    _subscription = cubit.stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
