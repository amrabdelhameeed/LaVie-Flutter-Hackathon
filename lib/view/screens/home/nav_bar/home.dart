import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/app_colors.dart';
import 'package:la_vie/core/app_images.dart';
import 'package:la_vie/core/app_routes.dart';
import 'package:la_vie/core/app_styles.dart';
import 'package:la_vie/core/widgets/appbar_with_logo.dart';
import 'package:la_vie/model/filter_model.dart';
import 'package:la_vie/model/product.dart';
import 'package:la_vie/view/widgets/home/nav_bar/filter_listview.dart';
import 'package:la_vie/view/widgets/home/nav_bar/products_item.dart';
import 'package:la_vie/view_model/home_cubit/home_cubit.dart';
import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWithLogo(appBarHeight: 10.h, imageLogo: AppImages.logo),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              _searchFieldWithIconButton(
                  formFieldOnTap: () {
                    Navigator.pushNamed(context, AppRoutes.search);
                  },
                  iconOnTap: () {
                    Navigator.pushNamed(context, AppRoutes.cart);
                  },
                  icon: Icons.shopping_cart),
              FilterListView(
                filters: FilterModel.filters,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _productsGridView(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _productsGridView() {
    List<Product> products = [];

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        if (state is GetProducts) {
          products = state.products;
        } else if (state is HomeFilterSelectedState) {
          if (state.filterName != 'ALL') {
            products = cubit.products
                .where((element) => element.type == cubit.currentFilter)
                .toList();
          } else {
            products = cubit.products;
          }
        }
        if (products.isEmpty) {
          products = cubit.products;
        }
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
}

Widget _searchFieldWithIconButton(
    {required VoidCallback iconOnTap,
    required IconData icon,
    required VoidCallback formFieldOnTap}) {
  return Row(
    children: [
      Expanded(
        flex: 5,
        child: GestureDetector(
          onTap: formFieldOnTap,
          child: SearchBar(
            textFormField: TextFormField(
              enabled: false,
              decoration: AppStyles.inputDecorationMain,
            ),
          ),
        ),
      ),
      SizedBox(
        width: 3.w,
      ),
      Expanded(
        flex: 1,
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7))),
              onPressed: iconOnTap,
              child: Icon(icon)),
        ),
      )
    ],
  );
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.textFormField}) : super(key: key);
  final TextFormField textFormField;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(7)),
      child: textFormField,
    );
  }
}
