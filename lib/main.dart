import 'package:exercise_projects/core/config/app_config.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:exercise_projects/features/onboarding/presentation/screens/landing_page_screen.dart';
import 'package:exercise_projects/features/admin/bloc/admin_auth_cubit.dart';
import 'package:exercise_projects/features/admin/presentation/screens/admin_user_list_screen.dart';
import 'package:exercise_projects/features/auth/presentation/screens/login_screen.dart';
import 'package:exercise_projects/features/auth/bloc/auth_cubit.dart';
import 'package:exercise_projects/features/cart/providers/cart_provider.dart';
import 'package:exercise_projects/features/favorites/providers/favorites_provider.dart';
import 'package:exercise_projects/features/home/bloc/home_screen_cubit.dart';
import 'package:exercise_projects/features/main_layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';
import 'Localization/l10n/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appConfig = AppConfig();
  await appConfig.init();

  runApp(
    ChangeNotifierProvider.value(
      value: appConfig,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget _home(AppConfig config) {
    if (!config.onboardingDone) return const LandingPageScreen();
    if (!config.isLogin) return const LoginScreen();
    if (config.isAdmin) return const AdminUserListScreen();
    return const MainLayout();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      child: const SizedBox.shrink(),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => FavoritesProvider()),
            BlocProvider(create: (context) => HomeScreenCubit()),
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(create: (context) => AdminAuthCubit()),
          ],
          child: Consumer<AppConfig>(
            builder: (context, config, child) {
              return MaterialApp(
                key: ValueKey(
                  'root-${config.onboardingDone}-${config.isLogin}-${config.isAdmin}',
                ),
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                  fontFamily: 'Tajawal',
                ),
                debugShowCheckedModeBanner: false,
                onGenerateRoute: onGenerateRoute,
                home: _home(config),
                locale: Locale(config.selectLang),
                supportedLocales: const [Locale('en'), Locale('ar')],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
              );
            },
          ),
        );
      },
    );
  }
}
