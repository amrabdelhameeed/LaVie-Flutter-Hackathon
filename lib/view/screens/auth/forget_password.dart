import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_routes.dart';
import '../../../core/widgets/custom-elevated_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../view_model/auth_cubit/auth_cubit.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  getHeight({context}) {
    final height = MediaQuery.of(context).size.height;
    return height;
  }

  getWidth({context}) {
    final width = MediaQuery.of(context).size.width;
    return width;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

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
                  "Forget Password !",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: getHeight(context: context) / 25,
                ),
                Text(
                  'We will send you message via your email ',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: getHeight(context: context) / 50,
                ),
                CustomTextFormField(
                  regExpForValidation:
                      r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$',
                  controller: emailController,
                  title: 'enter your email',
                ),
                SizedBox(
                  height: getHeight(context: context) / 25,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is OTPSentSuccess) {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.verifyOtp,
                          arguments: emailController.text);
                    }
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    var cubit = AuthCubit.get(context);
                    return CustomElevatedButton(
                      text: 'Send',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          cubit.forgetPassword(email: emailController.text);
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
