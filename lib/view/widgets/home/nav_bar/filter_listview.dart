import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/model/filter_model.dart';
import 'package:la_vie/view/widgets/home/nav_bar/filter_list_item.dart';
import 'package:la_vie/view_model/home_cubit/home_cubit.dart';
import 'package:sizer/sizer.dart';

class FilterListView extends StatelessWidget {
  const FilterListView({
    Key? key,
    required this.filters,
  }) : super(key: key);
  final List<FilterModel> filters;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return SizedBox(
          height: 8.h,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 4.w,
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  cubit.selectFilterAndGetItsList(filters[index], filters);
                },
                child: FilterListItem(filter: filters[index]),
              );
            },
          ),
        );
      },
    );
  }
}
