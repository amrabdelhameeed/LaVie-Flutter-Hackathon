import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:la_vie/core/widgets/api_strings.dart';
import 'app_strings.dart';
import 'dio_helper.dart';
import '../model/user.dart';

class AppWebServices {
  //////////////////// Auth /////////////////
  Future<Response> signIn({
    required String email,
    required String password,
  }) async {
    return await DioHelper.postData(
        url: ApiStrings.login, data: {'email': email, 'password': password});
  }

  Future<Response> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    return await DioHelper.postData(url: ApiStrings.signUp, data: {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  Future<Response> forgetPassword({required String email}) async {
    return await DioHelper.postData(
        url: ApiStrings.forgetPassword, data: {'email': email});
  }

  // Future<GoogleSignInAuthentication?> googleSignIn() async {
  //   try {
  //     await GoogleSignIn().signIn().then((value) async {
  //       print(value!.email);
  //       return await value.authentication;
  //     });
  //   } catch (error) {
  //     print(error);
  //   }
  //   return null;
  // }

  Future<Response> verfiyOTP(
      {required String email, required String otp}) async {
    return await DioHelper.postData(
        url: ApiStrings.verifyOtp, data: {'email': email, 'otp': otp});
  }

  Future<Response> resetPassword({
    required String email,
    required String otp,
    required String newPasword,
  }) async {
    return await DioHelper.postData(
        url: ApiStrings.resetPassword,
        data: {'email': email, 'otp': otp, 'password': newPasword});
  }
  // Future<GoogleSignInAuthentication?> googleSignIn() async {
  //   try {
  //     await GoogleSignIn().signIn().then((value) async {
  //       print(value!.email);
  //       return await value.authentication;
  //     });
  //   } catch (error) {
  //     print(error);
  //   }
  //   return null;
  // }
  //////////////////// Home /////////////////

  Future<Response> getAllProducts() async {
    return await DioHelper.getData(
        url: ApiStrings.products, token: AppStrings.token);
  }

  Future<Response> getAllBlogs() async {
    return await DioHelper.getData(
        url: ApiStrings.blogs, token: AppStrings.token);
  }

  ///////// profile
  Future<Response> getProfiledata() async {
    return await DioHelper.getData(
        url: ApiStrings.profile, token: AppStrings.token);
  }

  Future<Response> updateUser({
    required User currentUser,
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    return await DioHelper.patchData(url: ApiStrings.profile, data: {
      "firstName": firstName ?? currentUser.firstName,
      "lastName": lastName ?? currentUser.lastName,
      "email": email ?? currentUser.email,
      "address": 'cairo'
    });
  }

  //////////// posts
  Future<Response> uploadPost(
      {required String image64,
      required String title,
      required String description}) async {
    print('data:image/png;base64,$image64');
    return await DioHelper.postData(url: ApiStrings.forums, data: {
      "title": title,
      "description": description,
      "imageBase64": 'data:image/png;base64,$image64'
    });
  }

  Future<Response> getAllPosts() async {
    return await DioHelper.getData(
        url: ApiStrings.forums, token: AppStrings.token);
  }

  Future<Response> getMyPosts() async {
    return await DioHelper.getData(
        url: ApiStrings.forumsMe, token: AppStrings.token);
  }

  Future<Response> likeOrComment(bool isLike, String forumId) async {
    print('${ApiStrings.forums}/${forumId}/${isLike ? 'like' : 'comment'}');
    return await DioHelper.postData(
      data: {},
      url: '${ApiStrings.forums}/${forumId}/${isLike ? 'like' : 'comment'}',
    );
  }
}
