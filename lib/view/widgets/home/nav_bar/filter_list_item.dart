import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../model/filter_model.dart';
import 'package:sizer/sizer.dart';

class FilterListItem extends StatelessWidget {
  const FilterListItem({
    Key? key,
    required this.filter,
  }) : super(key: key);

  final FilterModel filter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: filter.isSelected ? AppColors.primary : Colors.transparent,
          ),
          color: Colors.grey.shade100,
        ),
        child: Text(
          filter.filterName,
          style: TextStyle(
              fontSize: 15,
              color: filter.isSelected ? AppColors.primary : Colors.grey),
        ),
      ),
    );
  }
}
