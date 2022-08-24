import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/app_repository.dart';
import 'package:la_vie/core/app_web_services.dart';
import 'package:la_vie/model/filter_model.dart';
import 'package:la_vie/view/widgets/home/nav_bar/filter_listview.dart';
import 'package:la_vie/view_model/home_cubit/home_cubit.dart';
import '../../../core/app_images.dart';
import '../../../core/app_routes.dart';
import '../../../core/app_styles.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import 'post_item.dart';
import '../../../view_model/posts_cubit/posts_cubit.dart';
import 'package:sizer/sizer.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        var cubit = PostsCubit.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.createPost);
              },
              child: const Icon(Icons.add)),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: const Text(
              'Discussion Forms',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: BlocConsumer<PostsCubit, PostsState>(
            listener: (context, state) {
              if (state is UploadPostSuccess) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return cubit.postsResponse != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade200),
                                borderRadius: AppStyles.borderRadiusBig),
                            child: TextFormField(
                              decoration: AppStyles.inputDecorationMain,
                            ),
                          ),
                          _space(1),
                          SizedBox(
                            height: 9.h,
                            child: BlocProvider<HomeCubit>(
                              create: (context) => HomeCubit(
                                  appRepository:
                                      AppRepository(AppWebServices())),
                              child: FilterListView(
                                  filters: FilterModel.Postsfilters),
                            ),
                          ),
                          Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return PostItem(
                                      like: () {
                                        cubit.likeOrComment(
                                            true,
                                            cubit.postsResponse!.data![index]
                                                .forumId!);
                                      },
                                      comment: () {
                                        cubit.likeOrComment(
                                            false,
                                            cubit.postsResponse!.data![index]
                                                .forumId!);
                                      },
                                      post: cubit.postsResponse!.data![index],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return _space(2);
                                  },
                                  itemCount: cubit.postsResponse!.data!.length))
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        );
      },
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
