import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Component/text_field_button_component.dart';
import '../../../../shared/cubit/Auth/auth_cubit.dart';
import 'VerifyCode.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgetSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("code email is on the way!")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const VerifyCode()),
          );
        } else if (state is ForgetWithError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'Assets/logo_login_screen.png',
                      height: 100,
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Enter your email',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Georgia',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 30),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Email must not be empty";
                        }
                        return null;
                      },
                      label: 'Email',
                      prefix: Icons.email_outlined,
                    ),
                    const SizedBox(height: 40),
                    if (state is ForgetLoading)
                      const CircularProgressIndicator()
                    else
                      defaultButton(
                        width: 180,
                        background: const Color.fromARGB(255, 0, 54, 106),
                        function: () {
                          if (formKey.currentState!.validate()) {
                            context
                                .read<AuthCubit>()
                                .forget(email: emailController.text);
                          }
                        },
                        text: "Send Code",
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
