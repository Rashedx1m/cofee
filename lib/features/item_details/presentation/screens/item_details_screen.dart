import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/features/cart/providers/cart_provider.dart';
import '../../../favorites/providers/favorites_provider.dart';
import '../../models/item_details_model.dart';
import '../widgets/product_hero_card.dart';

/// One screen used for BOTH "BeanDetailsScreen" and "CoffeeDetailsScreen"
/// from the Figma design. Only the [item] passed in changes.
class ItemDetailsScreen extends StatefulWidget {
  final ItemDetailsModel item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  int _selectedSizeIndex = 0;


  String get _selectedSize => widget.item.sizeLabels[_selectedSizeIndex];
  double get _selectedPrice => widget.item.pricesBySize[_selectedSize] ?? 0;

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductHeroCard(
                item: widget.item,
                imageHeight: 320,
                showBackButton: true,
                isFavorite: favorites.isFavorite(widget.item),
                onBack: () => Navigator.pop(context),
                onFavoriteToggle: () =>  favorites.toggle(widget.item),
              ),
              SizedBox(height: 50.h), // مساحة تحت الصورة عشان اللوحة العايمة
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        color: appWhiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.item.description,
                      style: TextStyle(
                        color: appGreyColor,
                        fontSize: 13.sp,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Size',
                      style: TextStyle(
                        color: appWhiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildSizeSelector(),
                    const SizedBox(height: 24),
                    _buildPriceAndAddToCart(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Row(
      children: List.generate(widget.item.sizeLabels.length, (index) {
        final isSelected = index == _selectedSizeIndex;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => setState(() => _selectedSizeIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isSelected ? secondaryColor : searchFieldFill,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.item.sizeLabels[index],
                style: TextStyle(
                  color: isSelected ? darkGreenColor : appWhiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPriceAndAddToCart() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price', style: TextStyle(color: appGreyColor, fontSize: 13.sp)),
            Text(
              '\$ ${_selectedPrice.toStringAsFixed(2)}',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: MaterialButton(
              onPressed: () {
                context.read<CartProvider>().addItem(
                  name: widget.item.name,
                  subtitle: widget.item.subtitle,
                  image: widget.item.image,
                  sizeLabel: _selectedSize,
                  price: _selectedPrice,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.item.name} ($_selectedSize) added to cart'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  color: darkGreenColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}