import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/Component/design_card.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/login_component.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/cubit/cubit.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/cubit/states.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/sign_up_component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener:(context, state) {} ,
        builder: (context, state) {
          return DefaultTabController(
            length: 2,  //  Number of tabs
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Welcome To",
                              style: TextStyle(fontSize: 26,color: Color(0xFF0098FF), ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right: 10),
                            child: Image.asset(
                                "Assets/logo_login_screen.png", // ✅ Fixed path (ensure lowercase "assets/")
                                width: 181,
                                height: 66
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: const Text(
                        "Login or sign up to access your account",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ✅ TabBar should be inside a Column with Expanded TabBarView
                    TabBar(
                      indicator: BoxDecoration(
                        color: Color(0x330098FF), // لون خلفية التبويب النشط
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelColor: Colors.blue, // لون نص التبويب النشط
                      unselectedLabelColor: Colors.black, // لون نص التبويب غير النشط
                      tabs: [
                        Container(
                            width: double.infinity,
                            child: Tab(text: "Login")
                        ),
                        Container(
                            width: double.infinity,
                            child: Tab(text: "Sign Up")
                        ),
                      ],
                    ),

                    //  TabBarView to display content for each tab
                    Expanded(
                      child: TabBarView(
                        children: [
                          Align(
                            alignment: Alignment.topCenter, // ⬅️ يجعل المحتوى يبدأ من الأعلى
                            child: LoginComponent(),
                          ),
                           Align(
                            alignment: Alignment.topCenter, // ⬅️ يجعل النص يبدأ من الأعلى أيضًا
                            child: SignupComponent(),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
