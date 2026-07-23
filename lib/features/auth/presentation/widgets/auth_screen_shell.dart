import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';


class AuthScreenShell extends StatelessWidget {
  final String title;
  final Widget form;
  final Widget primaryButton;
  final Widget secondaryButton;

  const AuthScreenShell({
    super.key,
    required this.title,
    required this.form,
    required this.primaryButton,
    required this.secondaryButton,
  });


  static const String authLogoAsset = 'assets/images/loginfoto.png';
  static const double _logoSize = 88;
  static const double _logoOverlap = 44;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authCreamBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 24.h),
                    _buildFormCard(),
                    SizedBox(height: 24.h),
                    primaryButton,
                    SizedBox(height: 12.h),
                    secondaryButton,
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(top: _logoOverlap.h),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16.w, (_logoOverlap + 12).h, 16.w, 24.h),
            decoration: BoxDecoration(
              color: authSagePanelColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (title.isNotEmpty) ...[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: appWhiteColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: mainFontFamily,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
                form,
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: _buildLogo(),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      authLogoAsset,
      width: _logoSize.r,
      height: _logoSize.r,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}
