import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';
import 'package:exercise_projects/core/widgets/profile_avatar.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:exercise_projects/core/routing/routing.dart';
import '../../models/cart_item_model.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            SizedBox(height: 16.h),
            Expanded(
              child: cart.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: cart.items.length,
                      separatorBuilder: (_, _) => SizedBox(height: 14.h),
                      itemBuilder: (context, index) =>
                          _buildCartItemCard(context, cart.items[index]),
                    ),
            ),
            _buildBottomBar(context, cart),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'Your cart is empty',
        style: TextStyle(color: appGreyColor, fontSize: 14.sp),
      ),
    );
  }

  // -------- Header --------
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.orderHistory),
            borderRadius: BorderRadius.circular(10),
            child: Icon(
              Icons.grid_view_rounded,
              color: appWhiteColor,
              size: 22.sp,
            ),
          ),
          Expanded(
            child: Text(
              'Cart',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appWhiteColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.profile),
            child: ProfileAvatar(radius: 16.r, iconSize: 18.sp),
          ),
        ],
      ),
    );
  }

  // -------- Cart Item Card --------
  Widget _buildCartItemCard(BuildContext context, CartItemModel item) {
    return Container(
      padding: EdgeInsets.all(12.w),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              item.image,
              width: 64.w,
              height: 64.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          color: appWhiteColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          context.read<CartProvider>().removeItem(item),
                      borderRadius: BorderRadius.circular(6.r),
                      child: Icon(
                        Icons.delete_outline,
                        size: 18.sp,
                        color: appGreyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  item.subtitle,
                  style: TextStyle(color: appGreyColor, fontSize: 12.sp),
                ),
                SizedBox(height: 10.h),
                ...item.entries.map(
                  (entry) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: _buildSizeRow(context, entry),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeRow(BuildContext context, CartSizeEntry entry) {
    return Row(
      children: [
        SizedBox(
          width: 40.w,
          child: Text(
            entry.label,
            style: TextStyle(color: appWhiteColor, fontSize: 13.sp),
          ),
        ),
        SizedBox(
          width: 60.w,
          child: Text(
            '\$ ${entry.price.toStringAsFixed(2)}',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(),
        _buildQuantityStepper(context, entry),
      ],
    );
  }

  Widget _buildQuantityStepper(BuildContext context, CartSizeEntry entry) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _stepperButton(
          icon: Icons.remove,
          onTap: () => context.read<CartProvider>().changeQuantity(entry, -1),
        ),
        Container(
          width: 32.w,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 4.h),
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            border: Border.all(color: appGreyColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            '${entry.quantity}',
            style: TextStyle(color: appWhiteColor, fontSize: 13.sp),
          ),
        ),
        _stepperButton(
          icon: Icons.add,
          onTap: () => context.read<CartProvider>().changeQuantity(entry, 1),
        ),
      ],
    );
  }

  Widget _stepperButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        width: 24.w,
        height: 24.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Icon(icon, size: 14.sp, color: darkGreenColor),
      ),
    );
  }

  // -------- Bottom Bar --------
  Widget _buildBottomBar(BuildContext context, CartProvider cart) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Price',
                style: TextStyle(color: appGreyColor, fontSize: 12.sp),
              ),
              Text(
                '\$ ${cart.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Container(
              height: 52.h,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: MaterialButton(
                onPressed: cart.isEmpty
                    ? null
                    : () {
                        Navigator.pushNamed(
                          context,
                          Routes.payment,
                          arguments: cart.totalPrice,
                        );
                      },
                child: Text(
                  'Pay',
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
      ),
    );
  }
}
