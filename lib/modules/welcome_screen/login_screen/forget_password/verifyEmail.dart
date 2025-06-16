import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/Component/text_field_button_component.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/forget_password/RPW_cubit/RPW_cubit/reset_pw_cubit.dart';
import 'package:nexgen/modules/welcome_screen/login_screen/forget_password/verifyCode.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  static final TextEditingController emailController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPwCubit(),
      child: BlocConsumer<ResetPwCubit, ResetPwState>(
        listener: (context, state) {
          if (state is EmailSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            // تأجيل التنقل بعد انتهاء هذا الفريم
          }

          if (state is EmailWithError) {
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
                  key: VerifyEmail.formKey,
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
                        controller: VerifyEmail.emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "email must not be empty";
                          }
                          return null;
                        },
                        label: 'Email',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(height: 40),
                      state is EmailLoading
                          ? const CircularProgressIndicator()
                          : defaultButton(
                        width: 180,
                        background:
                        const Color.fromARGB(255, 0, 54, 106),
                        function: () {
                          if (VerifyEmail.formKey.currentState!.validate()) {
                            context
                                .read<ResetPwCubit>()
                                .forgetPW(email: VerifyEmail
                                .emailController.text);

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const VerifyCode()),
                              );
                            });
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
      ),
    );
  }
}