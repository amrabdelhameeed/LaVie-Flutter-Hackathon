import 'package:flutter/material.dart';
import 'package:la_vie/core/app_images.dart';
import 'package:sizer/sizer.dart';

class AppBarWithLogo extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithLogo(
      {Key? key,
      this.bottom,
      this.imageLogo = AppImages.logo,
      this.toolbarHeight = 150,
      this.appBarHeight = 150})
      : super(key: key);
  final PreferredSizeWidget? bottom;
  final String imageLogo;
  final double toolbarHeight;
  final double appBarHeight;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        bottom: bottom ??
            const PreferredSize(
                preferredSize: Size.fromHeight(0), child: SizedBox.shrink()),
        toolbarHeight: toolbarHeight,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Image.asset(
          imageLogo,
          width: 30.w,
          height: 9.h,
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
