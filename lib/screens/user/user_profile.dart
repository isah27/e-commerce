import 'package:e_commerce/page%20route/page_route.dart';
import 'package:e_commerce/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_cubit.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final readCubit = context.read<AuthCubit>();
    final watchCubit = context.watch<AuthCubit>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.amber.shade900],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              UserInfoBanner(
                size: size,
                username: watchCubit.user.name ?? "",
                email: watchCubit.user.email ?? "",
              ),
              SizedBox(height: size.height * 0.02),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.02),
                      CustomListTile(
                        desc: "Orders",
                        onTap: () {},
                      ),
                      const Divider(),
                      CustomListTile(
                        desc: "Cart",
                        onTap: () {},
                      ),
                      const Divider(),
                      CustomListTile(
                        desc: "Inbox",
                        onTap: () {},
                      ),
                      const Divider(),
                      CustomListTile(
                        desc: "Account Management",
                        onTap: () {
                          readCubit.goToDetails();
                          Navigator.pushNamed(context, AppRoute.accountDetail);
                        },
                      ),
                      const Divider(),
                      CustomListTile(
                        del: true,
                        desc: "Close account",
                        onTap: () {},
                      ),
                      // const Divider(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
