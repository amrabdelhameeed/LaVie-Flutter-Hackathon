import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/custom-elevated_button.dart';
import '../../../core/widgets/no_items_widget.dart';
import 'cart_item.dart';
import '../../../view_model/home_cubit/home_cubit.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _appBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: cubit.cart.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                          flex: 4,
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return _space(1);
                            },
                            shrinkWrap: true,
                            itemCount: cubit.cart.length,
                            itemBuilder: (context, index) {
                              final cartItem = cubit.cart[index];
                              return CartItem(product: cartItem, cubit: cubit);
                            },
                          )),
                      _space(3),
                      _totalAndCheckOutButton(cubit),
                    ],
                  )
                : const NoItems(noItemsMessage: 'No items In Cart'),
          );
        },
      ),
    ));
  }

  SizedBox _space(int num) => SizedBox(
        height: num.h,
      );

  AppBar _appBar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: const TextStyle(color: Colors.black),
        ));
  }

  Expanded _totalAndCheckOutButton(HomeCubit cubit) {
    return Expanded(
        child: Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.normal)),
              Text(
                '${cubit.getTotalprice().toString()} Egp',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          CustomElevatedButton(
            text: 'CheckOut',
            onTap: () {},
          )
        ],
      ),
    ));
  }
}
