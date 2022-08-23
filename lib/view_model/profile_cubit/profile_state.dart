part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}

class ProfileSuccess extends ProfileState {
  final String message;

  ProfileSuccess(this.message);
}

class ProfileUpdatedSuccess extends ProfileState {
  final String message;

  ProfileUpdatedSuccess(this.message);
}
