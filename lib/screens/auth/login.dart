import 'package:e_commerce/bloc/auth/auth_cubit.dart';
import 'package:e_commerce/bloc/product/products_cubit.dart';
import 'package:e_commerce/page%20route/page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../widget/app_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final readCubit = context.read<AuthCubit>();
    final watchCubit = context.watch<AuthCubit>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadedState) {
              Navigator.pushNamed(context, AppRoute.home);
              context.read<ProductsCubit>().getProduct(token: readCubit.token);
            }
          },
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.08),
                  BasketImg(size: size),
                  SizedBox(height: size.height * 0.03),
                  AppTextField(
                    size: size,
                    controller: watchCubit.emailController,
                    hintText: "Email",
                  ),
                  SizedBox(height: size.height * 0.02),
                  AppTextField(
                    size: size,
                    controller: watchCubit.passwordController,
                    hintText: "Password",
                  ),
                  SizedBox(height: size.height * 0.02),
                  AppButton(
                      size: size,
                      text: watchCubit.state is AuthLoadingState
                          ? "Please wait..."
                          : "Login",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          readCubit.login();
                        }
                      }),
                  SizedBox(height: size.height * 0.02),
                  // ask if user has not signed up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: "Don't have an account?",
                        size: 14.sp,
                        textColor: Colors.black,
                      ),
                      SizedBox(width: 2.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoute.register);
                        },
                        child: AppText(
                          text: "Sign Up",
                          size: 16,
                          textColor: Colors.blue.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
