import 'package:country_flags/country_flags.dart';
import 'package:exercise_projects/Localization/l10n/app_localization.dart';
import 'package:exercise_projects/core/config/app_config.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final GlobalKey _chooseLanguageKey = GlobalKey();

  void _openPage(BuildContext context, String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final config = context.watch<AppConfig>();

    return Container(
      color: appPrimaryColor,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
        children: [
          SizedBox(height: 12.h),
          Center(
            child: Image.asset(
              'assets/images/loginfoto.png',
              height: 88.h,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Coffee App',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: appWhiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              fontFamily: mainFontFamily,
            ),
          ),
          SizedBox(height: 24.h),
          _menuCard(
            context,
            children: [
              _DrawerMenuItem(
                icon: Icons.receipt_long_outlined,
                label: l10n.orderHistory,
                onTap: () => _openPage(context, Routes.orderHistory),
              ),
              Divider(color: couponGold.withValues(alpha: 0.25), height: 1),
              _DrawerMenuItem(
                icon: Icons.person_outline,
                label: l10n.profile,
                onTap: () => _openPage(context, Routes.profile),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _menuCard(
            context,
            children: [
              ListTile(
                key: _chooseLanguageKey,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                leading: Icon(Icons.language, color: secondaryColor, size: 26.sp),
                title: Text(
                  l10n.chooseLanguage,
                  style: mediumWhiteTextStyle.copyWith(fontSize: 16.sp),
                ),
                subtitle: Text(
                  config.selectLang == 'ar' ? 'العربية' : 'English',
                  style: smallGreyTextStyle.copyWith(fontSize: 12.sp),
                ),
                onTap: () => _showLanguageMenu(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: couponProfileCardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: couponGold.withValues(alpha: 0.75), width: 1),
      ),
      child: Column(children: children),
    );
  }

  Future<void> _showLanguageMenu(BuildContext context) async {
    final renderBox =
        _chooseLanguageKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    final code = await showMenu<String>(
      context: context,
      color: couponProfileCardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: couponGold.withValues(alpha: 0.6)),
      ),
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'ar',
          child: _languageRow(flagCode: 'SA', label: 'العربية'),
        ),
        PopupMenuItem<String>(
          value: 'en',
          child: _languageRow(flagCode: 'US', label: 'English'),
        ),
      ],
    );

    if (code != null && context.mounted) {
      await context.read<AppConfig>().setSelectLang(code);
    }
  }

  Widget _languageRow({required String flagCode, required String label}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Container(
            height: 36.h,
            width: 52.w,
            decoration: BoxDecoration(
              border: Border.all(color: couponGold.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: CountryFlag.fromCountryCode(
              flagCode,
              theme: const ImageTheme(),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            label,
            style: TextStyle(
              color: appWhiteColor,
              fontSize: 15.sp,
              fontFamily: mainFontFamily,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  const _DrawerMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
      leading: Icon(icon, color: secondaryColor, size: 24.sp),
      title: Text(
        label,
        style: TextStyle(
          color: appWhiteColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: mainFontFamily,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: appGreyColor,
        size: 14.sp,
      ),
      onTap: onTap,
    );
  }
}
