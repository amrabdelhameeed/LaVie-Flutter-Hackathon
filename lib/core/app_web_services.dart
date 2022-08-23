import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:la_vie/core/app_strings.dart';
import 'package:la_vie/core/dio_helper.dart';
import 'package:la_vie/model/user.dart';

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

  Future<GoogleSignInAuthentication?> googleSignIn() async {
    try {
      await GoogleSignIn().signIn().then((value) async {
        print(value!.email);
        return await value.authentication;
      });
    } catch (error) {
      print(error);
    }
    return null;
  }

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
      "address": 'sakdaskldmaslmd'
    });
  }

  //////////// posts
  Future<Response> uploadPost(
      {required String image64,
      required String title,
      required String description}) async {
    return await DioHelper.postData(url: ApiStrings.forums, data: {
      "title": title,
      "description": description,
      "imageBase64": 'data:image/jpeg;base64,$image64'
    });
  }
}
