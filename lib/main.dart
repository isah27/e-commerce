import 'package:e_commerce/bloc/product/products_cubit.dart';
import 'package:e_commerce/page%20route/detail/route.dart';
import 'package:e_commerce/repo/auth_repo.dart';
import 'package:e_commerce/repo/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:device_preview/device_preview.dart';

import 'bloc/auth/auth_cubit.dart';

void main() {
  runApp(DevicePreview(
      enabled: true,
      builder: (context) {
        return const MyApp();
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(AuthRepository()),
        ),
       BlocProvider(
          create: (context) => ProductsCubit(ProductRepo()),
        ),
      ],
      child:Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: 'eCommerce',
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: AppRoute.onGeneratedRoute);
    }),
    );
  }
}
