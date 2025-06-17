import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Component/text_field_button_component.dart';
import '../../../layout/home_navigation_bar.dart';
import '../../../shared/cubit/Auth/auth_cubit.dart';
import '../welcome.dart';

class SignupComponent extends StatefulWidget {
  const SignupComponent({super.key});

  @override
  State<SignupComponent> createState() => _SignupComponentState();
}

class _SignupComponentState extends State<SignupComponent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final repassController = TextEditingController();

  bool isPasswordVisible = false;
  bool isRepasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    fnameController.dispose();
    lnameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    repassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Signed up successfully")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeNavBar()),
          );
        } else if (state is SignupWithError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      builder: (context, state) {
        if(state is SignupLoading){
          return const AnimatedPill();
        }
        final cubit = context.read<AuthCubit>();

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0x330098FF),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 35),
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) =>
                        value!.isEmpty ? 'Nickname must not be empty' : null,
                        label: "Your Nickname",
                        prefix: Icons.person,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: defaultFormField(
                              controller: fnameController,
                              type: TextInputType.name,
                              validate: (value) => value!.isEmpty
                                  ? 'First name must not be empty'
                                  : null,
                              label: 'First Name',
                              prefix: Icons.account_box,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: defaultFormField(
                              controller: lnameController,
                              type: TextInputType.name,
                              validate: (value) => value!.isEmpty
                                  ? 'Last name must not be empty'
                                  : null,
                              label: 'Last Name',
                              prefix: Icons.account_box_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) =>
                        value!.isEmpty ? 'Email must not be empty' : null,
                        label: "Email Address",
                        prefix: Icons.mail_outline_outlined,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) =>
                        value!.isEmpty ? 'Phone must not be empty' : null,
                        label: "Phone Number",
                        prefix: Icons.phone_android,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (value) =>
                        value!.isEmpty ? 'Password must not be empty' : null,
                        label: "Password",
                        prefix: Icons.lock_outline_rounded,
                        suffix: isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                        ispassword: !isPasswordVisible,
                        suffixpressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: defaultFormField(
                        controller: repassController,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          if (value!.isEmpty) return 'Repassword must not be empty';
                          if (value != passwordController.text)
                            return 'Passwords do not match';
                          return null;
                        },
                        label: "Repassword",
                        prefix: Icons.lock_outline_rounded,
                        suffix: isRepasswordVisible
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                        ispassword: !isRepasswordVisible,
                        suffixpressed: () {
                          setState(() {
                            isRepasswordVisible = !isRepasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (state is SignupLoading)
                      const CircularProgressIndicator()
                    else
                      defaultButton(
                        width: 239,
                        background: const Color(0xFF0098FF),
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.signup(
                              email: emailController.text,
                              fname: fnameController.text,
                              lname: lnameController.text,
                              password: passwordController.text,
                              repassword: repassController.text,
                              name: nameController.text,
                              phoneNumber: phoneController.text,
                            );
                          }
                        },
                        text: "Sign UP",
                      ),
                    const SizedBox(height: 20),
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
                          Text(
                            "  and  ",
                            style:
                            TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                          ),
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
          ),
        );
      },
    );
  }
}
