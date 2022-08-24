import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_routes.dart';
import '../../../core/app_strings.dart';
import '../../../core/app_styles.dart';
import '../../../core/app_web_services.dart';
import '../../../core/cashe_helper.dart';
import '../../../model/user.dart';
import '../../../view_model/profile_cubit/profile_cubit.dart';
import 'package:sizer/sizer.dart';

ProfileCubit profileCubit = ProfileCubit(webServices: AppWebServices());

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>.value(
      value: profileCubit..getProfileData(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          var currentUser = cubit.currentUser;
          return currentUser != null
              ? Scaffold(
                  body: Stack(
                  children: [
                    _image(currentUser),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: 100.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: AppStyles.borderRadiusBig,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      height: 10.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius: AppStyles.borderRadiusBig,
                                        color: Colors.green.shade100,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.stars_rounded),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              'You have ${currentUser.uerPoints} points')
                                        ],
                                      ),
                                    ),
                                    const Text('Edit Profile',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    _space(3),
                                    _editDataCard(
                                      title: 'Change Name',
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            debugPrint(currentUser.email);
                                            TextEditingController controller =
                                                TextEditingController(
                                                    text: currentUser
                                                            .firstName +
                                                        '  ' +
                                                        currentUser.lastName);
                                            return _alertDialog(
                                                controller,
                                                cubit,
                                                currentUser,
                                                'update name', () {
                                              var name =
                                                  controller.text.split(' ');
                                              debugPrint(name.toString());
                                              var firstName = name.removeAt(
                                                  0); // the substring before space in controller
                                              String lastName = name.join(
                                                  ''); // rest of the string after space in controller

                                              debugPrint(lastName);
                                              cubit
                                                  .updateProfileData(
                                                      currentUser: currentUser,
                                                      firstName: firstName,
                                                      lastName: lastName)
                                                  .then((value) {
                                                Navigator.pop(context);
                                              });
                                            });
                                          },
                                        );
                                      },
                                    ),
                                    _editDataCard(
                                      title: 'Change Email',
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            TextEditingController controller =
                                                TextEditingController(
                                                    text: currentUser.email);
                                            return _alertDialog(
                                                controller,
                                                cubit,
                                                currentUser,
                                                'update email', () {
                                              cubit
                                                  .updateProfileData(
                                                      currentUser: currentUser,
                                                      email: controller.text)
                                                  .then((value) {
                                                Navigator.pop(context);
                                              });
                                            });
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        right: 0,
                        top: 20,
                        child: Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  AppStrings.token = '';
                                  CasheHelper.clearCashe(
                                      key: AppStrings.tokenKey);
                                  CasheHelper.clearCashe(
                                      key: AppStrings.searchListKey);

                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.auth);
                                },
                                icon: const Icon(
                                  Icons.exit_to_app,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.posts,
                                  );
                                },
                                icon: const Icon(
                                  Icons.message_rounded,
                                  color: Colors.white,
                                ))
                          ],
                        )),
                  ],
                ))
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Positioned _image(User currentUser) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 40.h,
        width: 100.h,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(currentUser.imageUrl),
              opacity: 0.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                maxRadius: 80,
                backgroundImage: NetworkImage(currentUser.imageUrl)),
            // _space(2),
            Text(
              currentUser.firstName + ' ' + currentUser.lastName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  AlertDialog _alertDialog(
    TextEditingController controller,
    ProfileCubit cubit,
    User currentUser,
    String description,
    VoidCallback onTap,
  ) {
    debugPrint(controller.text);
    return AlertDialog(
      actions: [TextButton(onPressed: onTap, child: const Text('update'))],
      content: TextFormField(
        controller: controller,
      ),
      title: Text(description),
    );
  }

  Widget _editDataCard({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 10.h,
        width: 100.w,
        decoration: BoxDecoration(
            borderRadius: AppStyles.borderRadiusBig,
            border: Border.all(width: 1, color: Colors.grey.shade500)),
        child: Row(
          children: [
            const Icon(Icons.add_road_rounded),
            const SizedBox(
              width: 10,
            ),
            Text(title),
            const Spacer(),
            const Icon(Icons.arrow_right_alt_sharp)
          ],
        ),
      ),
    );
  }

  SizedBox _space(int num) {
    return SizedBox(
      height: num.h,
    );
  }
}
