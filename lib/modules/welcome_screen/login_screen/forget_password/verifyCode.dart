import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Component/text_field_button_component.dart';
import '../../../../shared/cubit/Auth/auth_cubit.dart';
import 'Resetpw.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is CodeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Code is valid!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Resetpw()),
          );
        } else if (state is CodeWithError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'Assets/logo_login_screen.png',
                      height: 100,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Enter your code',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Georgia',
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'CODE SENT TO YOUR EMAIL',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Georgia',
                      ),
                    ),
                    const Text(
                      'EXAMPLE: NAMEME@GMAIL.COM',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Georgia',
                      ),
                    ),
                    const SizedBox(height: 30),
                    defaultFormField(
                      controller: codeController,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Code is required";
                        }
                        return null;
                      },
                      label: "Code",
                      prefix: Icons.numbers,
                    ),
                    const SizedBox(height: 40),
                    state is CodeLoading
                        ? const CircularProgressIndicator()
                        : defaultButton(
                      width: 200,
                      background: const Color(0xFF002D5C),
                      function: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().code(
                            code: codeController.text,
                          );
                        }
                      },
                      text: 'VERIFY',
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
