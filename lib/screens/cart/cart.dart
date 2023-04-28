import 'package:e_commerce/bloc/auth/auth_cubit.dart';
import 'package:e_commerce/bloc/product/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../widget/app_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final watchCubit = context.watch<ProductsCubit>().carts;
    final token = context.watch<AuthCubit>().token;
    return Scaffold(
      backgroundColor: Colors.amber.shade900,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(width: size.width * 0.03),
                    AppText(
                      text: "Carts",
                      fontWeight: FontWeight.bold,
                      textColor: Colors.white,
                      size: 14.sp,
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.width * 0.02),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () =>
                          context.read<ProductsCubit>().clearCart(token: token),
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 22.sp,
                      ),
                    )),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(size.width * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width * 0.15),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width * 0.15),
                  ),
                  child: ListView.builder(
                      itemCount: watchCubit.length + 1,
                      itemBuilder: (context, index) {
                        if ((index) == watchCubit.length) {
                          return Visibility(
                            visible: watchCubit.isNotEmpty,
                            child: AppButton(
                              size: size,
                              text: context.watch<ProductsCubit>().state
                                      is ProductsLoadingState
                                  ? "Please wait"
                                  : "Checkout",
                              bgColor: Colors.amber.shade900,
                              onTap: () => context
                                  .read<ProductsCubit>()
                                  .checkOut(token: token),
                            ),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.02),
                          child: Cart(
                            size: size,
                            quantity: watchCubit[index].quantity ?? 0,
                            delete: () => context
                                .read<ProductsCubit>()
                                .deleteCart(
                                    token: token, cart: watchCubit[index]),
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
