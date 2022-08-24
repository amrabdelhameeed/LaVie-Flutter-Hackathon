import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:la_vie/core/widgets/api_strings.dart';
import '../../../core/app_images.dart';
import '../../../core/app_strings.dart';
import '../../../model/blog.dart';
import 'package:sizer/sizer.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key, required this.blog}) : super(key: key);
  final Blog blog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: blog.imageUrl != ApiStrings.baseUrlForImage
                  ? Hero(
                      tag: blog.imageUrl + blog.description + blog.name,
                      child: FadeInImage(
                          width: double.infinity,
                          placeholder: AssetImage(AppImages.logo),
                          image: NetworkImage(
                            blog.imageUrl,
                          )),
                    )
                  : Hero(
                      tag: blog.imageUrl + blog.description + blog.name,
                      child: Image.asset(
                        AppImages.logo,
                        fit: BoxFit.cover,
                      ),
                    )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.name,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      blog.description,
                      style: TextStyle(
                          fontSize: 17, color: Colors.grey, height: 1.8),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
