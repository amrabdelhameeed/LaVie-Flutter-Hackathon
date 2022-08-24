import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/view/screens/home_layout/home_layout.dart';

import 'core/app_repository.dart';
import 'core/app_routes.dart';
import 'core/app_web_services.dart';
import 'model/blog.dart';
import 'model/detailed_product.dart';
import 'view/screens/auth/auth_screen.dart';
import 'view/screens/auth/forget_password.dart';
import 'view/screens/auth/otp_screen.dart';
import 'view/screens/auth/reset_password_screen.dart';
import 'view/screens/blogs/blog_screen.dart';
import 'view/screens/cart/cart_screen.dart';
import 'view/screens/notifications/notification_screen.dart';
import 'view/screens/posts/create_post_screen.dart';
import 'view/screens/posts/posts_screen.dart';
import 'view/screens/product/product_deatils.dart';
import 'view/screens/search/search_screen.dart';
import 'view_model/auth_cubit/auth_cubit.dart';
import 'view_model/home_cubit/home_cubit.dart';
import 'view_model/home_nav_bar_cubit/home_nav_bar_cubit.dart';
import 'view_model/posts_cubit/posts_cubit.dart';
import 'view_model/search_cubit/search_cubit.dart';

class AppRouter {
  late AppWebServices webServices;
  late HomeCubit homeCubit;
  late AppRepository repository;
  late PostsCubit postscubit;

  AppRouter() {
    webServices = AppWebServices();
    repository = AppRepository(webServices);
    homeCubit = HomeCubit(appRepository: repository);
    postscubit = PostsCubit(webServices: webServices, repository: repository);
  }
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.auth:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(webServices: webServices),
              child: const AuthScreen(),
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
                child: const HomeLayout(),
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

      //this screen ready to work but i dont have a qr code to test with
      case AppRoutes.productDetails:
        return MaterialPageRoute(
          builder: (context) {
            final detaildProduct = settings.arguments as DetailedProduct;
            return BlocProvider<HomeCubit>.value(
              value: homeCubit,
              child: ProductDetails(product: detaildProduct),
            );
          },
        );
      case AppRoutes.cart:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<HomeCubit>.value(
              value: homeCubit,
              child: const CartScreen(),
            );
          },
        );
      case AppRoutes.createPost:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<PostsCubit>.value(
              value: postscubit,
              child: CreatePostScreen(),
            );
          },
        );
      case AppRoutes.posts:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<PostsCubit>.value(
              value: postscubit..getAllPosts(),
              child: const PostsScreen(),
            );
          },
        );
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(webServices: webServices),
              child: ForgetPasswordScreen(),
            );
          },
        );
      case AppRoutes.verifyOtp:
        return MaterialPageRoute(
          builder: (context) {
            final email = settings.arguments as String;
            return BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(webServices: webServices),
              child: OtpScreen(email: email),
            );
          },
        );
      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (context) {
            final args = settings.arguments as List<String>;
            return BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(webServices: webServices),
              child: ResetPasswordScreen(
                arguments: args,
              ),
            );
          },
        );
      case AppRoutes.notification:
        return MaterialPageRoute(
          builder: (context) {
            return const NotificationScreen();
          },
        );
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
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text('Nothing here'),
          ),
        );
      },
    );
  }
}
