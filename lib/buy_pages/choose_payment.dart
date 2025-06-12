import 'package:flutter/material.dart';
import 'package:nexgen/buy_pages/pay_mob.dart';
import 'package:nexgen/home_page/home.dart';

import '../Component/choose_payment_card.dart' show Payment_Card;
import 'buy_credit_Card.dart';
import 'fawry.dart' show OrderDetailsScreen, Fawry;

class ChoosePayment extends StatelessWidget {
  const ChoosePayment({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Container(
            width: double.infinity,
            height: screenHeight,
          ),

          // الصورة العلوية
          Container(
            height: 280,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/back_buy.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // شريط علوي فيه الرجوع والإعدادات
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
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
              child:  Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose Payment option ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 33,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    Center(
                      child: Payment_Card(
                        image_path: "Assets/credit.png",
                        text1: "Debit/Cridet card",
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500), // مدة الحركة
                              pageBuilder: (context, animation, secondaryAnimation) => BuyCreditCard(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                final begin = Offset(0.0, 1.0); // من أسفل الشاشة
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
                        },

                      ),
                    ),
                    Center(
                      child: Payment_Card(
                          image_path: "Assets/bank.png",
                          text1: "Internet Banking"
                      ),
                    ),
                    Center(
                      child: Payment_Card(
                          image_path: "Assets/fawry.png",
                          text1: "Fawry",
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500), // مدة الحركة
                              pageBuilder: (context, animation, secondaryAnimation) => Fawry(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                final begin = Offset(0.0, 1.0); // من أسفل الشاشة
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
                        },
                      ),
                    ),
                    Center(
                      child: Payment_Card(
                          image_path: "Assets/paymob.png",
                          text1: "Pay mob",
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500), // مدة الحركة
                              pageBuilder: (context, animation, secondaryAnimation) => PayMob(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                final begin = Offset(0.0, 1.0); // من أسفل الشاشة
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
                        },
                      ),
                    ),

                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}



