import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hash_micro_presence_test/configs/routes/route.dart';
import 'package:hash_micro_presence_test/core/di/service_locator.dart';
import 'package:hash_micro_presence_test/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hash_micro_presence_test/features/auth/presentation/views/login_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.login,
    routes: [
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
    ],
  );
}
