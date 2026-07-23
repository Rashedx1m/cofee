import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_config.dart';
import '../../../core/models/enum/state_value.dart';
import 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void resetStatus() {
    emit(state.copyWith(status: StateValue.init, clearError: true));
  }

  Future<void> login({
    required String userName,
    required String phone,
    required String password,
  }) async {

    emit(state.copyWith(status: StateValue.loading, clearError: true));

    try {
      await Future.delayed(const Duration(seconds: 1));

      final trimmedName = userName.trim();
      final trimmedPhone = phone.trim();

      if (trimmedName.isEmpty) {
        emit(
          state.copyWith(
            status: StateValue.fail,
            errorMessage: 'Please enter your user name',
          ),
        );

        return;
      }
      if (trimmedPhone.length < 8) {
        emit(
          state.copyWith(
            status: StateValue.fail,
            errorMessage: 'Please enter a valid phone number',
          ),
        );
        return;
      }
      if (password.length < 8) {
        emit(
          state.copyWith(
            status: StateValue.fail,
            errorMessage: 'Password must be at least 8 characters',
          ),
        );
        return;
      }

      emit(state.copyWith(status: StateValue.loaded, clearError: true));
    } catch (_) {
      emit(
        state.copyWith(
          status: StateValue.fail,
          errorMessage: 'Login failed. Please try again.',
        ),
      );
    }
  }

  Future<void> register({
    required String userName,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(status: StateValue.loading, clearError: true));

    try {
      await Future.delayed(const Duration(seconds: 2));

      final trimmedName = userName.trim();
      final trimmedPhone = phone.trim();

      if (trimmedName.isEmpty) {
        emit(
          state.copyWith(
            status: StateValue.fail,
            errorMessage: 'Please enter your user name',
          ),
        );
        return;
      }
      if (trimmedPhone.length < 8) {
        emit(
          state.copyWith(
            status: StateValue.fail,
            errorMessage: 'Please enter a valid phone number',
          ),
        );
        return;
      }
      if (password.length < 8) {
        emit(
          state.copyWith(
            status: StateValue.fail,
            errorMessage: 'Password must be at least 8 characters',
          ),
        );
        return;
      }
      if (password != confirmPassword) {
        emit(
          state.copyWith(
            status: StateValue.fail,
            errorMessage: 'Passwords do not match',
          ),
        );
        return;
      }

      emit(state.copyWith(status: StateValue.loaded, clearError: true));
    } catch (_) {
      emit(
        state.copyWith(
          status: StateValue.fail,
          errorMessage: 'Registration failed. Please try again.',
        ),
      );
    }
  }
}
