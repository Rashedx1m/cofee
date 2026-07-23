import 'package:exercise_projects/core/widgets/profile_avatar.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({super.key});

  static const _coupons = [
    {
      'title': '70% discount for any instant coffee package',
      'badge': '70%',
      'image': 'assets/images/beanDitales.png',
    },
    {
      'title': 'new special Americano ~',
      'badge': 'NEW',
      'image': 'assets/images/cappuccino.png',
    },
    {
      'title': '30% discount for any coffee package',
      'badge': '30%',
      'image': 'assets/images/beanDitales.png',
    },
  ];

  BoxDecoration get _goldBorderCard => BoxDecoration(
        color: couponCardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: couponGold.withValues(alpha: 0.9),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 20.w, 110.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Best Coffee For You',
                style: bestWhiteTextStyle.copyWith(fontSize: 22.sp),
              ),
              SizedBox(height: 18.h),
              _buildProfileCard(),
              SizedBox(height: 26.h),
              Row(
                children: [
                  Icon(Icons.local_offer_outlined, color: couponGold, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Cubons',
                    style: TextStyle(
                      color: appWhiteColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: mainFontFamily,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              ..._coupons.map(
                (c) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _buildCouponCard(
                    title: c['title'] as String,
                    badge: c['badge'] as String,
                    imageAsset: c['image'] as String,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: couponProfileCardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: couponGold.withValues(alpha: 0.85), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ProfileAvatar(radius: 30.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mustafa Hussein',
                      style: TextStyle(
                        color: appWhiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: mainFontFamily,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '+966 544 545 423',
                      style: TextStyle(
                        color: appGreyColor,
                        fontSize: 13.sp,
                        fontFamily: mainFontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Text(
            'My Total Beans',
            style: TextStyle(
              color: appWhiteColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: mainFontFamily,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '256',
                style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: mainFontFamily,
                ),
              ),
              SizedBox(width: 8.w),
              Image.asset('assets/images/256.png', height: 26.h),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Collect more beans to unlock coupons',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: couponGold,
              fontSize: 12.sp,
              fontFamily: mainFontFamily,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.qr_code_scanner, color: darkGreenColor, size: 20.sp),
              label: Text(
                'Scan me',
                style: TextStyle(
                  color: darkGreenColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: mainFontFamily,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: couponGold,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard({
    required String title,
    required String badge,
    required String imageAsset,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 10.w, 12.h),
      decoration: _goldBorderCard,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: appWhiteColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    fontFamily: mainFontFamily,
                  ),
                ),
                SizedBox(height: 14.h),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: couponGold,
                    side: BorderSide(color: couponGold.withValues(alpha: 0.9)),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'more info >>',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: mainFontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          _buildCouponThumbnail(badge: badge, imageAsset: imageAsset),
        ],
      ),
    );
  }

  Widget _buildCouponThumbnail({
    required String badge,
    required String imageAsset,
  }) {
    return SizedBox(
      width: 72.w,
      height: 72.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: darkGreenColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: couponGold.withValues(alpha: 0.35),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11.r),
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.local_cafe_outlined,
                  color: couponGold,
                  size: 32.sp,
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: -4,
            end: -4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: couponGold,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                badge,
                style: TextStyle(
                  color: darkGreenColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: mainFontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
