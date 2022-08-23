import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie/core/app_web_services.dart';
part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({required this.webServices}) : super(PostsInitial());
  final AppWebServices webServices;
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
        print(error);
        emit(UploadPostError(error));
      });
    }
  }
}
