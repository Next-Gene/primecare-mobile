import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/layout/home_navigation_bar.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/login.dart';

import 'add_to_card/cubit/cubit.dart';
import 'home_page/test.dart';
import 'network_api/remote/dio_Helper.dart';
import 'layout/cubit/cubit.dart'; // ✅ AppCubit

void main() {
  DioHelper.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) {
          final cubit = AppCubit();
          cubit.initToken();       // ✅ تحميل التوكن
          cubit.getCategory();     // ✅ جلب الكاتيجوري
          return cubit;
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(), // 🟢 بعد تسجيل الدخول هتنتقل لـ HomeNavBar
      debugShowCheckedModeBanner: false,
    );
  }
}
