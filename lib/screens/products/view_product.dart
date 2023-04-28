import 'package:e_commerce/page%20route/detail/route.dart';
import 'package:e_commerce/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/product/products_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final watchCubit = context.watch<ProductsCubit>().products;
    final readCubit = context.read<ProductsCubit>();
    return Scaffold(
      body: Container(
        color: Colors.amber.shade900,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoute.userProfile);
                        context.read<AuthCubit>().getUser();
                      },
                      child: Image.asset(
                        "assets/avatar.png",
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                      ),
                    ),
                    const CartButton()
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: (Colors.white),
                      ),
                    );
                  }
                  return Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(size.width * 0.06),
                          topRight: Radius.circular(size.width * 0.06),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(size.width * 0.06),
                          topRight: Radius.circular(size.width * 0.06),
                        ),
                        child: ListView.builder(
                            itemCount: watchCubit.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoute.detailProduct);
                                  readCubit.goToDetail(prod: watchCubit[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.01,
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: size.height * 0.02),
                                  height: size.height * 0.4,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    // color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                      image: AssetImage("assets/iphones.jpg"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: HomeProductInfo(
                                    size: size,
                                    name: watchCubit[index].name ?? "",
                                    price: double.parse(
                                        watchCubit[index].price.toString()),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
