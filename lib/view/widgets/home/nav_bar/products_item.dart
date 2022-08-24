import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_images.dart';
import '../../../../core/widgets/custom-elevated_button.dart';
import '../../../../model/product.dart';
import '../../../../view_model/home_cubit/home_cubit.dart';
import 'package:sizer/sizer.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, required this.product, required this.cubit})
      : super(key: key);
  final Product product;
  final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.w,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            margin: EdgeInsets.only(top: 10.h),
            decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(13)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cubit.addOrRemoveFromQuantity(false, product);
                      },
                      child: Center(
                        child: Container(
                          alignment: Alignment.topCenter,
                          width: 8.w,
                          height: 3.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          ),
                          child: const Text(
                            '-',
                            style:
                                TextStyle(color: AppColors.grey, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: Text(
                        product.quantity.toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(color: Colors.black, fontSize: 23),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cubit.addOrRemoveFromQuantity(true, product);
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: 8.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                        child: const Text(
                          '+',
                          style: const TextStyle(
                              color: AppColors.grey, fontSize: 23),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Container(
                    alignment: Alignment.centerLeft, child: Text(product.name)),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${product.price}EGP',
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    )),
                Container(
                  child: CustomElevatedButton(
                    text: 'Add To Cart',
                    onTap: () {
                      cubit.addToCart(product);
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: 1.w,
              top: 6.h,
              child: Image.network(
                product.imageUrl,
                width: 20.w,
                height: 20.w,
              )),
        ],
      ),
    );
  }
}
