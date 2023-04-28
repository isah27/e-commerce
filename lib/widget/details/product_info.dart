import 'package:e_commerce/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../uitils/usefull_function.dart';

class HomeProductInfo extends StatelessWidget {
  const HomeProductInfo({
    super.key,
    required this.size,
    required this.name,
    required this.price,
  });

  final Size size;
  final String name;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: size.height * 0.05,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            alignment: Alignment.bottomCenter,
            color: Colors.white.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppText(
                    text: name,
                    fontWeight: FontWeight.w800,
                    textColor: Colors.black,
                    size: 14.sp,
                  ),
                ),
                SizedBox(
                  // width: size.width * 0.2,
                  child: AppText(
                    text: "₦${UsefulFunction.currencyConverter(price: price)}",
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                    size: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}