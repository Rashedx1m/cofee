
import 'package:exercise_projects/Localization/l10n/app_localization.dart';
import 'package:exercise_projects/core/models/enum/state_value.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import 'package:exercise_projects/core/widgets/flushbar.dart';
import 'package:exercise_projects/core/widgets/drawer.dart';
import 'package:exercise_projects/features/item_details/models/item_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_config.dart';
import '../bloc/home_screen_cubit.dart';
import '../bloc/home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // -------- بيانات --------
  static const List<String> _categories = [
    'All',
    'Cappuccino',
    'Espresso',
    'Americano',
    'Macchiato',
  ];

  final List<Map<String, String>> _promoBanners = [
    {'image': 'assets/images/bestcoffe1.png'},
    {'image': 'assets/images/bestcoffe1.png'},
    {'image': 'assets/images/bestcoffe1.png'},
  ];

  final List<Map<String, dynamic>> _cappuccinos = [
    {
      'name': 'Cappuccino',
      'subtitle': 'With Steamed Milk',
      'price': '4.20',
      'rating': '4.5',
      'image': 'assets/images/image 5.png',
    },
    {
      'name': 'Cappuccino',
      'subtitle': 'With Oat Milk',
      'price': '4.50',
      'rating': '4.2',
      'image': 'assets/images/image 6.png',
    },
  ];

  int _selectedCategoryIndex = 0;
  final PageController _promoController = PageController(
    viewportFraction: 0.88,
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late AppConfig appConfig;

  @override
  void initState() {
    super.initState();


    context.read<HomeScreenCubit>().getCoffeeFromBackend();
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  // -------- Navigation to ItemDetailsScreen --------

  void _openItemDetails(ItemDetailsModel item) {
    //appConfig.setSelectLang('ar');
    Navigator.pushNamed(context, Routes.itemDetails, arguments: item);
  }

  // Note : هنا لم نطبق state management
  void _openCappuccinoDetails(Map<String, dynamic> item) {
    final price = double.tryParse(item['price'] as String) ?? 0;
    Navigator.pushNamed(
      context,
      Routes.itemDetails,
      arguments: ItemDetailsModel(
        name: item['name'] as String,
        subtitle: item['subtitle'] as String,
        image: item['image'] as String,
        rating: double.tryParse(item['rating'] as String) ?? 0,
        ratingCount: 6879,
        description:
        'Cappuccino is a latte made with more foam than steamed '
            'milk, often with a sprinkle of cocoa powder or cinnamon '
            'on top.',
        sizeLabels: const ['S', 'M', 'L'],
        roastLevel: 'Medium Roasted',
        pricesBySize: {'S': price, 'M': price + 0.3, 'L': price + 0.6},
      ),
    );
  }

  // -------- Build --------
  @override
  Widget build(BuildContext context) {

    appConfig = Provider.of<AppConfig>(context,listen:true);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appPrimaryColor,
      drawer: Drawer(
        backgroundColor: appPrimaryColor,
        width: 300.w,
        child: SafeArea(child: CustomDrawer()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.fromSTEB(24, 40, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 28),
              _buildSearchField(),
              const SizedBox(height: 22),
              _buildCategories(),
              const SizedBox(height: 22),
              _buildPromoBanners(),
              const SizedBox(height: 24),
              _buildSectionTitle('Coffee beans', secondaryColor),
              const SizedBox(height: 14),
              _buildCoffeeBeansList(),
              const SizedBox(height: 24),
              _buildSectionTitle('Cappuccino', appWhiteColor),
              const SizedBox(height: 14),
              _buildCappuccinoList(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // -------- Header --------
  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: const Icon(Icons.menu, color: appWhiteColor),
        ),
        Expanded(
          child: Text(' Best Coffee For You', style: bestWhiteTextStyle),
        ),
        Image.asset('assets/images/256.png', height: 20),
      ],
    );
  }

  // -------- Search --------
  Widget _buildSearchField() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: searchFieldColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        style: const TextStyle(color: appWhiteColor, fontSize: 15),
        decoration: InputDecoration(
          hintText: 'Find Your Coffee...',
          hintStyle: TextStyle(color: appGreyColor, fontSize: 15),
          prefixIcon: Icon(Icons.search, color: appGreyColor, size: 22),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  // -------- Categories --------
  Widget _buildCategories() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategoryIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategoryIndex = index),
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                end: index < _categories.length - 1 ? 22 : 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _categories[index],
                    style: TextStyle(
                      color: isSelected ? appWhiteColor : appGreyColor,
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? secondaryColor : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // -------- Promo Banners --------
  Widget _buildPromoBanners() {
    return AspectRatio(
      aspectRatio: 2.4,
      child: PageView.builder(
        controller: _promoController,
        itemCount: _promoBanners.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  _promoBanners[index]['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // -------- Section Title --------
  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  //  -------- Bean List Cubit) --------
  Widget _buildCoffeeBeansList() {
    // BlocBuilder
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        /// 1
        if (state.coffeeBeansState == StateValue.loading) {
          return const SizedBox(
            height: 246,
            child: Center(
              child: CircularProgressIndicator(color: secondaryColor),
            ),
          );
        }
        final item = state.coffeeBeans;




        /// 2
        if (state.coffeeBeansState == StateValue.fail) {
          return SizedBox(
            height: 246,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.coffeeBeansStateErrorMessage,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () =>
                        context.read<HomeScreenCubit>().getCoffeeFromBackend(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        /// 3
        final beans = state.coffeeBeans;
        if (beans.isEmpty) {
          return const SizedBox(
            height: 246,
            child: Center(
              child: Text(
                'No coffee beans',
                style: TextStyle(color: appGreyColor),
              ),
            ),
          );
        }


        return SizedBox(
          height: 252,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: beans.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final bean = beans[index];

              final price = bean.pricesBySize.values.isNotEmpty
                  ? bean.pricesBySize.values.first
                  : 0;

              return GestureDetector(
                onTap: () => _openItemDetails(bean),
                child: _coffeeBeanCard(
                  name: bean.name,
                  subtitle: bean.subtitle,
                  price: price.toStringAsFixed(2),
                  image: bean.image,
                ),
              );
            },
          ),
        );
      },
    );


  }

  //  -------- Cappuccino List --------
  Widget _buildCappuccinoList() {
    return SizedBox(
      height: 252,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _cappuccinos.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final item = _cappuccinos[index];
          return GestureDetector(
            onTap: () => _openCappuccinoDetails(item),
            child: _cappuccinoCard(
              name: item['name'],
              subtitle: item['subtitle'],
              price: item['price'],
              rating: item['rating'],
              image: item['image'],
            ),
          );
        },
      ),
    );
  }

  // -------- Bean Card --------
  Widget _coffeeBeanCard({
    required String name,
    required String subtitle,
    required String price,
    required String image,
  }) {
    return Container(
      width: 149,
      height: 238,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.30, -0.96),
          end: const Alignment(0.30, 0.96),
          colors: [
            const Color.fromRGBO(120, 120, 120, 0.08),
            const Color.fromRGBO(42, 66, 56, 0.56),
          ],
          stops: const [0.0179, 0.9215],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: 126,
              height: 126,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            maxLines: 1,
            style: TextStyle(
              color: appWhiteColor,
              fontSize: 14.sp,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: appGreyColor, fontSize: 12)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ $price',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _addButton(),
            ],
          ),
        ],
      ),
    );
  }

  // -------- Cappuccino Card --------
  Widget _cappuccinoCard({
    required String name,
    required String subtitle,
    required String price,
    required String rating,
    required String image,
  }) {
    return Container(
      width: 149,
      height: 238,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // Figma: linear-gradient(162.79deg, rgba(120,120,120,0.08) 1.79%, rgba(42,66,56,0.56) 92.15%)
        gradient: LinearGradient(
          begin: const Alignment(-0.30, -0.96),
          end: const Alignment(0.30, 0.96),
          colors: [
            const Color.fromRGBO(120, 120, 120, 0.08),
            const Color.fromRGBO(42, 66, 56, 0.56),
          ],
          stops: const [0.0179, 0.9215],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: 126,
                  height: 126,
                  fit: BoxFit.cover,
                ),
              ),
              PositionedDirectional(
                top: 4,
                end: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: secondaryColor, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(
                          color: appWhiteColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            name,
            maxLines: 1,
            style: TextStyle(
              color: appWhiteColor,
              fontSize: 14.sp,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: appGreyColor, fontSize: 12)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ $price',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _addButton(),
            ],
          ),
        ],
      ),
    );
  }

  // -------- زر الإضافة المشترك --------
  Widget _addButton() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.add, color: darkGreenColor, size: 20),
    );
  }
}










