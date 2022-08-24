import 'package:flutter/material.dart';
import '../../../core/app_images.dart';
import '../../../core/widgets/appbar_with_logo.dart';
import '../../widgets/auth/custom_tab_view.dart';
import 'package:sizer/sizer.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _backgroundImage(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: _tabView(),
        ),
      ],
    );
  }

  DefaultTabController _tabView() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBarWithLogo(
          toolbarHeight: 27.h,
          appBarHeight: 27.h,
          bottom: const TabBar(
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              indicatorWeight: 3,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: 'SignUp',
                ),
                Tab(
                  text: 'LogIn',
                )
              ]),
        ),
        body: TabBarView(children: [
          RegisterOrLoginView(isRegister: true),
          RegisterOrLoginView(isRegister: false)
        ]),
      ),
    );
  }

  Container _backgroundImage() {
    return Container(
      color: Colors.white,
      child: Image.asset(
        width: double.infinity,
        height: double.infinity,
        AppImages.authScreenBackground,
        fit: BoxFit.fill,
      ),
    );
  }
}
