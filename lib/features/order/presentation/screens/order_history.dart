import 'package:exercise_projects/Localization/l10n/app_localization.dart';
import 'package:exercise_projects/core/resources/colors_and_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

/// سجل الطلبات — بيانات تجريبية للتعليم.
class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  static const _demoOrders = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      appBar: AppBar(
        backgroundColor: appPrimaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: secondaryColor, size: 20.sp),
        ),
        title: Text(
          AppLocalizations.of(context)!.orderHistory,
          style: appBarTextStyle.copyWith(fontSize: 18.sp),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: _demoOrders,
        separatorBuilder: (_, __) => SizedBox(height: 20.h),
        itemBuilder: (context, index) => _OrderCard(
          orderDate: '25/7/2026',
          totalAmount: '700 \$',
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.orderDate,
    required this.totalAmount,
  });

  final String orderDate;
  final String totalAmount;

  static const _sizeLines = [
    _SizeLine(size: 'S', unitPrice: '350 \$', qty: 'X2', lineTotal: '700 \$'),
    _SizeLine(size: 'M', unitPrice: '400 \$', qty: 'X1', lineTotal: '400 \$'),
    _SizeLine(size: 'L', unitPrice: '450 \$', qty: 'X1', lineTotal: '450 \$'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _labelValue('Order Date', orderDate),
            _labelValue('Total Amount', totalAmount, valueColor: secondaryColor),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.r),
            gradient: advancedGradient,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ExpansionTile(
              tilePadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              childrenPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
              iconColor: Colors.transparent,
              collapsedIconColor: Colors.transparent,
              title: _productRow(),
              children: _sizeLines
                  .map(
                    (line) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: _SizeDetailRow(line: line),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _labelValue(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: appWhiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            fontFamily: mainFontFamily,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? appWhiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
            fontFamily: mainFontFamily,
          ),
        ),
      ],
    );
  }

  Widget _productRow() {
    return SizedBox(
      height: 70.h,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              'assets/images/cappuccino.png',
              width: 70.h,
              height: 70.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cappuccino',
                  style: TextStyle(
                    color: appWhiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: mainFontFamily,
                  ),
                ),
                Text(
                  'milk, coffee, stuff',
                  style: TextStyle(
                    color: appGreyColor,
                    fontSize: 13.sp,
                    fontFamily: mainFontFamily,
                  ),
                ),
              ],
            ),
          ),
          Text(
            totalAmount,
            style: TextStyle(
              color: secondaryColor,
              fontSize: 14.sp,
              fontFamily: mainFontFamily,
            ),
          ),
        ],
      ),
    );
  }
}

class _SizeLine {
  final String size;
  final String unitPrice;
  final String qty;
  final String lineTotal;

  const _SizeLine({
    required this.size,
    required this.unitPrice,
    required this.qty,
    required this.lineTotal,
  });
}

class _SizeDetailRow extends StatelessWidget {
  const _SizeDetailRow({required this.line});

  final _SizeLine line;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: darkGreenColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Text(
                line.size,
                style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: mainFontFamily,
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                line.unitPrice,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 15.sp,
                  fontFamily: mainFontFamily,
                ),
              ),
            ],
          ),
        ),
        Text(
          line.qty,
          style: TextStyle(
            color: appWhiteColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            fontFamily: mainFontFamily,
          ),
        ),
        Text(
          line.lineTotal,
          style: TextStyle(
            color: appWhiteColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            fontFamily: mainFontFamily,
          ),
        ),
      ],
    );
  }
}
