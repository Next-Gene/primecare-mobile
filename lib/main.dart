import 'dart:async' as BlocOverriders;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/shared/cubit/Auth/auth_cubit.dart';
import 'package:nexgen/shared/network/DioHelper.dart';
import 'package:nexgen/splash_screen/splash_screen.dart';

import 'add_to_card/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dio
  DioHelper.init();

  // Run app inside BlocOverrides for better debugging (optional)
  BlocOverriders.runZoned(
        () {
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'NexGen App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
