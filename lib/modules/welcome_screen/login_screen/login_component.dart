import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/Component/design_card.dart';
import 'package:nexgen/Component/text_field_button_component.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/cubit/cubit.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/cubit/states.dart';

import '../../../layout/home_navigation_bar.dart';
import 'forget_password/verifyEmail.dart';

class LoginComponent extends StatefulWidget {
  LoginComponent({super.key});

  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccess){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
          }
          if(state is LoginWithError){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          if(state is LoginLoading){
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0x330098FF),
              child: Form(
                key: LoginComponent.formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
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
                                    child: Divider(
                                      color: Colors.black38,
                                      thickness: 1,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Text("or Continue with email"),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: defaultFormField(
                                  controller: LoginComponent.emailController,
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
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: defaultFormField(
                                controller: LoginComponent.passwordController,
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
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(top: 12, left: 30),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigate to forgot password screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const VerifyEmail()),
                                    );
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      // Your existing text style
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: defaultButton(
                                width: 239,
                                background: const Color(0xFF0098FF),
                                function: () {
                                  if (LoginComponent.formKey.currentState!.validate()) {
                                    context.read<LoginCubit>().login(
                                      password: LoginComponent.passwordController.text,
                                      email: LoginComponent.emailController.text
                                    );

                                    WidgetsBinding.instance.addPostFrameCallback((_){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const HomeNavBar(),)
                                      );
                                    });
                                  }
                                },
                                text: "Login",
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
        },
      ),
    );
  }
}
