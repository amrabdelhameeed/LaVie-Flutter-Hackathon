import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'core/app_routes.dart';
import 'core/app_strings.dart';
import 'core/cashe_helper.dart';
import 'core/dio_helper.dart';
import 'core/observer.dart';
import 'package:sizer/sizer.dart';

String intialRoute = AppRoutes.auth;
void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CasheHelper.initCasheHelper();
  AppStrings.token = CasheHelper.getStr(key: AppStrings.tokenKey);
  AppStrings.searchList = CasheHelper.getList(key: AppStrings.searchListKey);

  debugPrint(AppStrings.token);
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
        initialRoute: intialRoute,
        theme: ThemeData(primarySwatch: Colors.green),
        onGenerateRoute: appRouter.onGenerateRoute,
      );
    });
  }
}
