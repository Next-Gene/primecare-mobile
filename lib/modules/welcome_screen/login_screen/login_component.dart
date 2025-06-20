import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/Component/design_card.dart';
import 'package:nexgen/Component/text_field_button_component.dart';
import 'package:nexgen/layout/home_navigation_bar.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/cubit/cubit.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/cubit/states.dart';

class LoginComponent extends StatelessWidget {
  LoginComponent({super.key});

  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Success")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeNavBar()),
            );
          } else if (state is LoginWithError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login Failed: ${state.errMessage}")),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0x330098FF),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: sigin_card(
                                  Text1: "Login with Google",
                                  icon: Image.asset("Assets/google.png", width: 27, height: 26),
                                ),
                              ),
                            ),
                            Container(
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: sigin_card(
                                  Text1: "Login with Apple",
                                  icon: Image.asset("Assets/apple.png", width: 27, height: 26),
                                ),
                              ),
                            ),
                            const Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Divider(color: Colors.black38, thickness: 1),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("or Continue with email"),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Divider(color: Colors.grey, thickness: 1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value!.isEmpty) return 'Email must not be empty';
                                  return null;
                                },
                                label: "Email Address",
                                prefix: Icons.mail_outline_outlined,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: defaultFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                validate: (value) {
                                  if (value!.isEmpty) return 'Password must not be empty';
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
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 12, left: 30),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40, top: 20),
                              child: defaultButton(
                                width: 239,
                                background: const Color(0xFF0098FF),
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).login();
                                  }
                                },
                                text: "Login",
                              ),
                            ),
                            const Text(
                              "By signing in with an account, you agree to SO's",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.black38,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 50, left: 90),
                              child: Row(
                                children: [
                                  Text(
                                    "Terms of Service ",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text("  and  ",
                                      style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.w400)),
                                  Text(
                                    "Privacy Policy",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (state is LoginLoading)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: CircularProgressIndicator(),
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
