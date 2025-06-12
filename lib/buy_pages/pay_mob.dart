import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'details_payment.dart';

class PayMob extends StatefulWidget {
  @override
  _PayMobState createState() => _PayMobState();
}

class _PayMobState extends State<PayMob> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PayMob')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (CreditCardBrand brand) {},

            ),
            CreditCardForm(
              formKey: formKey,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: onCreditCardModelChange,
              obscureCvv: false,
              obscureNumber: false,
            ),
           Padding(
             padding: const EdgeInsets.only(top: 10,bottom: 10),
             child: Container(
               width: 280,
               height: 50,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12),
                 gradient: LinearGradient(colors: [
                   Color(0xFF5785FF),
                   Color(0xFF002A99),
                 ])
               ),
               child: MaterialButton(
                 onPressed: () {
                   if (formKey.currentState!.validate()) {
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => DetailsPayment()),
                     );
                   }
                   else {
                     print('Validation Failed');

                   }
                 },

                 child: Text(
                   "Buy Now",style: TextStyle(
                     color: Colors.white,
                     fontWeight: FontWeight.w700,
                     fontSize: 15),
                 ),
               ),
             ),
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_clock_sharp,
                  color: Colors.black45,),
                Text("Secured by Paymob",
                  style: TextStyle(color: Colors.black45),)
              ],
            )
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel data) {
    setState(() {
      cardNumber = data.cardNumber;
      expiryDate = data.expiryDate;
      cardHolderName = data.cardHolderName;
      cvvCode = data.cvvCode;
      isCvvFocused = data.isCvvFocused;
    });
  }
}