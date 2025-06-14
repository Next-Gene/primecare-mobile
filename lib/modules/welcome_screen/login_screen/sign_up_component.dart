import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Component/text_field_button_component.dart';
import '../../../home_page/home.dart';
import '../../../layout/home_navigation_bar.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignupComponent extends StatefulWidget {

  const SignupComponent({super.key});

  @override
  State<SignupComponent> createState() => _SignupComponentState();
}

class _SignupComponentState extends State<SignupComponent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController FnameController = TextEditingController();
  final TextEditingController LnameController = TextEditingController();
  final TextEditingController PhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repassController = TextEditingController();

  bool isPasswordVisible = false;
  bool isRepasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    FnameController.dispose();
    LnameController.dispose();
    passwordController.dispose();
    repassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit, LoginStates>(
  listener: (context, state) {
    if(state is SignupSuccess){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Success")));
    } else if(state is SignupWithError){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.errMessage)));
    }
  },
  builder: (context, state) {
    if(state is SignupLoading){
      Center(
        child: CircularProgressIndicator(),
      );
    }
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 35),
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: defaultFormField(
                    controller: emailController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) return 'Nickname must not be empty';
                      return null;
                    },
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
                          controller: FnameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) return 'First name must not be empty';
                            return null;
                          },
                          label: 'First Name',
                          prefix: Icons.account_box,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: defaultFormField(
                          controller: LnameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) return 'Last name must not be empty';
                            return null;
                          },
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
                    controller: nameController,
                    type: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value!.isEmpty) return 'Email must not be empty';
                      return null;
                    },
                    label: "Email Address",
                    prefix: Icons.mail_outline_outlined,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 30),
                  child: defaultFormField(
                      controller: PhoneController,
                      type: TextInputType.phone,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      label: "Phone Number",
                      prefix: Icons.phone_android)
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    validate: (String? value) {
                      if (value!.isEmpty) return 'Password must not be empty';
                      return null;
                    },
                    label: "Password",
                    prefix: Icons.lock_outline_rounded,
                    suffix: isPasswordVisible ? Icons.visibility_off : Icons.remove_red_eye,
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
                    validate: (String? value) {
                      if (value!.isEmpty) return 'Repassword must not be empty';
                      if (value != passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                    label: "Repassword",
                    prefix: Icons.lock_outline_rounded,
                    suffix: isRepasswordVisible ? Icons.visibility_off : Icons.remove_red_eye,
                    ispassword: !isRepasswordVisible,
                    suffixpressed: () {
                      setState(() {
                        isRepasswordVisible = !isRepasswordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
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
                  padding: const EdgeInsets.only(bottom: 40),
                  child: defaultButton(
                    width: 239,
                    background: const Color(0xFF0098FF),
                    function: () {
                      if (formKey.currentState!.validate()) {
                        context.read<LoginCubit>().signUp(
                            email: emailController.text,
                            fname: FnameController.text,
                            lname: LnameController.text,
                            password: passwordController.text,
                            repassword: repassController.text,
                            userName: nameController.text,
                            phoneNumber: PhoneController.text);
                        print("Email: ${emailController.text}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeNavBar()),
                        );
                      }
                    },
                    text: "Sign UP",
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
                      Text(
                        "  and  ",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
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
),
);
  }
}
