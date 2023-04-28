import 'package:e_commerce/bloc/product/products_cubit.dart';
import 'package:e_commerce/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddToCartBtn extends StatelessWidget {
  const AddToCartBtn({
    super.key,
    required this.size,
    required this.onTap,
  });

  final Size size;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        // width: size.width * 0.4,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04, vertical: size.height * 0.01),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.width * 0.02)),
        child: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {
            if (state is ProductsLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: AppText(
                    text: "Added",
                    size: 14.sp,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const CircularProgressIndicator.adaptive();
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppText(
                  text: "Add to cart",
                  fontWeight: FontWeight.bold,
                  textColor: Colors.amber.shade900,
                  size: 14.sp,
                ),
                Icon(
                  Icons.add_shopping_cart_sharp,
                  color: Colors.amber.shade900,
                  size: 20.sp,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.name,
    required this.description,
    required this.price,
  });
  final String name;
  final String description;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppText(
              text: name,
              fontWeight: FontWeight.w800,
              textColor: Colors.white,
              size: 14.sp,
            ),
            AppText(
              text: "₦$price",
              fontWeight: FontWeight.bold,
              textColor: Colors.white,
              size: 14.sp,
            ),
          ],
        ),
        Divider(color: Colors.white.withOpacity(0.2)),
        AppText(
          text: description,
          fontWeight: FontWeight.bold,
          textColor: Colors.white,
          size: 14.sp,
        ),
      ],
    );
  }
}

class ImgContainer extends StatelessWidget {
  const ImgContainer({
    super.key,
    required this.size,
    required this.imgUrl,
  });

  final Size size;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.02),
          image: DecorationImage(image: AssetImage(imgUrl), fit: BoxFit.fill)),
    );
  }
}

class QuantityCounter extends StatelessWidget {
  const QuantityCounter({
    super.key,
    required this.size,
    required this.onIncrement,
    required this.onDecrement,
    required this.quantity,
  });

  final Size size;
  final Function() onIncrement;
  final Function() onDecrement;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.02)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: quantity > 1,
            child: InkWell(
              onTap: () => onDecrement(),
              child: Icon(
                Icons.remove,
                color: Colors.red,
                size: 28.sp,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            decoration: BoxDecoration(
              color: Colors.amber.shade900,
              borderRadius: BorderRadius.circular(size.width * 0.02),
            ),
            child: AppText(
              text: quantity.toString(),
              fontWeight: FontWeight.bold,
              textColor: Colors.white,
              size: 15.sp,
            ),
          ),
          InkWell(
            onTap: () => onIncrement(),
            child: Icon(
              Icons.add,
              color: Colors.blue.shade900,
              size: 28.sp,
            ),
          ),
        ],
      ),
    );
  }
}
