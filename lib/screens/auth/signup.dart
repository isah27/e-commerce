import 'package:e_commerce/page%20route/page_route.dart';
import 'package:e_commerce/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/auth/auth_cubit.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final readCubit = context.read<AuthCubit>();
    final watchCubit = context.watch<AuthCubit>();
    final size = MediaQuery.of(context).size;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadedState) {
          Navigator.pushNamed(context, AppRoute.login);
        }
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RegisterText(size: size),
                SizedBox(height: size.height * 0.05),
                AppTextField(
                  size: size,
                  controller: watchCubit.usernameController,
                  hintText: "Username",
                ),
                SizedBox(height: size.height * 0.02),
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
                AppText(
                  text: watchCubit.error,
                  textColor: Colors.red,
                  size: 12.sp,
                ),
                SizedBox(height: size.height * 0.02),
                // rigister button
                AppButton(
                    size: size,
                    text: watchCubit.state is AuthLoadingState
                        ? "Loading..."
                        : "Register",
                    bgColor: Colors.amber.shade900,
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        readCubit.register();
                      }
                    }),
                SizedBox(height: size.height * 0.02),
                // ask if user is registered
                // then click button to navigate to login page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: "Already have an account?",
                      size: 14.sp,
                      textColor: Colors.black,
                    ),
                    SizedBox(width: 2.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoute.login);
                      },
                      child: AppText(
                        text: "Login",
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
    );
  }
}
