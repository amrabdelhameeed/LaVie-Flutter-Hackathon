import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/app_web_services.dart';
import 'package:la_vie/model/user.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.webServices}) : super(ProfileInitial());
  final AppWebServices webServices;
  static ProfileCubit get(context) => BlocProvider.of(context);
  User? currentUser;
  getProfileData() async {
    await webServices.getProfiledata().then((response) {
      currentUser = User.fromJson(response.data);
      print(currentUser!.firstName);
      emit(ProfileSuccess(response.data['message']));
    }).catchError((onError) {
      emit(ProfileError(onError.toString()));
    });
  }

  Future<void> updateProfileData({
    required User currentUser,
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    await webServices
        .updateUser(
            currentUser: currentUser,
            email: email,
            firstName: firstName,
            lastName: lastName)
        .then((response) {
      emit(ProfileUpdatedSuccess(response.data['message']));
      getProfileData();
    }).catchError((onError) {
      print(onError.toString());
      emit(ProfileError(onError.toString()));
    });
  }
}
