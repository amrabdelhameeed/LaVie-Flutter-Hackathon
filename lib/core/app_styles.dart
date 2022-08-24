import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  AppStyles._();
  static final inputDecorationMain = InputDecoration(
      hintText: 'Search',
      prefixIcon: const Icon(Icons.search),
      focusedBorder:
          OutlineInputBorder(borderRadius: AppStyles.borderRadiusBig),
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      border: InputBorder.none,
      fillColor: AppColors.grey.withOpacity(0.1),
      filled: true);
  static final boxShadow = BoxShadow(
    color: Colors.grey.shade300,
    blurRadius: 4,
    offset: const Offset(4, 8),
  );
  static final borderRadiusSmall = BorderRadius.circular(6);
  static final borderRadiusBig = BorderRadius.circular(12);
  static final borderRadiusMideum = BorderRadius.circular(9);
}
