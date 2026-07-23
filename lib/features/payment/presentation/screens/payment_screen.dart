import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';

enum _PaymentMethod { creditCard, wallet, googlePay, applePay, amazonPay }

class PaymentScreen extends StatefulWidget {
  final double totalPrice;

  const PaymentScreen({super.key, this.totalPrice = 0});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  _PaymentMethod _selected = _PaymentMethod.creditCard;

  String get _payButtonLabel {
    switch (_selected) {
      case _PaymentMethod.creditCard:
        return 'Pay from Credit Card';
      case _PaymentMethod.wallet:
        return 'Pay from Wallet';
      case _PaymentMethod.googlePay:
        return 'Pay with Google Pay';
      case _PaymentMethod.applePay:
        return 'Pay with Apple Pay';
      case _PaymentMethod.amazonPay:
        return 'Pay with Amazon Pay';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    _buildCreditCard(),
                    SizedBox(height: 24.h),
                    _buildMethodRow(
                      method: _PaymentMethod.wallet,
                      imagePath: 'assets/images/wallet.png',
                      label: 'Wallet',
                      trailing: '\$ 100.50',
                    ),
                    SizedBox(height: 12.h),
                    _buildMethodRow(
                      method: _PaymentMethod.googlePay,
                      imagePath: 'assets/images/google.png',
                      label: 'Google Pay',
                    ),
                    SizedBox(height: 12.h),
                    _buildMethodRow(
                      method: _PaymentMethod.applePay,
                      imagePath: 'assets/images/apple.png',
                      label: 'Apple Pay',
                    ),
                    SizedBox(height: 12.h),
                    _buildMethodRow(
                      method: _PaymentMethod.amazonPay,
                      imagePath: 'assets/images/amazon.png',
                      label: 'Amazon Pay',
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  // -------- Header --------
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.maybePop(context),
            borderRadius: BorderRadius.circular(10),
            child: Icon(Icons.arrow_back, color: appWhiteColor, size: 22.sp),
          ),
          Expanded(
            child: Text(
              'Payment',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appWhiteColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 22.sp),
        ],
      ),
    );
  }

  // -------- Credit Card --------
  Widget _buildCreditCard() {
    final isSelected = _selected == _PaymentMethod.creditCard;
    return InkWell(
      onTap: () => setState(() => _selected = _PaymentMethod.creditCard),
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          // Figma: linear-gradient(107.76deg, #262B33 2.32%, #0C0F14 100%)
          gradient: LinearGradient(
            begin: const Alignment(-0.95, -0.31),
            end: const Alignment(0.95, 0.31),
            colors: const [
              Color(0xFF262B33),
              Color(0xFF0C0F14),
            ],
            stops: const [0.0232, 1.0],
          ),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected ? secondaryColor : Colors.transparent,
            width: 1.4,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Credit Card',
              style: TextStyle(
                color: appWhiteColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/seemcart.png', width: 32.w, height: 26.sp),
                Text(
                  'VISA',
                  style: TextStyle(
                    color: appWhiteColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              '3897  8923  6745  4638',
              style: TextStyle(
                color: appWhiteColor,
                fontSize: 17.sp,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Holder Name',
                      style: TextStyle(color: appGreyColor, fontSize: 10.sp),
                    ),
                    Text(
                      'Robert Evans',
                      style: TextStyle(
                        color: appWhiteColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Expiry Date',
                      style: TextStyle(color: appGreyColor, fontSize: 10.sp),
                    ),
                    Text(
                      '02/30',
                      style: TextStyle(
                        color: appWhiteColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // -------- Payment method row --------
  Widget _buildMethodRow({
    required _PaymentMethod method,
    required String imagePath,
    required String label,
    String? trailing,
  }) {
    final isSelected = _selected == method;
    return InkWell(
      onTap: () => setState(() => _selected = method),
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          // Figma: linear-gradient(92.49deg, #262B33 0%, #0C0F14 100%)
          gradient: const LinearGradient(
            begin: Alignment(-1.0, -0.04),
            end: Alignment(1.0, 0.04),
            colors: [
              Color(0xFF262B33),
              Color(0xFF0C0F14),
            ],
            stops: [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? secondaryColor : const Color(0xFF262B33),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, width: 22.sp, height: 22.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // -------- Bottom Bar --------
  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: TextStyle(color: appGreyColor, fontSize: 12.sp),
              ),
              Text(
                '\$ ${widget.totalPrice.toStringAsFixed(2)}',
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
                onPressed: () {
                  // TODO: تنفيذ عملية الدفع الفعلية لاحقاً
                },
                child: Text(
                  _payButtonLabel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: darkGreenColor,
                    fontSize: 14.sp,
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