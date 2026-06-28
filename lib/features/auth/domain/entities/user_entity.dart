import 'package:equatable/equatable.dart';

/// Access role that determines which features a user can use.
enum UserRole {
  admin,
  user;

  static UserRole fromValue(String? value) {
    return UserRole.values.firstWhere(
      (role) => role.name == value,
      orElse: () => UserRole.user,
    );
  }
}

class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.role = UserRole.user,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? avatar;
  final UserRole role;

  bool get isAdmin => role == UserRole.admin;

  @override
  List<Object?> get props => [id, name, email, avatar, role];
}
