import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';
import 'package:exercise_projects/core/widgets/profile_avatar.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import '../../../item_details/models/item_details_model.dart';
import '../../../item_details/presentation/widgets/product_hero_card.dart';
import '../../providers/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();

    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: favorites.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                padding: EdgeInsets.fromLTRB(20.w, 66.h, 20.w, 20.h),
                itemCount: favorites.items.length,
                separatorBuilder: (_, _) => SizedBox(height: 60.h),
                itemBuilder: (context, index) => _buildFavoriteItem(
                  context,
                  favorites.items[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------- Header --------
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.orderHistory),
            borderRadius: BorderRadius.circular(10),
            child: Icon(Icons.grid_view_rounded, color: appWhiteColor, size: 22.sp),
          ),
          Expanded(
            child: Text(
              'Favorites',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appWhiteColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.profile),
            child: ProfileAvatar(radius: 16.r, iconSize: 18.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(BuildContext context, ItemDetailsModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductHeroCard(
          item: item,
          imageHeight: 260,
          showBackButton: false,
          isFavorite: true,
          onFavoriteToggle: () =>
              context.read<FavoritesProvider>().remove(item),
        ),
        SizedBox(height: 50.h), // مساحة تحت الصورة عشان اللوحة العايمة
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                item.description,
                style: TextStyle(
                  color: appGreyColor,
                  fontSize: 12.sp,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No favorites yet',
        style: TextStyle(color: appGreyColor, fontSize: 14.sp),
      ),
    );
  }
}