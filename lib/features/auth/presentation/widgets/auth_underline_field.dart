import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AuthUnderlineField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String?)? validator;

  const AuthUnderlineField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: appWhiteColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            fontFamily: mainFontFamily,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          style: TextStyle(
            color: appWhiteColor,
            fontSize: 16.sp,
            fontFamily: mainFontFamily,
          ),
          decoration: InputDecoration(
            isDense: true,
            suffixIcon: suffix,
            border: InputBorder.none,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: appWhiteColor.withValues(alpha: 0.85)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: appWhiteColor, width: 1.5),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: errorColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: errorColor, width: 1.5),
            ),
            errorStyle: TextStyle(color: errorColor, fontSize: 11.sp),
          ),
        ),
      ],
    );
  }
}
