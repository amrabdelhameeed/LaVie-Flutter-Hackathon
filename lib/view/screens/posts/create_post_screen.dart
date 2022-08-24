import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_styles.dart';
import '../../../core/widgets/custom-elevated_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../view_model/posts_cubit/posts_cubit.dart';
import 'package:sizer/sizer.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key}) : super(key: key);
  TextEditingController titleCont = TextEditingController();

  TextEditingController descriptionCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        var cubit = PostsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: const Text(
              'Create New Post',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _space(4),
                Center(
                  child: Container(
                    height: 28.w,
                    width: 28.w,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(
                        borderRadius: AppStyles.borderRadiusMideum,
                        border: Border.all(width: 1, color: Colors.green)),
                    child: cubit.postImage == null
                        ? GestureDetector(
                            onTap: () async {
                              await cubit.pickBookImage();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.add,
                                  size: 28,
                                  color: Colors.green,
                                ),
                                Text(
                                  'Add Photo',
                                  style: TextStyle(color: Colors.green),
                                )
                              ],
                            ),
                          )
                        : Image.file(File(cubit.postImage!.path)),
                  ),
                ),
                _titleWithTextField(
                    textEditingController: titleCont, title: 'Title'),
                _space(4),
                _titleWithTextField(
                    textEditingController: descriptionCont,
                    title: 'Description',
                    minLines: 8),
                _space(3),
                CustomElevatedButton(
                  text: 'Post',
                  onTap: () {
                    cubit.uploadPost(
                        image64: cubit.base64Image!,
                        title: titleCont.text,
                        description: descriptionCont.text);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Column _titleWithTextField(
      {required String title,
      required TextEditingController textEditingController,
      int? minLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey.shade600)),
        CustomTextFormField(
            controller: textEditingController,
            title: '',
            minLines: minLines ?? 1),
      ],
    );
  }

  SizedBox _space(int num) {
    return SizedBox(
      height: num.h,
    );
  }
}
