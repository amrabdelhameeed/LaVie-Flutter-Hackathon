part of 'blogs_cubit.dart';

@immutable
abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogAdd extends BlogState {}

class BlogRemove extends BlogState {}

class GetBlogs extends BlogState {
  final Blogs blogs;
  GetBlogs(this.blogs);
}

class GetBlogsError extends BlogState {
  final String error;
  GetBlogsError(this.error);
}
