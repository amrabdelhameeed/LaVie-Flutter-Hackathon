import 'package:flutter/material.dart';
import '../../../core/app_images.dart';
import '../../../core/app_styles.dart';
import '../../../model/post_model.dart';
import 'package:sizer/sizer.dart';

class PostItem extends StatelessWidget {
  const PostItem(
      {Key? key, required this.post, required this.like, required this.comment})
      : super(key: key);
  final Post post;
  final VoidCallback like;
  final VoidCallback comment;

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
              const CircleAvatar(
                backgroundImage: const AssetImage(AppImages.google),
              ),
              _spaceHorizontal(2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    post.user!.firstName! + post.user!.lastName!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('4 hours ago',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              )
            ],
          ),
          _space(2),
          Text(post.title!,
              style: const TextStyle(
                  height: 1.3,
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          _space(1),
          Text(post.description!,
              maxLines: 3,
              style: const TextStyle(
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
                image: DecorationImage(image: NetworkImage(post.imageUrl!))),
          ),
          _space(2),
          Container(
            width: 45.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _likeOrComment(true, post.forumLikes!, like),
                _likeOrComment(
                  false,
                  post.forumComments!.length,
                  comment,
                )
              ],
            ),
          ),
          post.forumComments != null && post.forumComments!.isNotEmpty
              ? _comment()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Container _comment() {
    return Container(
        width: 100.w,
        height: 8.h,
        padding: EdgeInsets.only(top: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(post.forumComments!.first.comment ?? ''),
            Text(
              post.forumComments!.first.createdAt!.substring(0, 15),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey),
            )
          ],
        ));
  }
}

Widget _likeOrComment(bool isLike, int num, VoidCallback likeOrComment) {
  return GestureDetector(
    onTap: () async {
      if (isLike) {
        likeOrComment();
      } else {
        likeOrComment();
      }
    },
    child: Row(
      children: [
        isLike
            ? const Icon(Icons.thumb_up_alt_outlined)
            : const SizedBox.shrink(),
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
