import 'package:flutter/material.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/item_details/models/item_details_model.dart';
import '../../features/item_details/presentation/screens/item_details_screen.dart';
import '../../features/main_layout/main_layout.dart';
import '../../features/payment/presentation/screens/payment_screen.dart';
import '../../features/favorites/presentation/screens/favorites_screen.dart';
import '../../features/coupon/presentation/screens/coupon_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/order/presentation/screens/order_history.dart';
import '../../features/admin/presentation/screens/admin_login_screen.dart';
import '../../features/admin/presentation/screens/admin_user_list_screen.dart';
import '../../features/onboarding/presentation/screens/landing_page_screen.dart';

abstract class Routes {
  static const String mainLayout = "/mainLayout";

  static const String landingPages = "/landing_page";

  static const String homepage = "home_page";

  static const String cart = "/cart";

  static const String payment = "/payment";

  /// auth related
  static const String register = "/auth/register";
  static const String login = "/auth/login";
  static const String confirmAccount = "/auth/confirm_account";
  static const String forgetPassword = "/auth/forget_password";
  static const String resetPassword = "/auth/reset_password";

  /// drawer items
  static const String aboutUs = "/aboutUs";
  static const String searchScreen = "/searchScreen";
  static const String privacyPolicy = "/privacyPolicy";
  static const String socialMedia = "/socialMedia";

  static const String profile = "/user_profile";

  static const String notifications = "/notifications";
  static const String moreScreen = "/moreScreen";
  static const String favorites = "/favorites";
  static const String appUpdates = "/appUpdates";
  static const String couppon = "/couppon";
  static const String itemDetails = "/item_details";
  static const String orderHistory = "/order_history";

  static const String adminLogin = "/admin/login";
  static const String adminUsers = "/admin/users";
}

bool isLoggedIn = false;

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  // final args = settings.arguments as Map<String, dynamic>?;

  switch (settings.name) {
    case Routes.landingPages:
      return MaterialPageRoute(
        builder: (_) => const LandingPageScreen(),
        settings: const RouteSettings(name: Routes.landingPages),
      );

    case Routes.mainLayout:
      return MaterialPageRoute(
        builder: (_) => const MainLayout(),
        settings: const RouteSettings(name: Routes.mainLayout),
      );

    case Routes.login:
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
        settings: const RouteSettings(name: Routes.login),
      );

    case Routes.register:
      return MaterialPageRoute(
        builder: (_) => const RegisterScreen(),
        settings: const RouteSettings(name: Routes.register),
      );

    case Routes.itemDetails:
      final item = settings.arguments as ItemDetailsModel;
      return MaterialPageRoute(
        builder: (_) => ItemDetailsScreen(item: item),
        settings: const RouteSettings(name: Routes.itemDetails),
      );
    case Routes.cart:
      return MaterialPageRoute(
        builder: (_) => const CartScreen(),
        settings: const RouteSettings(name: Routes.cart),
      );
    case Routes.payment:
      final totalPrice = settings.arguments as double? ?? 0;
      return MaterialPageRoute(
        builder: (_) => PaymentScreen(totalPrice: totalPrice),
        settings: const RouteSettings(name: Routes.payment),
      );
    case Routes.favorites:
      return MaterialPageRoute(
        builder: (_) => const FavoritesScreen(),
        settings: const RouteSettings(name: Routes.favorites),
      );

    case Routes.profile:
      return MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
        settings: const RouteSettings(name: Routes.profile),
      );

    case Routes.couppon:
      return MaterialPageRoute(
        builder: (_) => const CouponScreen(),
        settings: const RouteSettings(name: Routes.couppon),
      );

    case Routes.orderHistory:
      return MaterialPageRoute(
        builder: (_) => const OrderHistory(),
        settings: const RouteSettings(name: Routes.orderHistory),
      );

    case Routes.adminLogin:
      return MaterialPageRoute(
        builder: (_) => const AdminLoginScreen(),
        settings: const RouteSettings(name: Routes.adminLogin),
      );

    case Routes.adminUsers:
      return MaterialPageRoute(
        builder: (_) => const AdminUserListScreen(),
        settings: const RouteSettings(name: Routes.adminUsers),
      );

    // case Routes.couppon:
    //   return MaterialPageRoute(
    //     builder: (_) => const CoupponScreen(),
    //     settings: const RouteSettings(name: Routes.couppon),
    //);

    // case Routes.profile:
    //   if (!isLoggedIn) {
    //     return MaterialPageRoute(
    //       builder: (_) => const Scaffold(
    //         body: Center(
    //           child: Text("Please login first"),
    //         ),
    //       ),
    //     );
    //   }
    //   else
    //     {
    //       final name = args?['name'] ?? "Tamkeen";
    //       return MaterialPageRoute(
    //         builder: (_) => ProfileScreen(username: name),
    //         settings: const RouteSettings(name: Routes.profile),
    //       );
    //     }

    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text("No route defined"))),
        settings: const RouteSettings(name: 'undefined'),
      );
  }
}
