part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PickImagePostSuccess extends PostsState {}

class PickImagePostError extends PostsState {}

class UploadPostSuccess extends PostsState {}

class UploadPostError extends PostsState {
  final String error;

  UploadPostError(this.error);
}
