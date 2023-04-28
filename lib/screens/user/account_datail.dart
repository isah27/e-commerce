import 'package:e_commerce/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/auth/auth_cubit.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({super.key});

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  bool isUpdate = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final readCubit = context.read<AuthCubit>();
    final watchCubit = context.watch<AuthCubit>();
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: AppText(
                  text: watchCubit.error,
                  size: 4.sp,
                )));
          }
          if (state is AuthUpdateState) {
            setState(() {
              isUpdate = !isUpdate;
            });
            Navigator.pop(context);
          }
        },
        child: SafeArea(
            child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "assets/avatar.png",
                  height: size.width * 0.3,
                  width: size.width * 0.3,
                ),
                AppText(
                  text: "Profile Details",
                  textColor: Colors.black,
                  size: 18.sp,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(height: size.height * 0.03),
                AppTextField(
                    enable: isUpdate,
                    size: size,
                    hintText: "Username",
                    controller: watchCubit.usernameController),
                SizedBox(height: size.height * 0.03),
                AppTextField(
                    enable: isUpdate,
                    size: size,
                    hintText: "user@gmail.com",
                    controller: watchCubit.emailController),
                SizedBox(height: size.height * 0.03),
                AppButton(
                  size: size,
                  text: watchCubit.state is AuthLoadingState
                      ? "Please wait"
                      : isUpdate
                          ? "Save"
                          : "Update Info",
                  onTap: () {
                    if (!isUpdate) {
                      setState(() {
                        isUpdate = !isUpdate;
                      });
                    } else {
                      readCubit.updateUser();
                    }
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
