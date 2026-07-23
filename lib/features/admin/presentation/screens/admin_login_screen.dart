import 'package:exercise_projects/core/config/app_config.dart';
import 'package:exercise_projects/core/models/enum/state_value.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:exercise_projects/core/widgets/flushbar.dart';
import 'package:exercise_projects/features/admin/bloc/admin_auth_cubit.dart';
import 'package:exercise_projects/features/admin/bloc/admin_auth_state.dart';
import 'package:exercise_projects/features/auth/presentation/widgets/auth_buttons.dart';
import 'package:exercise_projects/features/auth/presentation/widgets/auth_screen_shell.dart';
import 'package:exercise_projects/features/auth/presentation/widgets/auth_underline_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AdminAuthCubit>().resetStatus();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AdminAuthCubit>().login(
          userName: _userNameController.text,
          password: _passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminAuthCubit, AdminAuthState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) async {
        if (state.status == StateValue.loaded) {
          final config = context.read<AppConfig>();
          await config.setIsLogIn(true, asAdmin: true);
          isLoggedIn = true;
          if (!context.mounted) return;
          context.read<AdminAuthCubit>().resetStatus();
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.adminUsers,
            (_) => false,
          );
        } else if (state.status == StateValue.fail && state.errorMessage.isNotEmpty) {
          showSimpleFlushBar(
            context,
            'Admin login failed',
            state.errorMessage,
            Icons.error_outline,
            errorColor,
          );
          context.read<AdminAuthCubit>().resetStatus();
        }
      },
      builder: (context, state) {
        final isLoading = state.status == StateValue.loading;
        return AuthScreenShell(
          title: '',
          form: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthUnderlineField(
                  label: 'User Name',
                  controller: _userNameController,
                  validator: (v) =>
                      (v ?? '').trim().isEmpty ? 'Enter user name' : null,
                ),
                SizedBox(height: 22.h),
                AuthUnderlineField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: !state.isPasswordVisible,
                  suffix: IconButton(
                    onPressed: isLoading
                        ? null
                        : () => context
                            .read<AdminAuthCubit>()
                            .togglePasswordVisibility(),
                    icon: Icon(
                      state.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: appWhiteColor.withValues(alpha: 0.9),
                    ),
                  ),
                  validator: (v) {
                    final p = (v ?? '').trim();
                    if (p.isEmpty) return 'Enter password';
                    if (p.length < 8) return 'Min 8 characters';
                    return null;
                  },
                ),
              ],
            ),
          ),
          primaryButton: AuthPrimaryButton(
            label: 'login',
            isLoading: isLoading,
            onPressed: isLoading ? null : _submit,
          ),
          secondaryButton: AuthOutlinedButton(
            label: 'User Login',
            onPressed: isLoading
                ? null
                : () => Navigator.pushReplacementNamed(context, Routes.login),
          ),
        );
      },
    );
  }
}
