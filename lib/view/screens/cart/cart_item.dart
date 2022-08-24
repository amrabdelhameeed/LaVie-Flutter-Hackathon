import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../core/app_styles.dart';
import '../../../model/product.dart';
import '../../../view_model/home_cubit/home_cubit.dart';
import 'package:sizer/sizer.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.product, required this.cubit})
      : super(key: key);
  final Product product;
  final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(4, 8), // Shadow position
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
                    image: NetworkImage(product.imageUrl), fit: BoxFit.cover),
                color: Colors.amber,
                borderRadius: AppStyles.borderRadiusBig,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _space(2),
                  Text(
                    '${product.price} EGP',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  _space(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.addOrRemoveFromQuantity(true, product);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: AppStyles.borderRadiusSmall),
                              width: 5.w,
                              height: 6.w,
                              child: const Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: AppStyles.borderRadiusSmall),
                            width: 5.w,
                            height: 6.w,
                            child: Center(
                              child: Text(
                                product.quantity.toString(),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cubit.addOrRemoveFromQuantity(false, product);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: AppStyles.borderRadiusSmall),
                              width: 5.w,
                              height: 6.w,
                              child: const Center(
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.green),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      IconButton(
                          color: Colors.green,
                          onPressed: () {
                            cubit.deleteFromCart(product);
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox _space(int num) => SizedBox(
        height: num.h,
      );
}
