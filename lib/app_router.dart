import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/app_images.dart';
import 'package:la_vie/core/app_repository.dart';
import 'package:la_vie/core/app_routes.dart';
import 'package:la_vie/core/app_web_services.dart';
import 'package:la_vie/model/blog.dart';
import 'package:la_vie/model/product.dart';
import 'package:la_vie/view/screens/auth/auth_screen.dart';
import 'package:la_vie/view/screens/blogs/blog_screen.dart';
import 'package:la_vie/view/screens/blogs/blogs_screen.dart';
import 'package:la_vie/view/screens/cart/cart_screen.dart';
import 'package:la_vie/view/screens/home/home_layout.dart';
import 'package:la_vie/view/screens/notifications/notification_screen.dart';
import 'package:la_vie/view/screens/posts/create_post_screen.dart';
import 'package:la_vie/view/screens/posts/posts_screen.dart';
import 'package:la_vie/view/screens/product/product_deatils.dart';
import 'package:la_vie/view/screens/profile/profile_screen.dart';
import 'package:la_vie/view/screens/search/search_screen.dart';
import 'package:la_vie/view_model/auth_cubit/auth_cubit.dart';
import 'package:la_vie/view_model/cart_cubit/cart_cubit.dart';
import 'package:la_vie/view_model/home_cubit/home_cubit.dart';
import 'package:la_vie/view_model/home_nav_bar_cubit/home_nav_bar_cubit.dart';
import 'package:la_vie/view_model/posts_cubit/posts_cubit.dart';
import 'package:la_vie/view_model/search_cubit/search_cubit.dart';

class AppRouter {
  late AppWebServices webServices;
  late HomeCubit homeCubit;
  late AppRepository repository;

  AppRouter() {
    webServices = AppWebServices();
    repository = AppRepository(webServices);
    homeCubit = HomeCubit(webServices: webServices, appRepository: repository);
  }
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.auth:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(webServices: webServices),
              child: AuthScreen(),
            );
          },
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<HomeNavBarCubit>(
              create: (context) => HomeNavBarCubit(),
              child: BlocProvider<HomeCubit>.value(
                value: homeCubit..getProducts(),
                child: HomeLayout(),
              ),
            );
          },
        );
      case AppRoutes.search:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<HomeCubit>.value(
              value: homeCubit,
              child: BlocProvider<SearchCubit>(
                create: (context) => SearchCubit(),
                child: SearchScreen(),
              ),
            );
          },
        );
      case AppRoutes.productDetails:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<HomeCubit>.value(
              value: homeCubit,
              child: ProductDetails(
                  product: Product(
                      type: '',
                      description: '',
                      id: '5',
                      name: 'name',
                      price: 250,
                      imageUrl: AppImages.facebook)),
            );
          },
        );
      case AppRoutes.cart:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<HomeCubit>.value(
              value: homeCubit,
              child: CartScreen(),
            );
          },
        );
      case AppRoutes.createPost:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<PostsCubit>(
              create: (context) => PostsCubit(webServices: webServices),
              child: CreatePostScreen(),
            );
          },
        );
      case AppRoutes.posts:
        return MaterialPageRoute(
          builder: (context) {
            return PostsScreen();
          },
        );
      // case AppRoutes.profile:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return ProfileScreen();
      //     },
      //   );
      case AppRoutes.notification:
        return MaterialPageRoute(
          builder: (context) {
            return NotificationScreen();
          },
        );
      // case AppRoutes.blogs:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return BlogsScreen();
      //     },
      //   );
      case AppRoutes.blog:
        return MaterialPageRoute(
          builder: (context) {
            final blog = settings.arguments as Blog;
            return BlogScreen(
              blog: blog,
            );
          },
        );
    }
  }
}
