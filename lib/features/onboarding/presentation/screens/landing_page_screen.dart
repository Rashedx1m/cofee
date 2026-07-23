import 'package:exercise_projects/core/config/app_config.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({super.key});

  @override
  State<LandingPageScreen> createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const _slides = [
    _LandingSlide(
      imageAsset: 'assets/images/loginfoto.png',
      caption: _CaptionType.plain,
      plainText: 'coffee first then talk !',
    ),
    _LandingSlide(
      imageAsset: 'assets/images/Group 2.png',
      caption: _CaptionType.sipHighlight,
    ),
    _LandingSlide(
      imageAsset: 'assets/images/Group 3.png',
      caption: _CaptionType.chafeHighlight,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onNext() async {
    if (_currentPage < _slides.length - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
      return;
    }
    await context.read<AppConfig>().completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: authCreamBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              slide.imageAsset,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.coffee,
                                size: 120.sp,
                                color: darkGreenColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildCaption(slide),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              _buildDots(),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreenColor,
                    foregroundColor: appWhiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: mainFontFamily,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_slides.length, (index) {
        final active = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: active ? 10.w : 8.w,
          height: active ? 10.w : 8.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? darkGreenColor : darkGreenColor.withValues(alpha: 0.25),
          ),
        );
      }),
    );
  }

  Widget _buildCaption(_LandingSlide slide) {
    switch (slide.caption) {
      case _CaptionType.plain:
        return Text(
          slide.plainText!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: darkGreenColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: mainFontFamily,
          ),
        );
      case _CaptionType.sipHighlight:
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              color: darkGreenColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              fontFamily: mainFontFamily,
            ),
            children: [
              const TextSpan(text: 'just one '),
              TextSpan(
                text: 'sip',
                style: TextStyle(
                  color: secondaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: secondaryColor,
                ),
              ),
              const TextSpan(text: ' and feel good'),
            ],
          ),
        );
      case _CaptionType.chafeHighlight:
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              color: darkGreenColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              fontFamily: mainFontFamily,
            ),
            children: [
              const TextSpan(text: 'so '),
              TextSpan(
                text: 'chafe',
                style: TextStyle(color: secondaryColor),
              ),
              const TextSpan(text: ' will make you smile :)'),
            ],
          ),
        );
    }
  }
}

enum _CaptionType { plain, sipHighlight, chafeHighlight }

class _LandingSlide {
  final String imageAsset;
  final _CaptionType caption;
  final String? plainText;

  const _LandingSlide({
    required this.imageAsset,
    required this.caption,
    this.plainText,
  });
}
