import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:nexgen/Component/component_category_icon.dart';
import 'package:nexgen/home_page/List.dart';
import 'package:nexgen/home_page/item_details.dart';

import '../Component/desigin_card_product.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';



class Home_page extends StatelessWidget {
  const Home_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 23,
            backgroundColor: Color(0xFF37B2FF),
            child: Image.asset(
              'Assets/setting_home_page.png',
              height: 20,
              width: 20,
            ),
          ),
        ),
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Deliver address',
                style: TextStyle(
                  color: Color(0x54000000),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '92 alomrnia ,giza,egypt',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundColor: Color(0xFFE5E5E5),
                  child: Image.asset(
                    'Assets/notification_home_page.png',
                    height: 20,
                    width: 20,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green,
                  ),
                  width: 10,
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 260,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFEBEBEB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        Icon(Icons.search, color: Colors.grey[700]),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for a product',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Banner
              Stack(
                children: [
                  Container(
                    width: 320,
                    height: 70,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("Assets/back_ground_stack.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            "Delivery is",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "50%",
                              style: TextStyle(
                                color: Color(0xFF37B2FF),
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Text(
                            "Cheaper",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("Assets/img_doctor.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Categories header
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Row(
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              BlocBuilder<AppCubit, AppStates>(
                builder: (context, state) {
                  var cubit = AppCubit.get(context);

                  if (cubit.category.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.category.length,
                      itemBuilder: (context, index) {
                        final item = cubit.category[index];
                        return default_categories_icon(
                          background_color: const Color(0xFFF3F3F3),
                          text1: item['name'],
                          imagePath: item['photoUrl'] ?? 'Assets/default_icon.png',
                        );
                      },
                    ),
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const Text(
                      "Flash sale",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF319FE4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: 75,
                        height: 24,
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "02:59:55",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.black12,
                        child: Icon(Icons.arrow_forward_ios_sharp, size: 15),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      final index_product = products[index];
                      return InkWell(
                        child: design_card_product(
                          image: index_product["image_product"],
                          title: index_product["title_product"],
                          price: index_product["price_product"],
                          priceAfterDiscount: index_product["price_after_discount"],
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemDetails(product: index_product,),));
                        },
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
