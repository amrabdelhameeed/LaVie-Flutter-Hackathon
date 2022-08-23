import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:la_vie/core/app_images.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 15,
          itemBuilder: (context, index) {
            return _notificationItem();
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 2.h,
            );
          },
        ),
      ),
    );
  }

  Column _notificationItem() {
    return Column(
      children: [
        Container(
          height: 8.h,
          width: 100.w,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(AppImages.google),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Joe Amold Left 6 Comments on Your Post',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    'Yetsertday at 11:42 pm',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          height: 2,
          color: Colors.grey.shade300,
          width: 100.w,
        )
      ],
    );
  }
}
