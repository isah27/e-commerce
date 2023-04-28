import 'package:badges/badges.dart' as badge;
import 'package:e_commerce/bloc/product/products_cubit.dart';
import 'package:e_commerce/page%20route/detail/route.dart';
import 'package:e_commerce/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoute.cart),
      child: badge.Badge(
        badgeContent: Text(
          context.watch<ProductsCubit>().carts.length.toString(),
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp),
        ),
        position: const badge.BadgePosition(start: 30, bottom: 30),
        child: IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoute.cart),
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 25.sp,
          ),
        ),
      ),
    );
  }
}

class Cart extends StatelessWidget {
  const Cart({
    super.key,
    required this.size,
    required this.delete,
    required this.quantity,
  });

  final Size size;
  final Function() delete;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: size.height * 0.25,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.02),
        image: const DecorationImage(
            image: AssetImage("assets/iphones.jpg"), fit: BoxFit.fill),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        color: Colors.white.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02, vertical: size.height * 0.01),
              decoration: BoxDecoration(
                color: Colors.amber.shade900,
                borderRadius: BorderRadius.circular(size.width * 0.02),
              ),
              child: AppText(
                text: "Quantity: $quantity",
                fontWeight: FontWeight.bold,
                textColor: Colors.white,
                size: 15.sp,
              ),
            ),
            InkWell(
              onTap: () => delete(),
              child:
                  context.watch<ProductsCubit>().state is ProductsLoadingState
                      ? const CircularProgressIndicator.adaptive()
                      : Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 35.sp,
                        ),
            )
          ],
        ),
      ),
    );
  }
}
