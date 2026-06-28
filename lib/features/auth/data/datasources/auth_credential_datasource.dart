import 'package:hash_micro_presence_test/core/error/failure.dart';

/// Local, hardcoded credential store used in place of a backend.
///
/// Demo accounts:
///   admin@app.com / admin123  -> role: admin (manages locations)
///   user@app.com  / user123   -> role: user  (attendance)
abstract class AuthCredentialDataSource {
  /// Returns the matching user map on success, throws [AuthFailure] otherwise.
  Map<String, dynamic> authenticate(String email, String password);
}

class AuthCredentialDataSourceImpl implements AuthCredentialDataSource {
  static const List<_Account> _accounts = [
    _Account(
      id: 'admin-001',
      name: 'Admin',
      email: 'admin@app.com',
      password: 'admin123',
      role: 'admin',
    ),
    _Account(
      id: 'user-001',
      name: 'User',
      email: 'user@app.com',
      password: 'user123',
      role: 'user',
    ),
  ];

  @override
  Map<String, dynamic> authenticate(String email, String password) {
    final normalizedEmail = email.trim().toLowerCase();

    for (final account in _accounts) {
      if (account.email == normalizedEmail && account.password == password) {
        return account.toUserJson();
      }
    }

    throw const AuthFailure(message: 'Email atau kata sandi salah.');
  }
}

class _Account {
  const _Account({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  final String id;
  final String name;
  final String email;
  final String password;
  final String role;

  Map<String, dynamic> toUserJson() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role,
  };
}
