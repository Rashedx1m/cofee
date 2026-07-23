import '../../../core/models/enum/state_value.dart';

class AdminAuthState {
  final StateValue status;
  final String errorMessage;
  final bool isPasswordVisible;

  const AdminAuthState({
    this.status = StateValue.init,
    this.errorMessage = '',
    this.isPasswordVisible = false,
  });

  AdminAuthState copyWith({
    StateValue? status,
    String? errorMessage,
    bool? isPasswordVisible,
    bool clearError = false,
  }) {
    return AdminAuthState(
      status: status ?? this.status,
      errorMessage: clearError ? '' : (errorMessage ?? this.errorMessage),
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
