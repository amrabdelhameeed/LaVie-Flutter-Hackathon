import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/app_router.dart';
import 'package:la_vie/core/app_routes.dart';
import 'package:la_vie/core/app_strings.dart';
import 'package:la_vie/core/cashe_helper.dart';
import 'package:la_vie/core/dio_helper.dart';
import 'package:la_vie/core/observer.dart';
import 'package:sizer/sizer.dart';

String intialRoute = AppRoutes.auth;
void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CasheHelper.initCasheHelper();
  AppStrings.token = CasheHelper.getStr(key: AppStrings.tokenKey);
  print(AppStrings.token);
  if (AppStrings.token!.isNotEmpty) {
    intialRoute = AppRoutes.home;
  }
  runApp(
      // DevicePreview(
      //   builder: (context) {
      //     return ;
      //   },
      // ),
      MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        // builder: DevicePreview.appBuilder,
        // locale: DevicePreview.locale(context),
        title: 'La Vie',
        // home: Testaya(),
        initialRoute: intialRoute,
        theme: ThemeData(primarySwatch: Colors.green),
        onGenerateRoute: appRouter.onGenerateRoute,
      );
    });
  }
}
