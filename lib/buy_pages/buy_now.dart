import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/buy_pages/choose_payment.dart';
import '../Component/TextFieldBuyPage.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';

class BuyNow extends StatelessWidget {
  BuyNow({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is CheckOutSuccessState) {
          print("✅ Order sent successfully");
          print("Response Data: ${state.data}");
          Navigator.push(context, MaterialPageRoute(builder: (_) => ChoosePayment()));
        } else if (state is CheckOutErrorState) {
          print("❌ Order failed to send");
          print("Error: ${state.error}");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("فشل إرسال الطلب: ${state.error}")),
          );
        }
      },
      builder: (context, state) {
        final cubit = AppCubit.get(context);

        return Scaffold(
          body: Stack(
            children: [
              Container(width: double.infinity, height: MediaQuery.of(context).size.height),
              Container(
                height: 280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/back_buy.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.3),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.3),
                      child: IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 250,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text("Shipping", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                          const SizedBox(height: 30),
                          buildValidatedField(firstNameController, "First Name"),
                          const SizedBox(height: 20),
                          buildValidatedField(lastNameController, "Last Name"),
                          const SizedBox(height: 20),
                          buildValidatedField(streetController, "Street"),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(child: buildValidatedField(cityController, "City")),
                              const SizedBox(width: 15),
                              Expanded(child: buildValidatedField(stateController, "State")),
                            ],
                          ),
                          const SizedBox(height: 20),
                          buildValidatedField(zipCodeController, "Zip Code"),
                          const SizedBox(height: 20),
                          buildValidatedField(phoneController, "Phone", keyboardType: TextInputType.phone),
                          const SizedBox(height: 20),
                          buildValidatedField(emailController, "Email", keyboardType: TextInputType.emailAddress),
                          const SizedBox(height: 30),
                          Center(
                            child: Container(
                              width: screenWidth * 0.65,
                              height: 45,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [Color(0xFF5785FF), Color(0xFF002A99)]),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final orderData = {
                                      "deliveryMethodId": 1,
                                      "shippingAddress": {
                                        "firstName": firstNameController.text,
                                        "lastName": lastNameController.text,
                                        "street": streetController.text,
                                        "city": cityController.text,
                                        "state": stateController.text,
                                        "zipCode": zipCodeController.text,
                                        "phoneNumber": phoneController.text,
                                        "email": emailController.text,
                                      },
                                    };

                                    print("🚀 Sending order: $orderData");
                                    cubit.checkoutOrder(orderData);
                                  }
                                },
                                child: const Text(
                                  "Save and Next",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildValidatedField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}
