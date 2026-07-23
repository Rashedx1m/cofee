import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/features/admin/models/admin_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

Future<void> showAddPointsDialog(
  BuildContext context, {
  required AdminUserModel user,
  required void Function(int addedPoints) onSubmit,
}) {
  final controller = TextEditingController();
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black54,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: appWhiteColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                user.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: mainFontFamily,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Beans ${user.totalBeans}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: mainFontFamily,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Image.asset('assets/images/256.png', height: 18.h),
                ],
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'added points',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black54,
                    fontFamily: mainFontFamily,
                  ),
                ),
              ),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '210',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    final points = int.tryParse(controller.text.trim()) ?? 0;
                    if (points <= 0) return;
                    onSubmit(points);
                    Navigator.pop(dialogContext);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreenColor,
                    foregroundColor: appWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    'submit',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: mainFontFamily,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
