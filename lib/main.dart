import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/layout/home_navigation_bar.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/login.dart';

import 'add_to_card/cubit/cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => CartCubit(),
      child: const MyApp(),
    ),
  );
}
git config --global user.name "Mohamed-hazem-mohamed"
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
