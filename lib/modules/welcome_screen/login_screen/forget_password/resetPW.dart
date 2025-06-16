import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/cubit/cubit.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/forget_password/RPW_cubit/RPW_cubit/reset_pw_cubit.dart';

import '../../../../Component/text_field_button_component.dart';
import '../login.dart';

class Resetpw extends StatefulWidget {

  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController confirmPasswordController = TextEditingController();
  static final formKey = GlobalKey<FormState>();

  const Resetpw({super.key});

  @override
  State<Resetpw> createState() => _ResetpwState();
}

class _ResetpwState extends State<Resetpw> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPwCubit(),
      child: BlocConsumer<ResetPwCubit, ResetPwState>(
        listener: (context, state) {
          if (state is ResetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
          }
          if(state is ResetWithError){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          if(state is ResetLoading){
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: Resetpw.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "Assets/logo_login_screen.png",
                      height: 100,
                    ),
                    const SizedBox(height: 40),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ENTER YOUR NEW PASSWORD",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    defaultFormField(
                      controller: Resetpw.passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Password must not be empty';
                        }
                        return null;
                      },
                      label: "Password",
                      prefix: Icons.lock_outline_rounded,
                      suffix: ResetPwCubit.get(context).ispassword
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      ispassword: ResetPwCubit.get(context).ispassword,
                      suffixpressed: () {
                        ResetPwCubit.get(context).togel_see_password();
                      },
                    ),
                    const SizedBox(height: 20),
                    defaultFormField(
                      controller: Resetpw.confirmPasswordController,
                      type: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != Resetpw.passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      label: "CONFIRM PASSWORD",
                      prefix: Icons.lock_outline_rounded,
                      suffix: ResetPwCubit.get(context).ispassword
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      ispassword: ResetPwCubit.get(context).ispassword,
                      suffixpressed: () {
                        ResetPwCubit.get(context).togel_see_password();
                      },
                    ),
                    const SizedBox(height: 40),
                    defaultButton(
                      width: double.infinity,
                      background: Colors.blue,
                      function: () {
                        if (Resetpw.formKey.currentState!.validate()) {
                          context.read<ResetPwCubit>().ResetPW(
                            password: Resetpw.passwordController.text,
                            confirmPass: Resetpw.confirmPasswordController.text
                          );

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          });
                        }
                      },
                      text: "Reset",
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