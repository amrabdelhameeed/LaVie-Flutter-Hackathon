import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/app_colors.dart';
import 'package:la_vie/core/app_images.dart';
import 'package:la_vie/core/app_styles.dart';
import 'package:la_vie/core/widgets/custom-elevated_button.dart';
import 'package:la_vie/core/widgets/no_items_widget.dart';
import 'package:la_vie/view_model/cart_cubit/cart_cubit.dart';
import 'package:la_vie/view_model/home_cubit/home_cubit.dart';
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
                              return _space(2);
                            },
                            shrinkWrap: true,
                            itemCount: cubit.cart.length,
                            itemBuilder: (context, index) {
                              final cartItem = cubit.cart[index];
                              return Container(
                                margin: EdgeInsets.only(right: 1.w),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 4,
                                        offset: const Offset(
                                            4, 8), // Shadow position
                                      ),
                                    ],
                                    borderRadius: AppStyles.borderRadiusBig),
                                height: 19.h,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: EdgeInsets.all(2.h),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  cartItem.imageUrl),
                                              fit: BoxFit.cover),
                                          color: Colors.amber,
                                          borderRadius:
                                              AppStyles.borderRadiusBig,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: EdgeInsets.all(2.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              cartItem.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            _space(2),
                                            Text(
                                              '${cartItem.price} EGP',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                            _space(2),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        cubit
                                                            .addOrRemoveFromQuantity(
                                                                true, cartItem);
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey.shade200,
                                                            borderRadius: AppStyles
                                                                .borderRadiusSmall),
                                                        width: 5.w,
                                                        height: 6.w,
                                                        child: const Center(
                                                          child: Text(
                                                            '+',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade200,
                                                          borderRadius: AppStyles
                                                              .borderRadiusSmall),
                                                      width: 5.w,
                                                      height: 6.w,
                                                      child: Center(
                                                        child: Text(
                                                          cartItem.quantity
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cubit
                                                            .addOrRemoveFromQuantity(
                                                                false,
                                                                cartItem);
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey.shade200,
                                                            borderRadius: AppStyles
                                                                .borderRadiusSmall),
                                                        width: 5.w,
                                                        height: 6.w,
                                                        child: const Center(
                                                          child: const Text(
                                                            '-',
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                IconButton(
                                                    color: Colors.green,
                                                    onPressed: () {
                                                      cubit.deleteFromCart(
                                                          cartItem);
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
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
