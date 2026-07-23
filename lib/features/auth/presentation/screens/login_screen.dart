import 'package:exercise_projects/core/config/app_config.dart';
import 'package:exercise_projects/core/models/enum/state_value.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:exercise_projects/core/widgets/flushbar.dart';
import 'package:exercise_projects/features/auth/bloc/auth_cubit.dart';
import 'package:exercise_projects/features/auth/bloc/auth_state.dart';
import 'package:exercise_projects/features/auth/presentation/widgets/auth_buttons.dart';
import 'package:exercise_projects/features/auth/presentation/widgets/auth_phone_field.dart';
import 'package:exercise_projects/features/auth/presentation/widgets/auth_screen_shell.dart';
import 'package:exercise_projects/features/auth/presentation/widgets/auth_underline_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().resetStatus();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthCubit>().login(
          userName: _userNameController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) async {
        if (state.status == StateValue.loaded) {
          await context.read<AppConfig>().setIsLogIn(true, asAdmin: false);
          isLoggedIn = true;
          if (!context.mounted) return;
          await showSimpleFlushBar(
            context,
            'Welcome back',
            'You have logged in successfully',
            Icons.waving_hand,
            successColor,
          );
          if (!context.mounted) return;
          context.read<AuthCubit>().resetStatus();
        } else if (state.status == StateValue.fail && state.errorMessage.isNotEmpty) {
          showSimpleFlushBar(
            context,
            'Login failed',
            state.errorMessage,
            Icons.error_outline,
            errorColor,
          );
          context.read<AuthCubit>().resetStatus();
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
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'Enter your user name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 22.h),
                AuthPhoneField(
                  controller: _phoneController,
                  validator: (value) {
                    if ((value ?? '').trim().length < 8) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 22.h),
                AuthUnderlineField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: !state.isPasswordVisible,
                  suffix: IconButton(
                    onPressed: isLoading
                        ? null
                        : () => context.read<AuthCubit>().togglePasswordVisibility(),
                    icon: Icon(
                      state.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: appWhiteColor.withValues(alpha: 0.9),
                    ),
                  ),
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return 'Enter your password';
                    }
                    if (value!.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.h),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => Navigator.pushNamed(context, Routes.adminLogin),
                  child: Text(
                    'Admin login',
                    style: TextStyle(
                      color: darkGreenColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: mainFontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ),
          primaryButton: AuthPrimaryButton(
            label: 'Login',
            isLoading: isLoading,
            onPressed: isLoading ? null : _submit,
          ),
          secondaryButton: AuthOutlinedButton(
            label: 'Create Account',
            onPressed: isLoading
                ? null
                : () => Navigator.pushNamed(context, Routes.register),
          ),
        );
      },
    );
  }
}
