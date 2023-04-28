import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_button.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.desc,
    required this.onTap,
    this.del = false,
  });
  final String desc;
  final Function() onTap;
  final bool del;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AppText(
        text: desc,
        textColor: del == true ? Colors.red.shade700 : Colors.black,
        size: del == true ? 16.sp : 14.sp,
        fontWeight: FontWeight.w600,
      ),
      trailing: Visibility(
        visible: del != true,
        child: Icon(
          Icons.chevron_right_outlined,
          color: Colors.black.withOpacity(0.7),
          size: 25.sp,
        ),
      ),
      onTap: () => onTap(),
    );
  }
}
