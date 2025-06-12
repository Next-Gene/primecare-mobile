import 'package:flutter/material.dart';
import 'package:nexgen/buy_pages/choose_payment.dart';

import '../Component/TextFieldBuyPage.dart';

class BuyNow extends StatelessWidget {
  BuyNow({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),

          // المحتوى الأبيض تحت الصورة
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text("Shipping", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),

                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.lightBlue.withOpacity(0.4), blurRadius: 10, offset: Offset(2, 5))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            children: [
                              Icon(Icons.home_filled, color: Colors.blue),
                              SizedBox(width: 8),
                              Text("Home", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(Icons.phone, color: Colors.lightBlue),
                              SizedBox(width: 8),
                              Text("01153441070"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.lightBlue),
                              SizedBox(width: 8),
                              Expanded(child: Text("Egypt, Cairo. Elnozhaa")),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        Text("Add New Address", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                        Spacer(),
                        Icon(Icons.gps_fixed, color: Colors.lightBlue),
                      ],
                    ),

                    const SizedBox(height: 20),
                    buildInputField(_nameController, "Full name"),
                    const SizedBox(height: 15),
                    buildInputField(_phoneController, "Phone"),
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(child: buildInputField(_cityController, "City")),
                        const SizedBox(width: 15),
                        Expanded(child: buildInputField(_houseController, "House")),
                      ],
                    ),

                    const SizedBox(height: 15),
                    buildInputField(
                        _addressController,
                        "Road, Area, Building Name"
                    ),

                    const SizedBox(height: 25),
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
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500), // مدة الأنيميشن
                                pageBuilder: (context, animation, secondaryAnimation) => ChoosePayment(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  final offsetAnimation = Tween<Offset>(
                                    begin: Offset(1.0, 0.0), // من اليمين لليسار
                                    end: Offset.zero,
                                  ).animate(CurvedAnimation(
                                    parent: animation, //الانيميشن الاساسي
                                    curve: Curves.easeInOut,// نوع الحركه
                                  ));
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,//الصفحه الجديده الي هنروحلها
                                  );
                                },
                              ),
                            );
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
        ],
      ),
    );
  }
}


