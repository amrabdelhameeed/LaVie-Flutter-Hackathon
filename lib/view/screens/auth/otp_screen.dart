import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_routes.dart';
import '../../../view_model/auth_cubit/auth_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({
    required this.email,
    Key? key,
  }) : super(key: key);
  late String otpCode;
  final String email;
  final GlobalKey _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
            key: _formkey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildIntroTexts(),
                  const SizedBox(
                    height: 110,
                  ),
                  _buildPhoneFormField(context),
                  const SizedBox(
                    height: 50,
                  ),
                  _buildNextButton(context),
                  _buildPhoneVerficationBloc(),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildIntroTexts() {
    return Column(
      children: [
        const Text(
          "What is your Number ? ",
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: const Text(
            "Please Enter your phone number !",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        )
      ],
    );
  }

  Widget _buildPhoneFormField(BuildContext context) {
    return Container(
      child: PinCodeTextField(
          autoFocus: true,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
              inactiveColor: AppColors.grey,
              borderRadius: BorderRadius.circular(5),
              shape: PinCodeFieldShape.box,
              borderWidth: 1,
              fieldHeight: 50,
              fieldWidth: 40),
          onChanged: (v) {},
          animationType: AnimationType.scale,
          appContext: context,
          length: 6,
          onCompleted: (v) {
            otpCode = v;
          }),
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
        barrierColor: Colors.white.withOpacity(0.0),
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  void _submitOtp(BuildContext context) {
    BlocProvider.of<AuthCubit>(context).submitOtp(otp: otpCode, email: email);
  }

  Widget _buildPhoneVerficationBloc() {
    return BlocListener<AuthCubit, AuthState>(
      child: Container(),
      listener: (context, state) {
        var cubit = AuthCubit.get(context);
        if (state is VerifyOtpSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.resetPassword,
              arguments: [email, otpCode]);
        }
      },
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 50),
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: () {
            // showProgressIndicator(context);
            _submitOtp(context);
          },
          child: const Text(
            "Verify",
            style: TextStyle(fontSize: 16, color: Colors.white),
          )),
    );
  }
}
