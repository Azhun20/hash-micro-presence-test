import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_micro_presence_test/app/router/app_router.dart';
import 'package:hash_micro_presence_test/configs/themes/theme.dart';
import 'package:hash_micro_presence_test/core/di/service_locator.dart';
import 'package:hash_micro_presence_test/features/auth/presentation/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup dependency injection
  await setupServiceLocator();

  // Check auth status
  await sl<AuthCubit>().checkAuthStatus();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<AuthCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Hash Micro Presence Test',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
