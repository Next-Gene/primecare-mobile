import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:nexgen/home_page/home.dart';
import '../Component/buildTimelineStep.dart';
import 'list_details_product.dart';

class DetailsPayment extends StatelessWidget {
  DetailsPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderHeader(),
                  Container(
                    height: 190,
                    child: Row(
                      children: [
                        buildTimelineStep(
                          title: "Order Confirmed ",
                          subtitle: "8:AM,Feb8,2025",
                          isFirst: true,
                          isActive: true,
                        ),
                        buildTimelineStep(
                          title: "Shipping",
                          subtitle: "With Fedx",
                          isActive: true,
                        ),
                        buildTimelineStep(
                          title: "To Delivered",
                          subtitle: "Expected Time : Feb 15,2025",
                          isLast: true,
                          isActive: false,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Courier name',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 28,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: const Center(
                                child: Text(
                                  'Mohamed hazem',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            const Text(
                              'Tracking Number',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 28,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: const Center(
                                child: Text(
                                  'SS43TAX3321',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, bottom: 20),
                    child: Text(
                      "Item Order",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent.shade100,
                borderRadius:  BorderRadius.circular(30),
              ),
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 85,
                          child: Row(
                            children: [
                              Image.asset(product['image'], ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'] ?? 'No Name',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      product['desc'] ?? 'No Description',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "\$${product['price'] ?? '0'}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSummaryRow("Subtotal", "\$152"),
                  _buildSummaryRow("Delivery", "\$10"),
                  _buildSummaryRow("Tax", "\$5"),
                  const Divider(color: Colors.white70, thickness: 1, height: 30),
                  _buildSummaryRow("Total", "\$167", isTotal: true),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Center(
                child: Container(
                  width: 217,
                  height: 40,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors:
                      [
                        Color(0xFF5785FF),
                        Color(0xFF002A99)
                      ]),
                      borderRadius: BorderRadius.circular(13)
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home_page()),
                            (route) => false,
                      );
                    },
                    child: const Text("Home",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

Widget _buildOrderHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Order Details #12344',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'Date : 1/1/2025',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w700,
            color: isTotal ? Colors.white : Colors.white,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.white : Colors.white70,
          ),
        ),
      ],
    ),
  );
}