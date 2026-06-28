import 'package:flutter/material.dart';

/// Shown while the initial session check runs. The router's guard moves the
/// user to login or their role home once auth is resolved.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
