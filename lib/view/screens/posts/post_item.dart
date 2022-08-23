import 'package:flutter/material.dart';
import 'package:la_vie/core/app_images.dart';
import 'package:la_vie/core/app_styles.dart';
import 'package:sizer/sizer.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: AppStyles.borderRadiusSmall,
          border: Border.all(width: 1, color: Colors.grey.shade300)),
      padding: EdgeInsets.all(2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(AppImages.google),
              ),
              _spaceHorizontal(2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amr Abd Elhamid',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('4 hours ago',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              )
            ],
          ),
          _space(2),
          Text('How To treat plants',
              style: TextStyle(
                  height: 1.3,
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          _space(1),
          Text('it beloajsndkjlasnbdlkasnmd;lasndlkasndlknasd aksdnlkasnd',
              maxLines: 3,
              style: TextStyle(
                height: 1.3,
                color: Colors.grey,
                fontSize: 15,
              )),
          _space(2),
          Container(
            width: 100.w,
            height: 15.h,
            decoration: BoxDecoration(
                color: Colors.amber,
                image: DecorationImage(image: AssetImage(AppImages.facebook))),
          ),
          _space(2),
          Container(
            width: 45.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_likeOrComment(true, 0), _likeOrComment(false, 2)],
            ),
          )
        ],
      ),
    );
  }
}

Widget _likeOrComment(bool isLike, int num) {
  return GestureDetector(
    onTap: () {
      if (isLike) {
      } else {}
    },
    child: Row(
      children: [
        isLike ? Icon(Icons.thumb_up_alt_outlined) : SizedBox.shrink(),
        _spaceHorizontal(1),
        Text(num.toString()),
        _spaceHorizontal(1),
        Text(isLike ? 'Likes' : 'Replies')
      ],
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
