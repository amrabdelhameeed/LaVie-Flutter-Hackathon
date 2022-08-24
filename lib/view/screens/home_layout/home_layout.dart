import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../../core/app_images.dart';
import '../../../view_model/home_nav_bar_cubit/home_nav_bar_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
    ) {
      final bool connected = connectivity != ConnectivityResult.none;
      return new Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            height: 24.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
              child: Center(
                child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
              ),
            ),
          ),
          Center(
            child: new Text(
              'Yay!',
            ),
          ),
        ],
      );
    }, child: BlocBuilder<HomeNavBarCubit, HomeNavBarState>(
      builder: (context, state) {
        var cubit = HomeNavBarCubit.get(context);

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              cubit.changeIndex(2);
            },
            child: Image.asset(AppImages.homeIcon),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            notchMargin: 10,
            shape: const CircularNotchedRectangle(),
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        cubit.changeIndex(0);
                      },
                      child: Image.asset(AppImages.leave)),
                  InkWell(
                      onTap: () {
                        cubit.changeIndex(1);
                      },
                      child: Image.asset(AppImages.qrCode)),
                  const SizedBox.shrink(), // space for FAB button
                  InkWell(
                      onTap: () {
                        cubit.changeIndex(3);
                      },
                      child: Image.asset(AppImages.notification)),
                  InkWell(
                      onTap: () {
                        cubit.changeIndex(4);
                      },
                      child: Image.asset(AppImages.profile))
                ],
              ),
            ),
          ),
          body: cubit.navBarScreens[cubit.currentIndex],
        );
      },
    ));
  }
}
