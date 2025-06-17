import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Component/text_field_button_component.dart';
import '../../../../shared/cubit/Auth/auth_cubit.dart';
import '../login.dart';

class Resetpw extends StatefulWidget {
  const Resetpw({super.key});

  @override
  State<Resetpw> createState() => _ResetpwState();
}

class _ResetpwState extends State<Resetpw> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password reset!')),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
          );
        } else if (state is ResetWithError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
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
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password must not be empty';
                      }
                      return null;
                    },
                    label: "Password",
                    prefix: Icons.lock_outline_rounded,
                    suffix: cubit.isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.remove_red_eye,
                    ispassword: cubit.isPasswordVisible,
                    suffixpressed: () {
                      cubit.togglePasswordVisibility();
                    },
                  ),
                  const SizedBox(height: 20),
                  defaultFormField(
                    controller: confirmPasswordController,
                    type: TextInputType.visiblePassword,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    label: "Confirm Password",
                    prefix: Icons.lock_outline_rounded,
                    suffix: cubit.isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.remove_red_eye,
                    ispassword: cubit.isPasswordVisible,
                    suffixpressed: () {
                      cubit.togglePasswordVisibility();
                    },
                  ),
                  const SizedBox(height: 40),
                  state is ResetLoading
                      ? const CircularProgressIndicator()
                      : defaultButton(
                    width: double.infinity,
                    background: Colors.blue,
                    function: () {
                      if (formKey.currentState!.validate()) {
                        cubit.reset(
                          password: passwordController.text,
                          repassword: confirmPasswordController.text,
                        );
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
    );
  }
}
