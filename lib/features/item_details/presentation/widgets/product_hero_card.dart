import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import '../../models/item_details_model.dart';

class ProductHeroCard extends StatelessWidget {
  final ItemDetailsModel item;
  final double imageHeight;
  final bool showBackButton;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onBack;

  const ProductHeroCard({
    super.key,
    required this.item,
    this.imageHeight = 420,
    this.showBackButton = false,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.onBack,
  });

  bool get _isFromOrigin => item.subtitle.toLowerCase().startsWith('from');

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            item.image,
            width: double.infinity,
            height: imageHeight,
            fit: BoxFit.cover,
          ),
        ),
        if (showBackButton)
          Positioned(
            top: 12,
            left: 12,
            child: _circleIconButton(
              icon: Icons.arrow_back,
              onTap: onBack,
            ),
          ),
        Positioned(
          top: 12,
          right: 12,
          child: _circleIconButton(
            icon: isFavorite ? Icons.favorite : Icons.favorite_border,
            iconColor: isFavorite ? Colors.red : appWhiteColor,
            onTap: onFavoriteToggle,
          ),
        ),
        Positioned(
           left: 0,
           right: 0,
          bottom: -1,
          child: _buildInfoPanel(),
        ),
      ],
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback? onTap,
    Color iconColor = appWhiteColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  Widget _buildInfoPanel() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    color: appWhiteColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item.subtitle,
                  style: TextStyle(color: appGreyColor, fontSize: 12.sp),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.star, color: secondaryColor, size: 15.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '${item.rating} (${item.ratingCount})',
                      style: TextStyle(color: appWhiteColor, fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  _panelIconChip(Icons.coffee),
                  SizedBox(width: 8.w),
                  _panelIconChip(_isFromOrigin ? Icons.public : Icons.local_cafe),
                ],
              ),
              SizedBox(height: 8.h),
              _panelPill(item.roastLevel),
            ],
          ),
        ],
      ),
    );
  }

  Widget _panelIconChip(IconData icon) {
    return Container(
      width: 34.w,
      height: 34.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(6, 71, 65, 1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: appWhiteColor, size: 16.sp),
    );
  }

  Widget _panelPill(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(6, 71, 65, 1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(color: appWhiteColor, fontSize: 10.sp),
      ),
    );
  }
}