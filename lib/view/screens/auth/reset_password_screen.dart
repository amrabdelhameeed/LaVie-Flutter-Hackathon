import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_routes.dart';
import '../../../core/widgets/custom-elevated_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../view_model/auth_cubit/auth_cubit.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key, required this.arguments}) : super(key: key);
  final List<String> arguments;
  // arguments : first => email , last => otp
  getHeight({context}) {
    final height = MediaQuery.of(context).size.height;
    return height;
  }

  getWidth({context}) {
    final width = MediaQuery.of(context).size.width;
    return width;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: AppColors.primary,
          size: 32,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: getHeight(context: context) / 5,
                ),
                Text(
                  "Reset Password !",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: getHeight(context: context) / 25,
                ),
                Text(
                  'enter a new password',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: getHeight(context: context) / 50,
                ),
                CustomTextFormField(
                  isPassword: true,
                  regExpForValidation:
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,32})',
                  controller: newPasswordController,
                  title: 'enter password',
                ),
                SizedBox(
                  height: getHeight(context: context) / 25,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is ResetPasswordSuccess) {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.auth,
                      );
                    }
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    var cubit = AuthCubit.get(context);
                    return CustomElevatedButton(
                      text: 'Reset',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          cubit.resetPassword(
                              otp: arguments.last,
                              email: arguments.first,
                              newPassword: newPasswordController.text);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
