import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:la_vie/core/app_images.dart';
import 'package:la_vie/core/app_styles.dart';
import 'package:la_vie/core/widgets/custom_text_form_field.dart';
import 'package:la_vie/view/screens/posts/post_item.dart';
import 'package:sizer/sizer.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Discussion Forms',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade200),
                  borderRadius: AppStyles.borderRadiusBig),
              child: TextFormField(
                decoration: AppStyles.inputDecorationMain,
              ),
            ),
            _space(1),
            Container(
              height: 3.h,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Text('data'),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return _spaceHorizontal(2);
                  },
                  itemCount: 2),
            ),
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return PostItem();
                    },
                    separatorBuilder: (context, index) {
                      return _space(2);
                    },
                    itemCount: 5))
          ],
        ),
      ),
    );
  }

  SizedBox _space(int num) {
    return SizedBox(
      height: num.h,
    );
  }

  SizedBox _spaceHorizontal(int num) {
    return SizedBox(
      width: num.w,
    );
  }
}
