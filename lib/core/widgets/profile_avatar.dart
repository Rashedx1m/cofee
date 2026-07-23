import 'package:exercise_projects/core/config/profile_assets.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';

/// صورة بروفايل من assets — إن فشل التحميل تظهر [Icons.person].
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.imageAsset = AppProfileAssets.profileImage,
    required this.radius,
    this.borderRadius,
    this.backgroundColor = searchFieldFill,
    this.iconColor = appGreyColor,
    this.iconSize,
  });

  final String? imageAsset;
  final double radius;
  final double? borderRadius;
  final Color backgroundColor;
  final Color iconColor;
  final double? iconSize;

  Widget _personIcon() {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Icon(
        Icons.person,
        color: iconColor,
        size: iconSize ?? radius * 1.1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final path = imageAsset?.trim();
    if (path == null || path.isEmpty) {
      return _personIcon();
    }

    final size = radius * 2;
    final clipRadius = borderRadius ?? radius;

    return ClipRRect(
      borderRadius: BorderRadius.circular(clipRadius),
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _personIcon(),
        ),
      ),
    );
  }
}
