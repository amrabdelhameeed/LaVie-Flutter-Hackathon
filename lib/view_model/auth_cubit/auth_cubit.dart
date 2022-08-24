import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/app_strings.dart';
import '../../core/app_web_services.dart';
import '../../core/cashe_helper.dart';
import '../../core/dio_helper.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.webServices}) : super(AuthInitial());
  final AppWebServices webServices;
  static AuthCubit get(context) => BlocProvider.of(context);
  bool _isResponseSuccess(String type) {
    if (type == 'Success') {
      return true;
    }
    return false;
  }

  _saveToCashe(Response response) {
    AppStrings.token = response.data['data']["accessToken"];

    CasheHelper.setStr(key: AppStrings.tokenKey, text: AppStrings.token!);
  }

  login({
    required String email,
    required String password,
  }) async {
    await webServices.signIn(email: email, password: password).then((value) {
      print(value);
      if (_isResponseSuccess(value.data['type'])) {
        _saveToCashe(value);
        emit(LoggedInSuccess(message: value.data["message"]));
      }
    }).catchError((onError) {
      if (onError is DioError) {
        print(onError.toString());
      }
      emit(AuthError(error: onError.toString()));
    });
  }

  signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    await webServices
        .signUp(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName)
        .then((value) {
      print(value);
      if (_isResponseSuccess(value.data['type'])) {
        _saveToCashe(value);
        emit(SignUpSuccess(message: value.data["message"]));
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(AuthError(error: onError.toString()));
    });
  }

  // googleSignIn() async {
  //   await webServices.googleSignIn().then((value) {
  //     // print(value!.idToken);
  //   });
  // }

  forgetPassword({required String email}) async {
    return await webServices.forgetPassword(email: email).then((value) {
      if (value.data['type'] == 'Success') {
        emit(OTPSentSuccess());
      }
    }).catchError((onError) {
      if (onError is DioError) {
        emit(AuthError(error: onError.response.toString()));
        print(onError.response);
      }
    });
  }

  submitOtp({required String otp, required String email}) async {
    await webServices.verfiyOTP(email: email, otp: otp).then((value) {
      if (value.data['type'] == 'Success') {
        emit(VerifyOtpSuccess());
      }
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
        emit(AuthError(error: error.response.toString()));
      }
    });
  }

  resetPassword(
      {required String otp,
      required String email,
      required String newPassword}) async {
    await webServices
        .resetPassword(email: email, otp: otp, newPasword: newPassword)
        .then((value) {
      if (value.data['type'] == 'Success') {
        emit(ResetPasswordSuccess());
      }
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
        emit(AuthError(error: error.response.toString()));
      }
    });
  }
}
