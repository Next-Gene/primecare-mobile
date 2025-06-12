import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Component/text_field_button_component.dart';
import '../../../home_page/home.dart';
import '../../../layout/home_navigation_bar.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignupComponent extends StatelessWidget {
  const SignupComponent({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0x330098FF),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 35,bottom: 35),
                        child: Text("Create Account",
                          style:TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 32,
                            fontWeight: FontWeight.w700
                          ) ,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                        child: defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'name must not be empty';
                              }
                              return null;
                            },
                            label: "Your Nickname ",
                            prefix: Icons.person),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: defaultFormField(
                              controller: nameController,
                              type: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'email must not be empty';
                                }
                                return null;
                              },
                              label: "Email Address",
                              prefix: Icons.mail_outline_outlined),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: BlocBuilder<LoginCubit, LoginStates>(
                          builder: (context, state) {
                            return defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Password must not be empty';
                                }
                                return null;
                              },
                              label: "Password",
                              prefix: Icons.lock_outline_rounded,
                              suffix: LoginCubit.get(context).ispassword
                                  ? Icons.visibility_off
                                  : Icons.remove_red_eye,
                              ispassword: LoginCubit.get(context).ispassword,
                              suffixpressed: () {
                                LoginCubit.get(context).togel_see_password();
                              },
                            );
                          },
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(top: 12, left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: defaultButton(
                          width: 239,
                          background: Color(0xFF0098FF),
                          function: () {
                            if (formKey.currentState!.validate()) {
                              print("Email: \${emailController.text}");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeNavBar(),)
                              );
                            }
                          },
                          text: "Sign UP",
                        ),
                      ),
                      const Text("By signing in with an account, you agree to SO's",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.black38
                        ),
                      ),
                      const Padding(
                        padding:  EdgeInsets.only(bottom: 50,left: 90),
                        child:  Row(
                          children: [
                            Text("Terms of Service ",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13
                              ),),
                            Text("  and  ",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            Text("Privacy Policy",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13
                              ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
