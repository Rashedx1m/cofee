import '../../../core/models/enum/state_value.dart';

class AuthState {
  final StateValue status;
  final String errorMessage;
  final bool isPasswordVisible;

  const AuthState({
    this.status = StateValue.init,
    this.errorMessage = '',
    this.isPasswordVisible = false,
  });

  AuthState copyWith({
    StateValue? status,
    String? errorMessage,
    bool? isPasswordVisible,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: clearError ? '' : (errorMessage ?? this.errorMessage),
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
