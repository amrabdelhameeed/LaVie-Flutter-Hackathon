part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoggedInSuccess extends AuthState {
  final String message;

  LoggedInSuccess({required this.message});
}

class SignUpSuccess extends AuthState {
  final String message;

  SignUpSuccess({required this.message});
}

class AuthError extends AuthState {
  final String error;

  AuthError({required this.error});
}

class OTPSentSuccess extends AuthState {}

class VerifyOtpSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}
