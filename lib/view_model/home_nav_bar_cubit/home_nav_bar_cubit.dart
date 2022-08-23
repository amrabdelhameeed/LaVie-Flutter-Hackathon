import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/model/detailed_product.dart';
import 'package:la_vie/model/filter_model.dart';
import 'package:la_vie/model/product.dart';
import 'package:la_vie/view/screens/blogs/blogs_screen.dart';
import 'package:la_vie/view/screens/home/nav_bar/home.dart';
import 'package:la_vie/view/screens/notifications/notification_screen.dart';
import 'package:la_vie/view/screens/profile/profile_screen.dart';
import 'package:meta/meta.dart';

part 'home_nav_bar_state.dart';

class HomeNavBarCubit extends Cubit<HomeNavBarState> {
  HomeNavBarCubit() : super(HomeNavBarInitial());
  static HomeNavBarCubit get(context) => BlocProvider.of(context);
  int currentIndex = 2;
  List<Widget> navBarScreens = [
    BlogsScreen(),
    Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.green,
    ),
    Home(),
    NotificationScreen(),
    ProfileScreen()
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(NavBarChangeIndexState());
    print(index);
  }
}
