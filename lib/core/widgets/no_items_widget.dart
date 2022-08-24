import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../app_images.dart';

class NoItems extends StatelessWidget {
  const NoItems({Key? key, required this.noItemsMessage}) : super(key: key);
  final String noItemsMessage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Center(
        child: Column(
          children: [
            Image.asset(AppImages.noItems),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Not Found',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Text(
              noItemsMessage,
              style: TextStyle(
                  fontSize: 17,
                  height: 1.7,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
