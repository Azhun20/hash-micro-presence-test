part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    // True once the initial session check has finished. Until then the router
    // shows a splash instead of guessing (prevents a login/home redirect loop).
    @Default(false) bool isInitialized,
    @Default(false) bool isAuthenticated,
    UserEntity? user,
    String? errorMessage,
  }) = _AuthState;
}
