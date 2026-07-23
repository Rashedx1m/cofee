import 'package:country_flags/country_flags.dart';
import 'package:exercise_projects/core/config/app_config.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:exercise_projects/core/widgets/flushbar.dart';
import 'package:exercise_projects/core/widgets/profile_avatar.dart';
import 'package:exercise_projects/features/auth/presentation/widgets/auth_underline_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Zedo Eybo');
  final _phoneController = TextEditingController(text: '996 567 879');
  final _passwordController = TextEditingController(text: '12345678');

  bool _hidePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await showSimpleFlushBar(
      context,
      'Saved',
      'Your changes were saved',
      Icons.check,
      successColor,
    );
  }

  Future<void> _logOut() async {
    await context.read<AppConfig>().setIsLogIn(false);
    isLoggedIn = false;
    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              _buildHeader(),
              SizedBox(height: 24.h),
              _buildAvatar(),
              SizedBox(height: 24.h),
              _buildFormCard(),
              SizedBox(height: 20.h),
              _buildSaveButton(),
              SizedBox(height: 14.h),
              _buildLogOutButton(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: secondaryColor,
            size: 20.sp,
          ),
        ),
        Expanded(
          child: Text(
            _nameController.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: appWhiteColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              fontFamily: mainFontFamily,
            ),
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }

  Widget _buildAvatar() {
    return ProfileAvatar(
      radius: 60.r,
      borderRadius: 16.r,
    );
  }

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: authSagePanelColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthUnderlineField(
              label: 'User Name',
              controller: _nameController,
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? 'Enter user name' : null,
            ),
            SizedBox(height: 20.h),
            _buildPhoneField(),
            SizedBox(height: 20.h),
            AuthUnderlineField(
              label: 'Password',
              controller: _passwordController,
              obscureText: _hidePassword,
              suffix: IconButton(
                onPressed: () => setState(() => _hidePassword = !_hidePassword),
                icon: Icon(
                  _hidePassword ? Icons.visibility_off : Icons.visibility,
                  color: appWhiteColor.withValues(alpha: 0.9),
                ),
              ),
              validator: (v) =>
                  (v ?? '').length < 8 ? 'Min 8 characters' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone',
          style: TextStyle(
            color: appWhiteColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            fontFamily: mainFontFamily,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            SizedBox(
              height: 20.h,
              width: 28.w,
              child: CountryFlag.fromCountryCode(
                'LB',
                theme: const ImageTheme(),
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              '+963',
              style: TextStyle(
                color: appWhiteColor,
                fontSize: 16.sp,
                fontFamily: mainFontFamily,
              ),
            ),
            Container(
              height: 22.h,
              width: 1,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              color: appWhiteColor.withValues(alpha: 0.7),
            ),
            Expanded(
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: appWhiteColor, fontSize: 16.sp),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: appWhiteColor.withValues(alpha: 0.85),
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: appWhiteColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: _save,
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: appWhiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: mainFontFamily,
          ),
        ),
      ),
    );
  }

  Widget _buildLogOutButton() {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: _logOut,
        style: ElevatedButton.styleFrom(
          backgroundColor: errorColor,
          foregroundColor: appWhiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          'Log Out',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: mainFontFamily,
          ),
        ),
      ),
    );
  }
}
