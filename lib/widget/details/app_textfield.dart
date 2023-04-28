import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    Key? key,
    required this.size,
    this.hintText = "Task Name",
    this.maxLine = 1,
    this.borderRadius = 0,
    this.enable = true,
    required this.controller,
  }) : super(key: key);

  final Size size;
  final String hintText;
  final int maxLine;
  final double borderRadius;
  final TextEditingController controller;
  final bool enable;
  late final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(
        borderRadius == 0 ? size.width * 0.02 : borderRadius,
      ));
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.9,
      child: TextFormField(
        enabled: enable,
        controller: controller,
        validator: (value) {
          if (value == "") {
            return "This is a required field";
          }
          return null;
        },
        style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp),
        maxLines: maxLine,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: hintText,
          focusedBorder: border,
          enabledBorder: border,
        ),
      ),
    );
  }
}
