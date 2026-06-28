import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_micro_presence_test/core/extensions/context_extensions.dart';
import 'package:hash_micro_presence_test/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hash_micro_presence_test/shared/styles/app_font_style.dart';
import 'package:hash_micro_presence_test/utils/extensions/theme_context_extension.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.unfocus();
      context.read<AuthCubit>().login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // Navigation on success is handled by the router's role-based guard.
          if (state.errorMessage != null) {
            context.showErrorSnackBar(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: context.primary500,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: context.primary500.withValues(alpha: 0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Selamat Datang',
                      style: AppFontStyle.display1Bold.copyWith(
                        color: context.neutral900,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Masuk untuk mengelola lokasi & absensi',
                      style: AppFontStyle.body2Regular.copyWith(
                        color: context.neutral300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'nama@perusahaan.com',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan email Anda';
                        }
                        if (!value.contains('@')) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Kata Sandi',
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan kata sandi Anda';
                        }
                        if (value.length < 6) {
                          return 'Kata sandi minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: state.isLoading ? null : _handleLogin,
                      child: state.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Masuk'),
                    ),
                    const SizedBox(height: 24),
                    _DemoCredentialsHint(
                      onPick: (email, password) {
                        _emailController.text = email;
                        _passwordController.text = password;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Tappable demo accounts so the local credentials are discoverable.
class _DemoCredentialsHint extends StatelessWidget {
  const _DemoCredentialsHint({required this.onPick});

  final void Function(String email, String password) onPick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.info50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.info100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, size: 16, color: context.info700),
              const SizedBox(width: 6),
              Text(
                'Akun demo · ketuk untuk mengisi',
                style: AppFontStyle.caption2SemiBold.copyWith(
                  color: context.info700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _CredentialRow(
            label: 'Admin',
            email: 'admin@app.com',
            password: 'admin123',
            onPick: onPick,
          ),
          const SizedBox(height: 6),
          _CredentialRow(
            label: 'User',
            email: 'user@app.com',
            password: 'user123',
            onPick: onPick,
          ),
        ],
      ),
    );
  }
}

class _CredentialRow extends StatelessWidget {
  const _CredentialRow({
    required this.label,
    required this.email,
    required this.password,
    required this.onPick,
  });

  final String label;
  final String email;
  final String password;
  final void Function(String email, String password) onPick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPick(email, password),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: context.neutral0,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.info100),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: context.primary50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                label,
                style: AppFontStyle.caption2SemiBold.copyWith(
                  color: context.primary600,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$email · $password',
                style: AppFontStyle.body2Regular.copyWith(
                  color: context.neutral400,
                ),
              ),
            ),
            Icon(Icons.touch_app_outlined, size: 16, color: context.neutral200),
          ],
        ),
      ),
    );
  }
}
