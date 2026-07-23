import 'dart:ui';

import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';

import '../cart/presentation/screens/cart_screen.dart';
import '../coupon/presentation/screens/coupon_screen.dart';
import '../favorites/presentation/screens/favorites_screen.dart';

/// Figma: Group 16 — هيكل التطبيق الرئيسي (Home, Orders, Favorites, Coupon).
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;


  late final List<Widget> screens = [

    const HomeScreen(),
    const CartScreen(),
    //const OrderHistory(),
    //_tabPlaceholder(title: 'Favorites', icon: Icons.favorite_border),
    const FavoritesScreen(),
    const CouponScreen(),

  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      extendBody: true,
      backgroundColor: appPrimaryColor,

      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  /// شريط سفلي داكن — ارتفاع Figma ≈ 89.
  /// شريط سفلي: زجاجي شفاف بس بتبويب Favorites، وداكن عادي بالباقي.
  Widget _bottomNavBar() {
    final isFavoritesTab = currentIndex == 2;

    final navBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      currentIndex: currentIndex,
      selectedItemColor: secondaryColor,
      unselectedItemColor: appGreyColor,
      showSelectedLabels: false,
      onTap: (index) {
        setState(() => currentIndex = index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          activeIcon: Icon(Icons.shopping_bag),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer_outlined),
          activeIcon: Icon(Icons.local_offer),
          label: 'Coupon',
        ),
      ],
    );

    if (!isFavoritesTab) {
      // الشكل العادي: خلفية داكنة صلبة بدون بلر.
      return Container(
        decoration: const BoxDecoration(color: darkGreenColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            navBar,
            _homeIndicator(),
          ],
        ),
      );
    }

    // شكل Favorites: زجاجي شفاف (Frosted glass) — تدرّج + بلر، مطابق للفيجما.
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          decoration: BoxDecoration(
            //color: const Color.fromRGBO(0, 0, 0, 0),

          // gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [
          //        Color.fromRGBO(12, 15, 20, 0.1),
          //       darkGreenColor.withValues(alpha: 0.55),
          //       darkGreenColor.withValues(alpha: 0.85),
          //     ],
          //     stops: const [0.0, 0.4, 1.0],
          //   ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              navBar,
              _homeIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  /// خط "Home Indicator" الأبيض الرفيع (Figma: "14 Footer", 390×34).
  Widget _homeIndicator() {
    return Container(
      height: 34,
      alignment: Alignment.center,
      child: Container(
        width: 134,
        height: 5,
        decoration: BoxDecoration(
          color: appWhiteColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
