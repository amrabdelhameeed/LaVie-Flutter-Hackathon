import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_images.dart';

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
              height: 1.5.h,
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
          height: 7.h,
          width: 100.w,
          margin: EdgeInsets.all(2),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  backgroundImage: AssetImage(AppImages.google),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Joe Amold Left 6 Comments on Your Post',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Spacer(),
                    Text(
                      'Yetsertday at 11:42 pm',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
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
