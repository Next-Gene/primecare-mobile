import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../buy_pages/buy_now.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import 'model_product.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final images = product.productPhotos;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.black12,
      ),
      body: BlocListener<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AddToCartSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("تمت إضافة المنتج إلى السلة"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is AddToCartErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("فشل في إضافة المنتج: ${state.error}"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Column(
          children: [
            Container(
              color: Colors.white12,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 340,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: images.map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      url,
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text("EGP ${product.price}", style: const TextStyle(fontSize: 20, color: Colors.green)),
                      const SizedBox(height: 16),
                      const Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: 6),
                      Text(product.description, style: const TextStyle(fontSize: 17)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      margin: const EdgeInsets.only(left: 35),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
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
                              builder: (context) =>  BuyNow(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
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
                  const SizedBox(width: 15),



                  Container(
                    width: 45,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xA3D9D9D9),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined, color: Colors.lightBlue),
                      onPressed: () {
                        final productData = {
                          "productId": product.id,   // تأكد إن هذا هو معرف المنتج الصحيح
                          "quantity": 1,
                        };

                        AppCubit.get(context).addToCart(productData).then((_) {
                          // بعد الإضافة بنجيب بيانات السلة من جديد للتحديث
                          AppCubit.get(context).getCartItems();
                        });
                      },
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
