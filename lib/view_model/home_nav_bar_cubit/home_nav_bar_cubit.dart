import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/view/screens/home/home.dart';
import '../../view/screens/blogs/blogs_screen.dart';
import '../../view/screens/notifications/notification_screen.dart';
import '../../view/screens/profile/profile_screen.dart';
import '../../view/screens/qr_code/qr_code_screen.dart';

part 'home_nav_bar_state.dart';

class HomeNavBarCubit extends Cubit<HomeNavBarState> {
  HomeNavBarCubit() : super(HomeNavBarInitial());
  static HomeNavBarCubit get(context) => BlocProvider.of(context);
  int currentIndex = 2;
  List<Widget> navBarScreens = const [
    BlogsScreen(),
    QrCode(),
    Home(),
    NotificationScreen(),
    ProfileScreen()
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(NavBarChangeIndexState());
    debugPrint(index.toString());
  }
}
