import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/enum/state_value.dart';
import 'admin_auth_state.dart';

/// تعليمي: أدمن ثابت — User: Ziad / Password: admin1234
class AdminAuthCubit extends Cubit<AdminAuthState> {
  AdminAuthCubit() : super(const AdminAuthState());

  static const _adminUser = 'ziad';
  static const _adminPassword = 'admin1234';

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void resetStatus() {
    emit(state.copyWith(status: StateValue.init, clearError: true));
  }

  Future<void> login({
    required String userName,
    required String password,
  }) async {
    emit(state.copyWith(status: StateValue.loading, clearError: true));

    await Future.delayed(const Duration(seconds: 1));

    final name = userName.trim().toLowerCase();
    if (name != _adminUser) {
      emit(state.copyWith(
        status: StateValue.fail,
        errorMessage: 'Invalid admin user name',
      ));
      return;
    }
    if (password.trim() != _adminPassword) {
      emit(state.copyWith(
        status: StateValue.fail,
        errorMessage: 'Invalid admin password',
      ));
      return;
    }

    emit(state.copyWith(status: StateValue.loaded, clearError: true));
  }
}
