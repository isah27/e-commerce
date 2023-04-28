import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../app_widget.dart';

class UserInfoBanner extends StatelessWidget {
  const UserInfoBanner({
    super.key,
    required this.size,
    required this.username,
    required this.email,
  });

  final Size size;
  final String username;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/avatar.png',
          height: size.width * 0.2,
          width: size.width * 0.2,
        ),
        SizedBox(width: size.width * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: username,
              size: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              text: email,
              size: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }
}