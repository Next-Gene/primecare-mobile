import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/layout/home_navigation_bar.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/login.dart';

import 'add_to_card/cubit/cubit.dart';
import 'home_page/test.dart';
import 'network_api/remote/dio_Helper.dart';
import 'layout/cubit/cubit.dart'; // ✅ لازم تستورد AppCubit

void main() {
  DioHelper.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => AppCubit()..getCategory()),
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
      home: HomeNavBar(),
     // home: Test(),
      debugShowCheckedModeBanner: false,
    );
  }
}
