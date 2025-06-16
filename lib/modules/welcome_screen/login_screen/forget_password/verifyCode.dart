import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/forget_password/RPW_cubit/RPW_cubit/reset_pw_cubit.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/forget_password/resetPW.dart';

import '../../../../Component/text_field_button_component.dart';

class VerifyCode extends StatefulWidget {
  static final TextEditingController codeController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  const VerifyCode({super.key});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPwCubit(),
      child: BlocConsumer<ResetPwCubit, ResetPwState>(
        listener: (context, state) {
          if (state is CodeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

          if (state is CodeWithError) {
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
                  key: VerifyCode.formKey,
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
                        controller: VerifyCode.codeController,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Code is incorrect";
                          }
                          return null;
                        },
                        label: "Code",
                        prefix: Icons.numbers,
                      ),
                      const SizedBox(height: 40),

                      // Verify Button or Loading
                      state is CodeLoading
                          ? const CircularProgressIndicator()
                          : defaultButton(
                        width: 200,
                        background: const Color(0xFF002D5C),
                        function: () {
                          if (VerifyCode.formKey.currentState!.validate()) {
                            context.read<ResetPwCubit>().codePW(
                              code:VerifyCode.codeController.text,
                            );

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Resetpw()),
                              );
                            });
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
      ),
    );
  }
}