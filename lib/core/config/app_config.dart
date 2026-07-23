import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig extends ChangeNotifier {
  bool isLogin = false;
  bool isAdmin = false;
  bool onboardingDone = false;
  String selectLang = 'en';

  late SharedPreferences _pref;

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
    loadPref();
  }

  void loadPref() {
    final saved = (_pref.getString('lang') ?? 'en').trim();
    selectLang = (saved == 'ar' || saved == 'en') ? saved : 'en';
    isLogin = _pref.getBool('IsLogIn') ?? false;
    isAdmin = _pref.getBool('IsAdmin') ?? false;
    onboardingDone = _pref.getBool('OnboardingDone') ?? false;
    if (!isLogin) isAdmin = false;
    notifyListeners();
  }

  Future<void> setSelectLang(String lang) async {
    selectLang = lang.trim();
    await _pref.setString('lang', selectLang);
    notifyListeners();
  }

  /// [asAdmin] true فقط عند تسجيل دخول الأدمن.
  Future<void> setIsLogIn(bool auth, {bool asAdmin = false}) async {
    isLogin = auth;
    isAdmin = auth && asAdmin;
    await _pref.setBool('IsLogIn', auth);
    await _pref.setBool('IsAdmin', isAdmin);
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    onboardingDone = true;
    await _pref.setBool('OnboardingDone', true);
    notifyListeners();
  }
}
