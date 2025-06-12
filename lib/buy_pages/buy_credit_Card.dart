import 'package:flutter/material.dart' show StatefulWidget, TextEditingController, State, FormState, BuildContext, Widget, BoxDecoration, Icon, EdgeInsets, Text, SizedBox, OutlineInputBorder, Color, InputDecoration, LinearGradient, Offset, GlobalKey, MediaQuery, Colors, Container, AssetImage, BoxFit, DecorationImage, BoxShape, Icons, Navigator, IconButton, Positioned, BorderRadius, Radius, CrossAxisAlignment, FontWeight, TextStyle, TextInputType, BorderSide, TextFormField, Expanded, Row, ElevatedButton, RoundedRectangleBorder, Alignment, Curves, Tween, CurveTween, SlideTransition, PageRouteBuilder, MaterialButton, Column, SingleChildScrollView, Form, Stack, Scaffold;
import 'package:flutter/services.dart';

import 'details_payment.dart';

class BuyCreditCard extends StatefulWidget {
  const BuyCreditCard({super.key});

  @override
  State<BuyCreditCard> createState() => _BuyCreditCardState();
}

class _BuyCreditCardState extends State<BuyCreditCard> {
  final _formKey = GlobalKey<FormState>();

  final _cardNumberController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight,
            color: Colors.transparent,
          ),
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
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
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Credit Card",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 33,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Card number",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                        ],
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          filled: true,
                          fillColor: const Color(0x70E2E2E2),
                          hintText: "Enter Card number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: const Icon(Icons.credit_card, color: Colors.deepOrangeAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter card number';
                          } else if (value.length != 16) {
                            return 'Card number must be 16 digits';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(
                            width: 110,
                            child: TextFormField(
                              controller: _cvvController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.cyan),
                                ),
                                hintText: "CVV",
                                filled: true,
                                fillColor: Color(0x70E2E2E2),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter CVV';
                                } else if (value.length != 3) {
                                  return 'Must be 3 digits';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.cyan),
                                ),
                                filled: true,
                                fillColor: const Color(0x70E2E2E2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Enter name",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 200),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "Cancel Payment",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF5785FF),
                                      Color(0xFF002A99),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: const Duration(milliseconds: 500),
                                          pageBuilder: (context, animation, secondaryAnimation) =>  DetailsPayment(),
                                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                            final begin = const Offset(0.0, 1.0);
                                            final end = Offset.zero;
                                            final curve = Curves.ease;
                                            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                            final offsetAnimation = animation.drive(tween);

                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Buy Now",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
