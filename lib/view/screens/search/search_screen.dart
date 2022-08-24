// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/app_strings.dart';
import 'package:la_vie/core/app_styles.dart';
import 'package:la_vie/core/cashe_helper.dart';
import 'package:la_vie/core/widgets/no_items_widget.dart';
import 'package:la_vie/model/product.dart';
import 'package:la_vie/view/screens/home/home.dart';
import 'package:la_vie/view/widgets/home/nav_bar/products_item.dart';
import 'package:la_vie/view_model/home_cubit/home_cubit.dart';
import 'package:la_vie/view_model/search_cubit/search_cubit.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var searchCubit = SearchCubit.get(context);
          return BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              var homeCubit = HomeCubit.get(context);
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _space(),
                        _searchBar(textEditingController, searchCubit),
                        searchCubit.isSearching
                            ? Column(
                                children: [
                                  _space(),
                                  _recentSearch(),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: AppStrings.searchList!.length,
                                    itemBuilder: (context, index) {
                                      return _historyItem(index, searchCubit);
                                    },
                                  )
                                ],
                              )
                            : (homeCubit.products
                                        .where((e) => e.name
                                            .toLowerCase()
                                            .contains(
                                                textEditingController.text))
                                        .toList()
                                        .isNotEmpty &&
                                    textEditingController.text.isNotEmpty
                                ? _productsGridView(
                                    homeCubit.products
                                        .where((e) => e.name
                                            .toLowerCase()
                                            .contains(
                                                textEditingController.text))
                                        .toList(),
                                    homeCubit)
                                : const NoItems(
                                    noItemsMessage: 'enter a valid name'))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Padding _historyItem(int index, SearchCubit cubit) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.history_toggle_off_sharp, color: Colors.grey),
              _verticalSpace(),
              Text(
                AppStrings.searchList![index],
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
          IconButton(
              onPressed: () {
                cubit.deleteSearchItem(
                    list: AppStrings.searchList!, index: index);
                CasheHelper.setList(
                    value: AppStrings.searchList!,
                    key: AppStrings.searchListKey);
              },
              icon: const Icon(Icons.delete, color: Colors.grey))
        ],
      ),
    );
  }

  SizedBox _verticalSpace() => SizedBox(
        width: 2.w,
      );

  Padding _recentSearch() {
    return Padding(
      padding: EdgeInsets.only(left: 3.w),
      child: const Text(
        'Recent Searches',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  SizedBox _space() {
    return SizedBox(
      height: 3.h,
    );
  }

  Widget _searchBar(
      TextEditingController textEditingController, SearchCubit cubit) {
    return SearchBar(
        textFormField: TextFormField(
      onFieldSubmitted: (value) {
        cubit.toggleSearch(false);
        AppStrings.searchList!.add(value);
        CasheHelper.setList(
            value: AppStrings.searchList!, key: AppStrings.searchListKey);
      },
      onSaved: (newValue) {
        AppStrings.searchList!.add(newValue!);

        CasheHelper.setList(
            value: AppStrings.searchList!, key: AppStrings.searchListKey);
      },
      onTap: () {
        cubit.toggleSearch(true);
      },
      controller: textEditingController,
      decoration: AppStyles.inputDecorationMain,
    ));
  }
}

Widget _productsGridView(List<Product> products, HomeCubit cubit) {
  return BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) {
      return Wrap(
        children: [
          for (var i = 0; i < products.length; i++)
            ProductItem(
              cubit: cubit,
              product: products[i],
            )
        ],
      );
    },
  );
}
