import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/app_repository.dart';
import '../../core/app_web_services.dart';
import '../../model/blog.dart';
part 'blogs_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit({required this.repository}) : super(BlogInitial());
  static BlogCubit get(context) => BlocProvider.of(context);
  final AppRepository repository;
  Blogs? blogs;
  getBlogs() async {
    repository.getAllBlogs().then((blogs) {
      this.blogs = blogs;
      print(blogs);
      emit(GetBlogs(blogs));
    }).catchError((onError) {
      print(onError.toString());
      emit(GetBlogsError(onError.toString()));
    });
  }
}
