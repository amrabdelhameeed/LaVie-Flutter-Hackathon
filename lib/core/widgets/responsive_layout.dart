import 'package:flutter/material.dart';
import 'package:la_vie/core/app_numbers.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(
      {Key? key, required this.mobileView, required this.webView})
      : super(key: key);
  final Widget mobileView;
  final Widget webView;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < AppNumbers.maxWidthOfScreen) {
          return mobileView;
        } else {
          return webView;
        }
      },
    );
  }
}
