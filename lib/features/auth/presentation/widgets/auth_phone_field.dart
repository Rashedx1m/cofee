import 'package:country_flags/country_flags.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AuthPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AuthPhoneField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
                fontWeight: FontWeight.w500,
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
                controller: controller,
                keyboardType: TextInputType.phone,
                validator: validator,
                style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 16.sp,
                  fontFamily: mainFontFamily,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: '987 456 118',
                  hintStyle: TextStyle(
                    color: appWhiteColor.withValues(alpha: 0.55),
                    fontSize: 15.sp,
                    fontFamily: mainFontFamily,
                  ),
                  border: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: appWhiteColor.withValues(alpha: 0.85),
                    ),
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
            ),
          ],
        ),
      ],
    );
  }
}
