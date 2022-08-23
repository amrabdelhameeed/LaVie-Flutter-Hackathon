import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/app_colors.dart';
import 'package:la_vie/core/app_images.dart';
import 'package:la_vie/core/app_repository.dart';
import 'package:la_vie/core/app_routes.dart';
import 'package:la_vie/core/app_strings.dart';
import 'package:la_vie/core/app_styles.dart';
import 'package:la_vie/core/app_web_services.dart';
import 'package:la_vie/core/widgets/custom-elevated_button.dart';
import 'package:la_vie/model/blog.dart';
import 'package:la_vie/view_model/blogs_cubit/blogs_cubit.dart';
import 'package:sizer/sizer.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogCubit>.value(
      value: BlogCubit(repository: AppRepository(AppWebServices()))..getBlogs(),
      child: BlocBuilder<BlogCubit, BlogState>(
        builder: (context, state) {
          var cubit = BlogCubit.get(context);
          return cubit.blogs != null
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    centerTitle: true,
                    title: Text(
                      'Blogs',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  body: ListView.separated(
                      itemBuilder: (context, index) {
                        return BlogItem(
                          blog: cubit.blogs!.blogs[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 2.h,
                        );
                      },
                      itemCount: cubit.blogs!.blogs.length),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class BlogItem extends StatelessWidget {
  const BlogItem({Key? key, required this.blog}) : super(key: key);
  final Blog blog;
  SizedBox _space(int num) => SizedBox(
        height: num.h,
      );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.blog, arguments: blog);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Container(
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
                        color: Colors.amber,
                        borderRadius: AppStyles.borderRadiusBig,
                      ),
                      child: blog.imageUrl != ApiStrings.baseUrlForImage
                          ? FadeInImage(
                              fit: BoxFit.cover,
                              placeholder: const AssetImage(AppImages.logo),
                              image: NetworkImage(blog.imageUrl))
                          : FadeInImage(
                              placeholder: AssetImage(AppImages.logo),
                              image: AssetImage(AppImages.logo)),
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
                          const Text(
                            '2 days ago',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _space(2),
                          Text(
                            blog.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            blog.description,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey, height: 1.6),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
