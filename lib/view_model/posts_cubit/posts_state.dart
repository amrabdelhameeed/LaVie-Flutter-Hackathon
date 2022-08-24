part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsGetSuccess extends PostsState {}

class PostsError extends PostsState {
  final String error;

  PostsError(this.error);
}

class PickImagePostSuccess extends PostsState {}

class PickImagePostError extends PostsState {}

class UploadPostSuccess extends PostsState {}

class UploadPostError extends PostsState {
  final String error;

  UploadPostError(this.error);
}

class LikeOrCommentSuccess extends PostsState {}

class LikeOrCommentError extends PostsState {
  final String error;

  LikeOrCommentError(this.error);
}
