import 'package:e_commerce/bloc/auth/auth_cubit.dart';
import 'package:e_commerce/bloc/product/products_cubit.dart';
import 'package:e_commerce/uitils/usefull_function.dart';
import 'package:e_commerce/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final watchCubit = context.watch<ProductsCubit>();
    final readCubit = context.read<ProductsCubit>();
    return Scaffold(
      backgroundColor: Colors.amber.shade900,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: 28.sp,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Expanded(
                child: ImgContainer(imgUrl: "assets/iphones.jpg", size: size),
              ),
              ProductInfo(
                name: watchCubit.product.name ?? "",
                price: UsefulFunction.currencyConverter(
                    price: watchCubit.product.price),
                description: watchCubit.product.description ?? "",
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // quantity counter
                  QuantityCounter(
                    size: size,
                    quantity: watchCubit.productQuantity,
                    onIncrement: () => readCubit.increment(),
                    onDecrement: () => readCubit.decrement(),
                  ),

                  // add to cart button
                  AddToCartBtn(
                    onTap: () {
                      readCubit.addCart(token: context.read<AuthCubit>().token);
                      readCubit.getCart(token: context.read<AuthCubit>().token);
                    },
                    size: size,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02)
            ],
          ),
        ),
      ),
    );
  }
}
