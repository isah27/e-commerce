import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_button.dart';

class RegisterText extends StatelessWidget {
  const RegisterText({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppText(
              text: "Register",
              textColor: Colors.black87,
              fontWeight: FontWeight.bold,
              size: 30.sp,
            ),
            AppText(
              text: "Create new account",
              textColor: Colors.amber.shade900,
              size: 12.sp,
            ),
          ],
        ),
      ),
    );
  }
}