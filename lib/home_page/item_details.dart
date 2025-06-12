import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:nexgen/buy_pages/buy_now.dart';

import '../add_to_card/cubit/cubit.dart';
import '../add_to_card/model.dart';

class ItemDetails extends StatelessWidget {
  final Map<String, dynamic> product;

  const ItemDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: LikeButton(
              size: 30,
              circleColor: const CircleColor(
                start: Colors.red,
                end: Colors.redAccent,
              ),
              bubblesColor: const BubblesColor(
                dotPrimaryColor: Colors.red,
                dotSecondaryColor: Colors.redAccent,
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.blueAccent,
                  size: 30,
                );
              },
              onTap: (bool isLiked) async {
                return !isLiked;
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.share, color: Colors.blueAccent),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Color(0x3A3A303),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 350,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enableInfiniteScroll: true,
                      viewportFraction: 0.85,
                    ),
                    items: product["images"].map<Widget>((imgPath) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          imgPath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // بيانات المنتج
                Container(
                  height: MediaQuery.of(context).size.height - 370 - kToolbarHeight - 20,
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          product["title_product"],
                          style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            "Price Before: \$${product["price_product"]}",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          child: Text(
                            "price: \$${product["price_after_discount"]}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "description:  \$${product["description"]}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        Spacer(),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30,right: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 45,
                                    margin: const EdgeInsets.only(left: 35),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFF5785FF),
                                          Color(0xFF002A99),
                                        ],
                                      ),
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BuyNow(),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ImageIcon(
                                            AssetImage("Assets/icons_buy.png"),
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Buy Now',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // مسافة بسيطة بين الزرين
                                SizedBox(width: 15),

                                // زر السلة
                                Container(
                                  width: 45,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xA3D9D9D9),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.shopping_cart_outlined, color: Colors.lightBlue),
                                    onPressed: () {
                                      final cartCubit = context.read<CartCubit>();
                                      final newItem = CartItem(
                                        name: product["title_product"],
                                        image: product["image_product"],
                                        price: product["price_after_discount"],
                                      );
                                      cartCubit.addItem(newItem);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("تمت إضافة المنتج إلى السلة"),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    },
                                  ),

                                ),
                              ],
                            ),

                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Positioned(
            top: 330,
            right: 16,
            child:
            SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                  child: Text(
                    'Shopping',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
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
