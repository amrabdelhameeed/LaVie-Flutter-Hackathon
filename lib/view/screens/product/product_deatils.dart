import 'package:flutter/material.dart';
import 'package:la_vie/core/app_images.dart';
import 'package:la_vie/core/widgets/custom-elevated_button.dart';
import 'package:la_vie/model/product.dart';
import 'package:sizer/sizer.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _image(),
            Column(children: [
              _iconsWithDetails(),
              _restOfDescriptions(),
              _goToBlogButton()
            ])
          ],
        ),
      ),
    );
  }

  Container _image() {
    return Container(
      color: Colors.amber,
      child: Image.asset(
        product.imageUrl,
        width: 100.w,
        height: 50.h,
        // fit: BoxFit.fill,
      ),
    );
  }

  Widget _goToBlogButton() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.h),
        child: CustomElevatedButton(text: 'Go To Blog', onTap: () {}),
      );

  Expanded _restOfDescriptions() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    15,
                  ),
                  topRight: Radius.circular(15))),
          padding: EdgeInsets.all(3.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleWithDescription(
                  title: 'Snake Plant (SANSEVIEREA)',
                  desription:
                      'Plant Snake Plant Snake Plant Plant  Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant'),
              _titleWithDescription(
                  title: 'Common Snake Plant Diseases',
                  desription:
                      'Snake Plant  Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant Snake Plant '),
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleWithDescription(
      {required String title, required String desription}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, height: 2, fontSize: 22)),
        Text(
          desription,
          style: const TextStyle(
              fontWeight: FontWeight.w400, color: Colors.grey, height: 2),
        )
      ],
    );
  }

  Container _iconsWithDetails() {
    return Container(
      height: 40.h,
      width: 100.w,
      padding: EdgeInsets.only(left: 13.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconWithDetails(
              iconData: Icons.sunny, description: 'sun light', precent: '78'),
          _space(),
          _IconWithDetails(
              iconData: Icons.water_drop_rounded,
              description: 'water capicty',
              precent: '10'),
          _space(),
          _IconWithDetails(
              iconData: Icons.device_thermostat_sharp,
              description: 'tempreture',
              precent: '29'),
        ],
      ),
    );
  }

  SizedBox _space() {
    return SizedBox(
      height: 3.h,
    );
  }

  Row _IconWithDetails(
      {required IconData iconData,
      required String precent,
      required String description}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(iconData, size: 30),
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            Text('$precent%'),
            Text(description),
          ],
        )
      ],
    );
  }
}
