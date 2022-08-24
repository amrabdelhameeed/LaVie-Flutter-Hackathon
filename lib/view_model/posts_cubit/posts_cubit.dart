import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie/core/widgets/api_strings.dart';
import '../../core/app_repository.dart';
import '../../core/app_strings.dart';
import '../../core/app_web_services.dart';
import '../../model/post_model.dart';
part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({required this.webServices, required this.repository})
      : super(PostsInitial());
  final AppWebServices webServices;
  final AppRepository repository;
  static PostsCubit get(context) => BlocProvider.of(context);
  final ImagePicker _picker = ImagePicker();
  XFile? postImage;
  String? base64Image;
  Future pickBookImage() async {
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      postImage = XFile(value!.path);
      final bytes = File(postImage!.path).readAsBytesSync();
      base64Image = base64Encode(bytes);
      print(base64Image);
      emit(PickImagePostSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(PickImagePostError());
    });
  }

  uploadPost(
      {required String image64,
      required String title,
      required String description}) async {
    if (base64Image != null) {
      await webServices
          .uploadPost(image64: image64, title: title, description: description)
          .then((value) {
        emit(UploadPostSuccess());
      }).catchError((error) {
        if (error is DioError) {
          print(error.response);
        }
        emit(UploadPostError(error));
      });
    }
  }

  PostsResponse? postsResponse;
  getAllPosts() async {
    await repository.getAllPosts().then((value) {
      postsResponse = value;
      print(value.data);
      emit(PostsGetSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(PostsError(onError.toString()));
    });
  }

  PostsResponse? myPostsResponse;
  getMyPosts() async {
    await repository.getMyPosts().then((value) {
      myPostsResponse = value;
      print(value.data);
      emit(PostsGetSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(PostsError(onError.toString()));
    });
  }

  likeOrComment(bool isLike, String forumId) async {
    print('${ApiStrings.forums}/${forumId}/${isLike ? 'like' : 'comment'}');
    await webServices.likeOrComment(isLike, forumId).then((value) {
      print(value.data);
      emit(LikeOrCommentSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(LikeOrCommentError(onError.toString()));
    });
  }
}
