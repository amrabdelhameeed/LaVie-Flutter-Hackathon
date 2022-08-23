import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.title,
      this.regExpForValidation = '',
      this.isPassword = false,
      this.minLines = 1})
      : super(key: key);
  final bool isPassword;
  final TextEditingController controller;
  final String title;
  final String regExpForValidation;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0.25.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(
            height: 0.52.h,
          ),
          TextFormField(
            minLines: minLines,
            maxLines: minLines,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'value is empty !';
              } else if (!RegExp(regExpForValidation).hasMatch(value)) {
                return 'please enter a valid value !';
              } else {
                return null;
              }
            },
            style: const TextStyle(fontSize: 16),
            obscureText: isPassword,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 2.w)),
            controller: controller,
          ),
        ],
      ),
    );
  }
}
