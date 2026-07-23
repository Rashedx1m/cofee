import 'package:exercise_projects/core/config/app_config.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:exercise_projects/core/widgets/profile_avatar.dart';
import 'package:exercise_projects/features/admin/models/admin_user_model.dart';
import 'package:exercise_projects/features/admin/presentation/widgets/add_points_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class AdminUserListScreen extends StatefulWidget {
  const AdminUserListScreen({super.key});

  @override
  State<AdminUserListScreen> createState() => _AdminUserListScreenState();
}

class _AdminUserListScreenState extends State<AdminUserListScreen> {
  final _searchController = TextEditingController();

  final List<AdminUserModel> _users = [
    AdminUserModel(name: 'Mustafa Hussein', totalBeans: 256),
    AdminUserModel(name: 'Robert Evans', totalBeans: 180),
    AdminUserModel(name: 'Zedo Eybo', totalBeans: 142),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AdminUserModel> get _filteredUsers {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return _users;
    return _users.where((u) => u.name.toLowerCase().contains(q)).toList();
  }

  Future<void> _logout() async {
    await context.read<AppConfig>().setIsLogIn(false);
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (_) => false);
  }

  void _openAddPoints(AdminUserModel user) {
    showAddPointsDialog(
      context,
      user: user,
      onSubmit: (points) {
        setState(() => user.totalBeans += points);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authCreamBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'HELLO ZIAD!',
                      style: TextStyle(
                        color: darkGreenColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: mainFontFamily,
                      ),
                    ),
                  ),
                  ProfileAvatar(radius: 18.r, iconSize: 18.sp),
                  SizedBox(width: 8.w),
                  Text(
                    '250',
                    style: TextStyle(
                      color: darkGreenColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Image.asset('assets/images/256.png', height: 20.h),
                  IconButton(
                    onPressed: _logout,
                    icon: Icon(Icons.logout, color: darkGreenColor, size: 22.sp),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search user...',
                  prefixIcon: Icon(Icons.search, color: appGreyColor),
                  suffixIcon: Icon(Icons.tune, color: appGreyColor),
                  filled: true,
                  fillColor: appWhiteColor.withValues(alpha: 0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: _filteredUsers.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final user = _filteredUsers[index];
                  return _UserCard(
                    user: user,
                    onTap: () => _openAddPoints(user),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_users.isNotEmpty) _openAddPoints(_users.first);
                  },
                  icon: Icon(Icons.qr_code_scanner, color: appWhiteColor),
                  label: Text(
                    'Scan user QR',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: mainFontFamily,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreenColor,
                    foregroundColor: appWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user, required this.onTap});

  final AdminUserModel user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: authSagePanelColor,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        color: appWhiteColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: mainFontFamily,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Text(
                          'My Total Beans ${user.totalBeans}',
                          style: TextStyle(
                            color: appWhiteColor.withValues(alpha: 0.85),
                            fontSize: 13.sp,
                            fontFamily: mainFontFamily,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Image.asset('assets/images/256.png', height: 16.h),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: appWhiteColor.withValues(alpha: 0.7)),
            ],
          ),
        ),
      ),
    );
  }
}
