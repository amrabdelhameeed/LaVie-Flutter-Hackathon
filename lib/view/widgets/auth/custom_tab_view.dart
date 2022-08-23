import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/app_colors.dart';
import 'package:la_vie/core/app_images.dart';
import 'package:la_vie/core/app_routes.dart';
import 'package:la_vie/core/app_strings.dart';
import 'package:la_vie/view/screens/home/home_layout.dart';
import 'package:la_vie/view_model/auth_cubit/auth_cubit.dart';

import '../../../core/widgets/custom-elevated_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';

class RegisterOrLoginView extends StatelessWidget {
  RegisterOrLoginView({Key? key, required this.isRegister}) : super(key: key);
  final bool isRegister;
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(AppStrings.token);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                children: [
                  _textFormFields(),
                  _loginOrSignUpButton(
                      context: context,
                      firstNameCont: firstNameController,
                      lastNameCont: lastNameController,
                      confirmPasswordCont: confirmPasswordController,
                      emailCont: emailController,
                      passwordCont: passwordController),
                  isRegister ? const SizedBox.shrink() : _foregetPassword(),
                  _continueWithGoogleOrFacebook()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _textFormFields() {
    return Column(
      children: [
        isRegister ? _firstAndLastName() : const SizedBox.shrink(),
        CustomTextFormField(
          controller: emailController,
          title: 'Email',
          regExpForValidation: r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$',
        ),
        CustomTextFormField(
            isPassword: true,
            controller: passwordController,
            regExpForValidation:
                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,32})',
            title: 'Password'),
        isRegister
            ? CustomTextFormField(
                isPassword: true,
                controller: confirmPasswordController,
                regExpForValidation:
                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,32})',
                title: 'Confirm Password')
            : const SizedBox.shrink()
      ],
    );
  }

  Widget _loginOrSignUpButton(
      {required TextEditingController emailCont,
      required TextEditingController firstNameCont,
      required TextEditingController lastNameCont,
      required TextEditingController passwordCont,
      required TextEditingController confirmPasswordCont,
      required BuildContext context}) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoggedInSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pushNamed(context, AppRoutes.home);
        }
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pushNamed(context, AppRoutes.home);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return CustomElevatedButton(
          text: isRegister ? 'Sign Up' : 'Login',
          onTap: () {
            if (formKey.currentState!.validate()) {
              if (passwordController.text != confirmPasswordCont.text &&
                  isRegister) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords don\'t match')));
              } else {
                print('validate');
                if (isRegister) {
                  cubit.signup(
                      firstName: firstNameCont.text,
                      lastName: lastNameCont.text,
                      email: emailCont.text,
                      password: passwordCont.text);
                } else {
                  cubit.login(
                      email: emailCont.text, password: passwordCont.text);
                }
              }
            }
          },
        );
      },
    );
  }

  Row _firstAndLastName() {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
              regExpForValidation: r'^[a-zA-Z\s]*$',
              controller: firstNameController,
              title: 'First name'),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: CustomTextFormField(
              regExpForValidation: r'^[a-zA-Z\s]*$',
              controller: lastNameController,
              title: 'LastName'),
        )
      ],
    );
  }

  Container _foregetPassword() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 5.h,
      child:
          TextButton(onPressed: () {}, child: const Text('Foreget Password ?')),
    );
  }

  Widget _continueWithGoogleOrFacebook() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: AppColors.grey,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: const Center(
                        child: Text(
                      'Or Continue With',
                      style: TextStyle(color: AppColors.grey),
                    )),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    cubit.googleSignIn();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(AppImages.google),
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(AppImages.facebook),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
