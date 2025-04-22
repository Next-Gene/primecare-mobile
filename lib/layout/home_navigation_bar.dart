import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/layout/cubit/cubit.dart';
import 'package:nexgen/layout/cubit/states.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
class HomeNavBar extends StatelessWidget {
  const HomeNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context, state) {} ,
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            // appBar: AppBar(
            //   title: Text("Nav Bar Content Page"),
            // ),
            body:cubit.screens[cubit.selectedIndex], // عرض الصفحة حسب الأيقونة المختارة
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: WaterDropNavBar(
                iconSize: 30,
                backgroundColor: Colors.white,
                waterDropColor: Colors.black,
                barItems: [
                  BarItem(
                    filledIcon: Icons.home_rounded,
                    outlinedIcon: Icons.home_outlined,
                  ),
                  BarItem(
                    filledIcon: Icons.shopping_cart_rounded,
                    outlinedIcon: Icons.shopping_cart_outlined,
                  ),
                  BarItem(
                    filledIcon: Icons.person_rounded,
                    outlinedIcon: Icons.person_outline,
                  ),
                  BarItem(
                    filledIcon: Icons.category_rounded,
                    outlinedIcon: Icons.category_outlined,
                  ),
                ],
                selectedIndex: AppCubit.get(context).selectedIndex,
                onItemSelected: (index) {
                  cubit.change_bottomnav_bar(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
