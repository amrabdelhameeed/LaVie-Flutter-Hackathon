import 'package:flutter/material.dart';
import 'package:la_vie/core/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      width: 100.w,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              fixedSize: Size.fromHeight(6.h),
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          )),
    );
  }
}
